import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_final_project/domain/store/scroll_store/scroll_store.dart';

class ScrollToTopButton extends StatelessWidget {
  final ScrollStore scrollStore;
  final ScrollController scrollController;

  const ScrollToTopButton({
    super.key,
    required this.scrollStore,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
       return AnimatedOpacity(
          opacity: scrollStore.isButtonVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: FloatingActionButton(
            onPressed: () async {
              await scrollController.animateTo(
                0.0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );

              scrollStore.resetScroll();
            },
            backgroundColor: Color.fromRGBO(0, 0, 0, 0.5),
            child: const Icon(Icons.arrow_upward, color: Colors.white),
          ),
        );
      },
    );
  }
}
