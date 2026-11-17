import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/auth_services.dart';

class RepositoryImpl extends ChangeNotifier {
  AuthService authService = AuthService();

  // Obtém ou cria uma nova escola e retorna o ID da escola
  Future<String> getOrCreateSchoolId(String schoolName) async {
    final schoolsRef = FirebaseFirestore.instance.collection('escolas');

    try {
      final querySnapshot =
          await schoolsRef.where('schoolName', isEqualTo: schoolName).get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id;
      } else {
        final docRef = await schoolsRef.add({'schoolName': schoolName});
        return docRef.id;
      }
    } catch (e) {
      print('Erro ao obter ou criar ID da escola: $e');
      return '';
    }
  }

  // Obtém ou cria uma nova turma e retorna o ID da turma
  Future<String> getOrCreateClassRoomId(
      String schoolName, String classRoom) async {
    final schoolId = await getOrCreateSchoolId(schoolName);
    if (schoolId.isEmpty) return '';

    final classRoomRef = FirebaseFirestore.instance
        .collection('escolas')
        .doc(schoolId)
        .collection('turmas');

    try {
      final querySnapshot =
          await classRoomRef.where('classRoom', isEqualTo: classRoom).get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id;
      } else {
        final docRef = await classRoomRef.add({'classRoom': classRoom});
        return docRef.id;
      }
    } catch (e) {
      print('Erro ao obter ou criar ID da turma: $e');
      return '';
    }
  }

  // Salva ou atualiza as informações da turma
  Future<void> saveClassRoomInfo(String schoolName, String classRoom,
      Map<String, dynamic> classRoomInfo) async {
    final classRoomId = await getOrCreateClassRoomId(schoolName, classRoom);
    if (classRoomId.isEmpty) return;

    final classRoomRef = FirebaseFirestore.instance
        .collection('escolas')
        .doc(await getOrCreateSchoolId(schoolName))
        .collection('turmas')
        .doc(classRoomId);

    try {
      await classRoomRef.set(classRoomInfo);
      notifyListeners();
    } catch (e) {
      print('Erro ao salvar informações da turma: $e');
    }
  }

  Future<void> saveTeacherInfo(String schoolName, String classRoom,
      Map<String, dynamic> teacherInfo) async {
    final classRoomId = await getOrCreateClassRoomId(schoolName, classRoom);
    if (classRoomId.isEmpty) return;

    final teacherRef = FirebaseFirestore.instance
        .collection('escolas')
        .doc(await getOrCreateSchoolId(schoolName))
        .collection('turmas')
        .doc(classRoomId)
        .collection('professores');

    try {
      await teacherRef.add(teacherInfo);
      notifyListeners();
    } catch (e) {
      print('Erro ao salvar informações do professor: $e');
    }
  }
}


