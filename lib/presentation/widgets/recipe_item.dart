// import 'package:flutter/material.dart';
// import 'package:flutter_home_work9/models/recipe.dart';
// import 'package:flutter_home_work9/screens/recipe_detail_screen.dart';
// import 'package:flutter_home_work9/widgets/recipe_form_edit.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_home_work9/provider/recipe_model.dart';
//
// class RecipeCard extends StatelessWidget {
//   final Recipe recipe;
//
//   const RecipeCard({
//     super.key,
//     required this.recipe,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => RecipeDetailPage(recipe: recipe),
//           ),
//         );
//       },
//       child: Card(
//         elevation: 4,
//         margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             children: [
//               Hero(
//                 tag: recipe.title,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(4),
//                   child: Image(
//                     image: recipe.image,
//                     width: 65,
//                     height: 75,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       recipe.category,
//                       style: const TextStyle(fontSize: 12, color: Colors.grey),
//                     ),
//                     Text(
//                       recipe.title,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       recipe.description,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style:
//                           const TextStyle(fontSize: 14, color: Colors.black54),
//                     ),
//                   ],
//                 ),
//               ),
//               IconButton(
//                 icon: const Icon(
//                   Icons.edit,
//                   color: Colors.blue,
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => RecipeFormEdit(recipe: recipe),
//                     ),
//                   );
//                 },
//               ),
//               IconButton(
//                 icon: const Icon(Icons.delete_forever, color: Colors.red),
//                 onPressed: () => _deleteRecipe(context),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _deleteRecipe(BuildContext context) async {
//     final recipeModel = Provider.of<RecipeModel>(context, listen: false);
//     final scaffoldMessenger = ScaffoldMessenger.of(context);
//
//     final shouldDelete = await showDialog<bool>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Підтвердження'),
//           content: const Text('Ви впевнені, що хочете видалити цей рецепт?'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(false),
//               child: const Text('Відмінити'),
//             ),
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(true),
//               child: const Text('Видалити'),
//             ),
//           ],
//         );
//       },
//     );
//     if (shouldDelete == true) {
//       recipeModel.deleteRecipe(recipe.id);
//       scaffoldMessenger.showSnackBar(
//         SnackBar(content: Text('Рецепт "${recipe.title}" видалено!')),
//       );
//     }
//   }
// }
