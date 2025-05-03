import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_final_project/presentation/widgets/custom_dialog.dart';
import 'package:flutter_final_project/domain/store/auth_store/auth_store.dart';
import 'package:flutter_final_project/presentation/styles/text_styles.dart';
import 'package:flutter_final_project/presentation/screens/home_screen.dart';
import 'package:flutter_final_project/presentation/widgets/contacts/user_agreement_widget.dart';
import 'package:flutter_final_project/presentation/widgets/contacts/custom_contact_item.dart';
import 'package:flutter_final_project/presentation/widgets/order_widgets/last_order_widget.dart';
import 'package:flutter_final_project/presentation/widgets/contacts/contacts_widget.dart';

class BurgerWidget extends StatefulWidget {
  const BurgerWidget({super.key});

  @override
  State<BurgerWidget> createState() => _BurgerWidgetState();
}

class _BurgerWidgetState extends State<BurgerWidget> {
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
    final authStore = Provider.of<AuthStore>(context, listen: false);
    return Center(
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.8,
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
                padding: const EdgeInsets.all(18.0),
                child: Observer(
                  builder: (_) => Column(
                    children: [
                      Text(
                        'МАЙСТЕРНЯ МЛИНЦІВ',
                        style: TextStyles.cartBottomText,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: [
                          CustomContactItem(
                            title: 'Угода користувача',
                            textStyle: TextStyles.cartBottomText,
                            destination: UserAgreementWidget(),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          CustomContactItem(
                            title: 'Контакти',
                            textStyle: TextStyles.cartBottomText,
                            destination: ContactsWidget(),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          CustomContactItem(
                            title: 'Замовляли раніше',
                            textStyle: TextStyles.cartBottomText,
                            destination: LastOrderWidget(),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Робочі години: 9:00 - 20:00,\nбез вихідних',
                          style: TextStyles.cartBottomText,
                          softWrap: true,
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      if (authStore.isLoggedIn)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Вийти',
                              style: TextStyles.cartBottomText,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            IconButton(
                              icon: const Icon(Icons.logout),
                              onPressed: authStore.isLoading
                                  ? null
                                  : () async {
                                      await authStore.signOut();
                                      if (context.mounted) {
                                        CustomDialog.show(
                                          context: context,
                                          builder: (_) =>
                                              HomeScreen(),
                                        );
                                      }
                                    },
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
