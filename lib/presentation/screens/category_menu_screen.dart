import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_final_project/domain/store/home_store/home_screen_store.dart';
import 'package:flutter_final_project/presentation/widgets/home_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/material.dart';
// import 'package:flutter_home_work9/models/recipe.dart';

// class RecipeDetailPage extends StatelessWidget {
//   final Recipe recipe;
//
//   const RecipeDetailPage({
//     super.key,
//     required this.recipe,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(recipe.title),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: SizedBox(
//                 width: double.infinity,
//                 child: AspectRatio(
//                   aspectRatio: 4 / 3.5,
//                   child: Hero(
//                     tag: recipe.title,
//                     child: Image(
//                       image: recipe.image,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               recipe.category,
//               style: const TextStyle(fontSize: 16, color: Colors.grey),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               recipe.title,
//               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               recipe.description,
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Інгредієнти',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             ...recipe.ingredients.map((ingredient) => Text('- $ingredient')),
//             const SizedBox(height: 16),
//             const Text(
//               'Інструкції',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             ...recipe.instructions.map((instruction) => Text('- $instruction')),
//           ],
//         ),
//       ),
//     );
//   }
// }
