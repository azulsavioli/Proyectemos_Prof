abstract class Repository<T, U, V> {
  Future<void> savedInformations(T taskName);
  Future<void> saveTeacherEmailFirebase(
      Map<String, T> schoolInformations, Map<String, T> email);
  Future<void> saveSchoolInformationFirebase(Map<String, T> schoolInformations);

  Future<void> getSchoolInformationFirebase(Map<String, T> schoolInformations);
  Future<void> getClassesInformationFirebase(
      Map<String, T> classesInformations);
  Future<void> getStudentInformationFirebase(
      Map<String, T> studentInformations);
  Future<void> getStudentTasksCompletedInformationFirebase(
      Map<String, T> studentTasksCompletedInformations);
}
