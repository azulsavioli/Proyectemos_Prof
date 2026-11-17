class SchoolRecord {
  const SchoolRecord({
    required this.id,
    required this.name,
    required this.classCount,
  });

  final String id;
  final String name;
  final int classCount;
}

class TeacherRecord {
  const TeacherRecord({required this.name, required this.email});

  final String name;
  final String email;
}

class ClassRoomRecord {
  const ClassRoomRecord({
    required this.id,
    required this.name,
    required this.teachers,
  });

  final String id;
  final String name;
  final List<TeacherRecord> teachers;
}

class DashboardStats {
  const DashboardStats({
    required this.schools,
    required this.classRooms,
    required this.teachers,
  });

  final int schools;
  final int classRooms;
  final int teachers;
}

class AppNotification {
  const AppNotification({
    required this.id,
    required this.title,
    required this.body,
    this.createdAt,
  });

  final String id;
  final String title;
  final String body;
  final DateTime? createdAt;
}
