import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_final_project/presentation/widgets/custom_snack_bar.dart';

class InteractiveGestureDetector extends StatelessWidget {
  final String label;
  final String actionUri;
  final IconData? icon;
  final TextStyle? textStyle;
  final String errorMessage;
  final Color dividerColor;
  final double dividerThickness;
  final EdgeInsets padding;

  const InteractiveGestureDetector({
    super.key,
    required this.label,
    required this.actionUri,
    this.icon,
    this.textStyle,
    this.errorMessage = 'Cannot perform this action',
    this.dividerColor = Colors.grey,
    this.dividerThickness = 1.0,
    this.padding = const EdgeInsets.symmetric(vertical: 8),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _handleTap(context);
      },
      child: Container(
        padding: padding,
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (icon != null)
                  Icon(icon, color: Colors.black, size: 20),
                if (icon != null) const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    label,
                    style: textStyle ?? const TextStyle(fontSize: 16, color: Colors.black),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Divider(
              thickness: dividerThickness,
              color: dividerColor,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleTap(BuildContext context) async {
    final uri = Uri.parse(actionUri);
    final bool canLaunchUri = await canLaunchUrl(uri);

    if (!context.mounted) return;

    if (canLaunchUri) {
      await launchUrl(uri);
    } else {
      CustomSnackBar.show(
        context: context,
        message: errorMessage,
        backgroundColor: Colors.redAccent,
        position: SnackBarPosition.top,
        duration: const Duration(seconds: 3),
      );
    }
  }
}

// class InteractiveGestureDetector extends StatelessWidget {
//   final String label;
//   final String actionUri;
//   final IconData? icon;
//   final TextStyle? textStyle;
//   final String errorMessage;
//   final Color dividerColor;
//   final double dividerThickness;
//   final EdgeInsets padding;
//
//   const InteractiveGestureDetector({
//     super.key,
//     required this.label,
//     required this.actionUri,
//     this.icon,
//     this.textStyle,
//     this.errorMessage = 'Cannot perform this action',
//     this.dividerColor = Colors.grey,
//     this.dividerThickness = 1.0,
//     this.padding = const EdgeInsets.symmetric(vertical: 8),
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () async {
//         final messenger = ScaffoldMessenger.of(context);
//         final uri = Uri.parse(actionUri);
//         final canLaunch = await canLaunchUrl(uri);
//
//         if (canLaunch) {
//           await launchUrl(uri);
//         } else {
//           messenger.showSnackBar(
//             SnackBar(content: Text(errorMessage)),
//           );
//         }
//       },
//       child: Container(
//         padding: padding,
//         color: Colors.transparent,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 if (icon != null)
//                   Icon(icon, color: Colors.black, size: 20),
//                 if (icon != null) const SizedBox(width: 8),
//                 Flexible(
//                   child: Text(
//                     label,
//                     style: textStyle ?? const TextStyle(fontSize: 16, color: Colors.black),
//                     softWrap: true,
//                     overflow: TextOverflow.visible,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Divider(
//               thickness: dividerThickness,
//               color: dividerColor,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }