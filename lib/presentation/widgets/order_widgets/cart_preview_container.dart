import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_final_project/services/get_item_text.dart';
import 'package:flutter_final_project/domain/store/cart_store/cart_store.dart';
import 'package:flutter_final_project/presentation/styles/text_styles.dart';
import 'package:flutter_final_project/presentation/widgets/custom_dialog.dart';
import 'package:flutter_final_project/presentation/widgets/custom_container.dart';
import 'package:flutter_final_project/presentation/widgets/order_widgets/order_container.dart';
import 'package:flutter_final_project/presentation/widgets/order_widgets/cart_preview_order_list.dart';

class CartPreviewContainer extends StatefulWidget {
  const CartPreviewContainer({super.key});

  @override
  State<CartPreviewContainer> createState() => _CartPreviewContainerState();
}

class _CartPreviewContainerState extends State<CartPreviewContainer> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        _isVisible = true;
      });
    });
  }

  void _closeWidget() {
    setState(() {
      _isVisible = false;
    });
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartStore = Provider.of<CartStore>(context, listen: false);

    return Center(
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: SafeArea( // 🛡️ Запобігає перекриттю статусбаром
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(50),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    left: 16,
                    right: 16,
                    bottom: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.grey,
                        ),
                        iconSize: 32,
                        onPressed: _closeWidget,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CustomContainer(
                    backgroundColor: Colors.black.withAlpha(30),
                    children: [
                      Text(
                        'Вартість доставлення 50 грн.\nДоставимо безкоштовно при замовленні від 350 грн.',
                        style: TextStyles.cartText,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    child: const ColoredBox(
                      color: Colors.transparent, // для впевненості, що клік проходить
                      child: CartPreviewOrderList(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Column(
                    children: [
                      Observer(
                        builder: (_) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '${cartStore.totalItems}',
                              style: TextStyles.cartBottomText,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              GetItemText.getItemText(cartStore.totalItems),
                              style: TextStyles.cartBottomText,
                            ),
                            const Spacer(),
                            Text(
                              'Сума: ${cartStore.totalCombinedOrderPrice.toStringAsFixed(0)} грн',
                              style: TextStyles.cartBottomText,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          CustomDialog.show(
                            context: context,
                            builder: (_) => const OrderContainer(),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          backgroundColor: Colors.black.withAlpha(100),
                        ),
                        child: const Text(
                          'Перейти до оформлення',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
