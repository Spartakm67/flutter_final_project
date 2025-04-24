import 'package:mobx/mobx.dart';
import 'package:flutter_final_project/data/models/poster/category.dart';
import 'package:flutter_final_project/services/poster_api/category_api_services.dart';

part 'categories_store.g.dart';

class CategoriesStore = CategoriesStoreBase with _$CategoriesStore;

abstract class CategoriesStoreBase with Store {
  @observable
  ObservableList<Category> categories = ObservableList<Category>();

  @observable
  bool isLoading = false;

  @observable
  String? error;

  final Category additionsCategory = Category(
    categoryId: '10',
    categoryName: 'Добавки',
    categoryPhoto: null,
    categoryTag: 'additions',
    categoryColor: '#FFC107',
  );

  @action
  Future<void> fetchCategories() async {
    try {
      isLoading = true;
      error = null;
      final fetchedCategories = await CategoryApiServices.fetchCategories();
      categories = ObservableList.of(
        [
          ...fetchedCategories.where((category) => !category.categoryName.contains('Glovo')),
          additionsCategory,
        ],
      );
    } catch (e) {
      error = 'Помилка завантаження категорій: $e';
    } finally {
      isLoading = false;
    }
  }
}


