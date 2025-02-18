class WorkingHoursHelper {
  static bool isWorkingHours() {
    final now = DateTime.now();
    final startOfWork = DateTime(now.year, now.month, now.day, 9, 0);
    final endOfWork = DateTime(now.year, now.month, now.day, 20, 0);
    return now.isAfter(startOfWork) && now.isBefore(endOfWork);
  }
}
