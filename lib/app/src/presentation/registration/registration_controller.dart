import '../../../../repository/repository_impl.dart';

class RegistrationController {
  RegistrationController({RepositoryImpl? repository})
      : _repository = repository ?? RepositoryImpl();

  final RepositoryImpl _repository;

  Future<void> saveTeacher({
    required String teacherName,
    required String schoolName,
    required String classRoom,
    required String teacherEmail,
  }) {
    return _repository.registerTeacher(
      teacherName: teacherName,
      schoolName: schoolName,
      classRoom: classRoom,
      teacherEmail: teacherEmail,
    );
  }
}
