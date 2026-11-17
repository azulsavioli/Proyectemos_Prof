import 'package:cloud_firestore/cloud_firestore.dart';

import 'models.dart';

class RepositoryException implements Exception {
  RepositoryException(this.message);

  final String message;

  @override
  String toString() => message;
}

class RepositoryImpl {
  RepositoryImpl({FirebaseFirestore? firestore})
      : _db = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _db;

  CollectionReference<Map<String, dynamic>> get _schools =>
      _db.collection('escolas');

  Future<List<SchoolRecord>> fetchSchools() {
    return _guard(() async {
      final snapshot = await _schools.get();
      final schools = await Future.wait(
        snapshot.docs.map((doc) async {
          final classCount = await doc.reference.collection('turmas').count().get();
          return SchoolRecord(
            id: doc.id,
            name: _readString(doc.data(), 'schoolName', fallback: 'Escola sem nome'),
            classCount: classCount.count ?? 0,
          );
        }),
      );
      schools.sort(
        (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      );
      return schools;
    });
  }

  Future<List<ClassRoomRecord>> fetchClassRooms(String schoolId) {
    return _guard(() async {
      final snapshot =
          await _schools.doc(schoolId).collection('turmas').get();
      final rooms = await Future.wait(snapshot.docs.map(_classRoomFromDoc));
      rooms.sort(
        (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      );
      return rooms;
    });
  }

  Future<DashboardStats> fetchDashboardStats() {
    return _guard(() async {
      final schools = await fetchSchools();
      var classRooms = 0;
      var teachers = 0;
      for (final school in schools) {
        final rooms = await fetchClassRooms(school.id);
        classRooms += rooms.length;
        for (final room in rooms) {
          teachers += room.teachers.length;
        }
      }
      return DashboardStats(
        schools: schools.length,
        classRooms: classRooms,
        teachers: teachers,
      );
    });
  }

  Future<List<AppNotification>> fetchNotifications() {
    return _guard(() async {
      final snapshot = await _db.collection('notificacoes').limit(100).get();
      final items = snapshot.docs.map((doc) {
        final data = doc.data();
        return AppNotification(
          id: doc.id,
          title: _readString(
            data,
            'title',
            fallback: _readString(data, 'titulo', fallback: 'Notificação'),
          ),
          body: _readString(
            data,
            'body',
            fallback: _readString(
              data,
              'mensagem',
              fallback: _readString(data, 'message'),
            ),
          ),
          createdAt: _readDate(data['createdAt']),
        );
      }).toList();
      items.sort((a, b) {
        final left = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        final right = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        return right.compareTo(left);
      });
      return items;
    });
  }

  Future<void> registerTeacher({
    required String teacherName,
    required String schoolName,
    required String classRoom,
    required String teacherEmail,
  }) {
    return _guard(() async {
      final school = schoolName.trim();
      final roomName = classRoom.trim();
      final schoolId = await _getOrCreateSchoolId(school);
      final classRoomId = await _getOrCreateClassRoomId(schoolId, roomName);
      final teachers = _schools
          .doc(schoolId)
          .collection('turmas')
          .doc(classRoomId)
          .collection('professores');

      final email = teacherEmail.trim();
      final payload = {
        'teacherName': teacherName.trim(),
        'teacherEmail': email,
        'updatedAt': FieldValue.serverTimestamp(),
      };

      final existing = await teachers.get();
      final match = existing.docs.where((doc) {
        return _readString(doc.data(), 'teacherEmail').toLowerCase() ==
            email.toLowerCase();
      });
      if (match.isNotEmpty) {
        await match.first.reference.set(payload, SetOptions(merge: true));
      } else {
        await teachers.add(payload);
      }
    });
  }

  Future<String> _getOrCreateSchoolId(String schoolName) async {
    final snapshot = await _schools.get();
    for (final doc in snapshot.docs) {
      final current = _readString(doc.data(), 'schoolName');
      if (current.toLowerCase() == schoolName.toLowerCase()) {
        return doc.id;
      }
    }
    final created = await _schools.add({
      'schoolName': schoolName,
      'updatedAt': FieldValue.serverTimestamp(),
    });
    return created.id;
  }

  Future<String> _getOrCreateClassRoomId(
    String schoolId,
    String classRoom,
  ) async {
    final rooms = _schools.doc(schoolId).collection('turmas');
    final snapshot = await rooms.get();
    for (final doc in snapshot.docs) {
      final current = _classRoomName(doc.data());
      if (current.toLowerCase() == classRoom.toLowerCase()) {
        return doc.id;
      }
    }
    final created = await rooms.add({
      'classRoom': classRoom,
      'updatedAt': FieldValue.serverTimestamp(),
    });
    return created.id;
  }

  Future<ClassRoomRecord> _classRoomFromDoc(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) async {
    final teachersSnapshot = await doc.reference.collection('professores').get();
    final teachers = teachersSnapshot.docs.map((teacher) {
      final data = teacher.data();
      return TeacherRecord(
        name: _readString(
          data,
          'teacherName',
          fallback: _readString(data, 'nome', fallback: 'Professor(a)'),
        ),
        email: _readString(
          data,
          'teacherEmail',
          fallback: _readString(data, 'email'),
        ),
      );
    }).toList();

    return ClassRoomRecord(
      id: doc.id,
      name: _classRoomName(doc.data()),
      teachers: teachers,
    );
  }

  String _classRoomName(Map<String, dynamic> data) {
    return _readString(
      data,
      'classRoom',
      fallback: _readString(data, 'className', fallback: 'Turma sem nome'),
    );
  }

  String _readString(
    Map<String, dynamic> data,
    String key, {
    String fallback = '',
  }) {
    final value = data[key];
    if (value is String && value.trim().isNotEmpty) {
      return value.trim();
    }
    return fallback;
  }

  DateTime? _readDate(Object? value) {
    if (value is Timestamp) {
      return value.toDate();
    }
    if (value is DateTime) {
      return value;
    }
    return null;
  }

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on RepositoryException {
      rethrow;
    } on FirebaseException catch (error) {
      throw RepositoryException(_firebaseMessage(error));
    }
  }

  String _firebaseMessage(FirebaseException error) {
    switch (error.code) {
      case 'permission-denied':
        return 'Sem permissão para acessar esses dados. Confira as regras do Firestore.';
      case 'unavailable':
        return 'O Firestore está indisponível. Tente de novo em instantes.';
      default:
        return 'Não foi possível falar com o Firebase (${error.code}).';
    }
  }
}
