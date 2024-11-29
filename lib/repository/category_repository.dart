class CategoryRepository {
  static final List<String> categories = [
    'Сніданок',
    'Обід',
    'Вечеря',
    'Салати',
    'Десерт',
    'Млинці',
    'Напої',
    'Морозиво',
  ];
  static List<String> getAllCategories() {
    return categories;
  }
}
