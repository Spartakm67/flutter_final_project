import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_final_project/services/get_item_text.dart';
import 'package:flutter_final_project/domain/store/cart_store/cart_store.dart';
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
              // Верхня панель із кнопкою закриття
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: _closeWidget,
                  ),
                ],
              ),
              // Список товарів
              const Expanded(
                child: CartPreviewOrderList(),
              ),
              // Нижній бар із загальною сумою та кнопкою переходу до оформлення
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Observer(
                      builder: (_) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${cartStore.totalItems}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            GetItemText.getItemText(cartStore.totalItems),
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Сума: ${cartStore.totalCombinedOrderPrice.toStringAsFixed(0)} грн',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Логіка переходу до оформлення
                      },
                      child: const Text('Перейти до оформлення'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
