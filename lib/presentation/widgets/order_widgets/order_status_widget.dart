import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_final_project/services/get_item_text.dart';
import 'package:flutter_final_project/presentation/widgets/custom_dialog.dart';
import 'package:flutter_final_project/domain/store/cart_store/cart_store.dart';
import 'package:flutter_final_project/domain/store/order_store/order_store.dart';
import 'package:flutter_final_project/domain/store/home_store/home_screen_store.dart';
import 'package:flutter_final_project/presentation/styles/text_styles.dart';
import 'package:flutter_final_project/presentation/screens/home_screen.dart';
import 'package:flutter_final_project/presentation/widgets/order_widgets/order_widget.dart';

class OrderStatusWidget extends StatefulWidget {
  final String? statusId;
  final String? checkId;
  const OrderStatusWidget({super.key, this.statusId, this.checkId});

  @override
  State<OrderStatusWidget> createState() => _OrderStatusWidgetState();
}

class _OrderStatusWidgetState extends State<OrderStatusWidget> {
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
    final orderStore = Provider.of<OrderStore>(context, listen: false);
    final homeStore = Provider.of<HomeScreenStore>(context, listen: false);
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.grey,
                          ),
                          iconSize: 32,
                          onPressed: _closeWidget,
                        ),
                        const Text(
                          'Статус замовлення',
                          style: TextStyles.oderAppBarText,
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Colors.grey,
                          ),
                          iconSize: 32,
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
              // const Expanded(
              //   child: OrderWidget(),
              // ),
              Padding(
                padding: const EdgeInsets.all(22.0),
                child: Column(
                  children: [
                    Observer(
                      builder: (_) => Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // const Spacer(),
                          const Text(
                            'ДЯКУЄМО ЗА ЗАМОВЛЕННЯ!',
                            style: TextStyles.cartBottomText,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            widget.checkId != null
                                ? 'Замовлення №: ${widget.checkId}'
                                : '№ замовлення не отримано',
                            style: TextStyles.cartBottomText,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            widget.statusId != null
                                ? 'Замовлення прийняте'
                                : 'ID замовлення не отримано',
                            style: TextStyles.cartBottomText,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            'За потреби ми зателефонуємо вам, щоб уточнити деталі.\n',
                            style: TextStyles.cartText,
                            textAlign: TextAlign.center,
                          ),
                          // if (orderStore.isDelivery)
                          //   Text(
                          //     'Доставлення: ${cartStore.deliveryPrice.toStringAsFixed(0)} грн.',
                          //     style: TextStyles.cartBottomText,
                          //   ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        CustomDialog.show(
                          context: context,
                          builder: (_) => HomeScreen(store: homeStore),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 40,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        backgroundColor: Colors.black.withAlpha(200),
                      ),
                      child: Observer(
                        builder: (_) => const Text(
                          'Повернутися у додаток',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
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
    );
  }
}
