// import 'package:flutter/material.dart';
// import 'package:flutter_home_work9/models/recipe.dart';
//
// class RecipeRepository {
//   static final List<Recipe> recipes = [
//     Recipe(
//       image: AssetImage('assets/images/pancake_blackout.jpg'),
//       title: 'БлекАут (млинець незламності)',
//       description: 'Традиційний український продукт',
//       ingredients: [
//         'Молочні сосиски',
//         'Сулугуні',
//         'Морква по корейські',
//         'Огірок солоний',
//         'Гірчиця USA',
//         'Соус фірмовий',
//       ],
//       instructions: [
//         'Підготувати інгредієнти',
//         'Посмажити млинець',
//         'Додати овочі та обгорнути',
//         'Додати соус',
//       ],
//       category: 'Млинці',
//     ),
//     Recipe(
//       image: AssetImage('assets/images/pancake_julien.jpg'),
//       title: 'Жульєн (смакота!!!)',
//       description: 'Сучасний український продукт',
//       ingredients: ['Курячий фарш', 'Гриби', 'Сулугуні', 'Соус фірмовий'],
//       instructions: [
//         'Підготувати інгредієнти',
//         'Посмажити млинець',
//         'Додати овочі та обгорнути',
//         'Додати соус',
//       ],
//       category: 'Обід',
//     ),
//     Recipe(
//       title: 'Борщ',
//       description: 'Традиційна українська перша страва',
//       ingredients: [
//         'Буряк',
//         'Картопля',
//         'Морква',
//         'Цибуля',
//         'Свинина',
//         'Свинина',
//       ],
//       instructions: [
//         'Підготувати овочі',
//         'Варити бульйон',
//         'Додати овочі',
//         'Варити до готовності'
//       ],
//       category: 'Обід',
//     ),
//     Recipe(
//       title: 'Салат Цезар',
//       description: 'Смачний салат з куркою',
//       ingredients: ['Курка', 'Салат', 'Сир пармезан', 'Соус'],
//       instructions: [
//         'Підготувати інгредієнти',
//         'Змішати все в мисці',
//         'Заправити соусом',
//       ],
//       category: 'Салати',
//     ),
//     Recipe(
//       title: 'Омлет',
//       description: 'Легкий та смачний сніданок',
//       ingredients: ['Яйця', 'Молоко', 'Сіль', 'Перець'],
//       instructions: ['Збити яйця', 'Додати молоко', 'Посолити', 'Посмажити'],
//       category: 'Сніданок',
//     ),
//     Recipe(
//       image: AssetImage('assets/images/cold_kvass_soup.jpg'),
//       title: 'Окрошка',
//       description: 'Холодний суп',
//       ingredients: [
//         'Картопля',
//         'Морква',
//         'Цибуля',
//         'Сосиски',
//         'Молоко',
//       ],
//       instructions: [
//         'Підготувати інгредієнти',
//         'Підготувати овочі',
//         'Розмішати',
//         'Охолодити',
//       ],
//       category: 'Обід',
//     ),
//     Recipe(
//       image: AssetImage('assets/images/chicken_salad.jpg'),
//       title: 'Салат з куркою',
//       description: 'Смачний український продукт',
//       ingredients: [
//         'Кукурудза',
//         'Помідори',
//         'Салат Айсберг',
//         'Яйце смажене',
//         'Курка смажена',
//         'Соус фірмовий',
//       ],
//       instructions: [
//         'Підготувати інгредієнти',
//         'Змішати все в мисці',
//         'Заправити соусом',
//       ],
//       category: 'Салати',
//     ),
//     Recipe(
//       image: AssetImage('assets/images/poppy_pancake.jpg'),
//       title: 'Млинець маковий',
//       description: 'Традиційний український продукт',
//       ingredients: [
//         'Мак',
//         'Молоко',
//         'Борошно',
//         'Цукор',
//         'Сіль',
//         'Соус фірмовий',
//       ],
//       instructions: [
//         'Підготувати інгредієнти',
//         'Посмажити млинець',
//         'Додати мак та обгорнути',
//         'Додати соус',
//       ],
//       category: 'Сніданок',
//     ),
//   ];
//
//   static List<Recipe> getAllRecipes() {
//     return recipes;
//   }
//
//   static List<Recipe> getRecipesByCategory(String category) {
//     return recipes.where((recipe) => recipe.category == category).toList();
//   }
//
//   static void addRecipe(Recipe recipe) {
//     recipes.add(recipe);
//   }
//
//   static List<String> getAllCategories() {
//     final categories =
//         recipes.map((recipe) => recipe.category).toSet().toList();
//     return categories;
//   }
// }
