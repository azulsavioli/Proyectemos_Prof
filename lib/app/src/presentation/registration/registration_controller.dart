import '../../../../repository/repository_impl.dart';

class RegistrationController {
  final _repository = RepositoryImpl();

  Future<void> saveSchoolName(schoolInfo) async {
    await _repository.getOrCreateSchoolId(schoolInfo);
  }

  Future<void> saveClassRoomName(
    schoolName,
    classRoomName,
    classRoomInfo,
  ) async {
    await _repository.saveClassRoomInfo(
        schoolName, classRoomName, classRoomInfo);
  }

  // Future<void> saveTeacher(
  //     schoolName, classRoomInfo, teacherId, teacherInfo) async {
  //   await _repository.saveTeacherInfo(
  //       schoolName, classRoomInfo, teacherId, teacherInfo);
  // }

  Future<void> saveTeacherInfo(schoolName, classRoomInfo, teacherEmail) async {
    await _repository.saveTeacherInfo(schoolName, classRoomInfo, teacherEmail);
  }

  // Future<void> saveTeacherName(schoolName, classRoomInfo, teacherName) async {
  //   await _repository.saveTeacherName(schoolName, classRoomInfo, teacherName);
  // }
}
