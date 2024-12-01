import 'package:flutter/material.dart';

class LoadingImageIndicator extends StatelessWidget {
  const LoadingImageIndicator({
    super.key,
    required this.loadingProgress,
  });

  final ImageChunkEvent? loadingProgress;

  @override
  Widget build(BuildContext context) {
   return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 75,
          height: 75,
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
            value: loadingProgress?.expectedTotalBytes != null
                ? loadingProgress!.cumulativeBytesLoaded /
                loadingProgress!.expectedTotalBytes!
                : null,
          ),
        ),
        const Icon(
          Icons.image,
          size: 50,
          color: Colors.lightGreenAccent,
        ),
      ],
    );
  }
}
