class Product {
  final String categoryProductId;
  final String categoryName;
  final String productId;
  final String productName;
  final double price;
  final int cookingTime;
  final String photo;
  final String photoOrigin;
  final String description;
  final List<Ingredient> ingredients;
  final int hidden;
  final int visible;

  Product({
    required this.categoryProductId,
    required this.categoryName,
    required this.productId,
    required this.productName,
    required this.price,
    required this.cookingTime,
    required this.photo,
    required this.photoOrigin,
    required this.description,
    required this.ingredients,
    required this.hidden,
    required this.visible,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    List<Ingredient> ingredientsList = (json['ingredients'] as List<dynamic>?)
        ?.map((item) => Ingredient.fromJson(item))
        .toList() ??
        [];

    if (json.containsKey('group_modifications')) {
      for (var group in json['group_modifications']) {
        for (var mod in group['modifications']) {
          ingredientsList.add(Ingredient(
            name: mod['name'] ?? '',
            netto: 0, // Може бути відсутнє
            brutto: double.tryParse(mod['brutto']?.toString() ?? '0') ?? 0,
            price: double.tryParse(mod['price']?.toString() ?? '0') ?? 0,
            subIngredients: [],
          ),);
        }
      }
    }

    return Product(
      categoryProductId: json['menu_category_id'],
      categoryName: json['category_name'],
      productId: json['product_id'],
      productName: json['product_name'],
      price: json['spots'] != null && json['spots'].isNotEmpty
          ? double.tryParse(json['spots'][0]['price'] ?? '0') ?? 0
          : 0,
      cookingTime: int.tryParse(json['cooking_time'] ?? '0') ?? 0,
      photo: json['photo'] ?? '',
      photoOrigin: json['photo_origin'] ?? '',
      description: json['product_production_description'] ?? '',
      ingredients: ingredientsList,
      hidden: int.tryParse(json['hidden'] ?? '0') ?? 0,
      visible: json['spots'] != null && json['spots'].isNotEmpty
          ? int.tryParse(json['spots'][0]['visible'] ?? '0') ?? 0
          : 0,
    );
  }
}

class Ingredient {
  final String name;
  final double netto;
  final double brutto;
  final double price;
  final List<Ingredient> subIngredients;

  Ingredient({
    required this.name,
    required this.netto,
    required this.brutto,
    required this.price,
    required this.subIngredients,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    List<Ingredient> subIngredientsList = [];

    if (json.containsKey('modifications')) {
      subIngredientsList = (json['modifications'] as List<dynamic>?)
          ?.map((mod) => Ingredient(
        name: mod['modificator_name'] ?? '',
        netto: 0,
        brutto: double.tryParse(mod['brutto']?.toString() ?? '0') ?? 0,
        price: double.tryParse(mod['price']?.toString() ?? '0') ?? 0,
        subIngredients: [],
      ),)
          .toList() ??
          [];
    }

    return Ingredient(
      name: json['ingredient_name'] ?? '',
      netto: double.tryParse(json['structure_netto']?.toString() ?? '0') ?? 0,
      brutto: 0,
      price: 0,
      subIngredients: subIngredientsList,
    );
  }
}




