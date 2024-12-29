import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_final_project/domain/store/categories_store/categories_store.dart';
import 'package:flutter_final_project/domain/store/scroll_store/scroll_store.dart';
import 'package:flutter_final_project/domain/store/cart_store/cart_store.dart';
import 'package:flutter_final_project/domain/store/product_store/product_store.dart';
import 'package:flutter_final_project/domain/store/auth_store/auth_store.dart';
import 'package:flutter_final_project/domain/store/home_store/home_screen_store.dart';
import 'package:flutter_final_project/presentation/screens/product_list_screen.dart';
import 'package:flutter_final_project/presentation/screens/home_screen.dart';
import 'package:flutter_final_project/presentation/widgets/custom_burger_button.dart';
import 'package:flutter_final_project/presentation/widgets/contacts/contacts_widget.dart';
import 'package:flutter_final_project/presentation/widgets/order_widgets/categories_list_widget.dart';
import 'package:flutter_final_project/presentation/widgets/order_widgets/cart_preview_container.dart';
import 'package:flutter_final_project/presentation/widgets/custom_dialog.dart';
import 'package:flutter_final_project/presentation/styles/text_styles.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  CategoriesScreenState createState() => CategoriesScreenState();
}

class CategoriesScreenState extends State<CategoriesScreen> {
  late ProductStore productStore;
  final CategoriesStore _categoriesStore = CategoriesStore();
  late ScrollController _scrollController;
  late ScrollStore _scrollStore;

  @override
  void initState() {
    super.initState();
    _categoriesStore.fetchCategories();
    _scrollStore = ScrollStore();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      _scrollStore.updateScrollPosition(_scrollController.offset);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productStore = Provider.of<ProductStore>(context, listen: false);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartStore = Provider.of<CartStore>(context);
    final authStore = Provider.of<AuthStore>(context);
    final homeStore = Provider.of<HomeScreenStore>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Категорії',
          style: TextStyles.greetingsText,
        ),
        actions: [
          Observer(
            builder: (_) {
              return cartStore.totalItems > 0
                  ? GestureDetector(
                      onTap: () {
                        CustomDialog.show(
                          context: context,
                          builder: (_) => const CartPreviewContainer(),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.shopping_cart,
                              size: 30,
                              color: Colors.blueGrey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              cartStore.totalItems.toString(),
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey,
                              ),
                            ),
                            if (authStore.isLoggedIn)
                              IconButton(
                                icon: const Icon(Icons.logout),
                                onPressed: authStore.isLoading
                                    ? null
                                    : () async {
                                        await authStore.signOut();
                                        if (context.mounted) {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen(store: homeStore),
                                            ),
                                          );
                                        }
                                      },
                              ),
                            const SizedBox(width: 10),
                            CustomBurgerButton(
                              backgroundColor: Colors.white,
                              lineColor: Colors.blueGrey,
                              borderColor: Colors.grey,
                              borderRadius: 12.0,
                              onTap: () => showDialog(
                                context: context,
                                builder: (context) => const ContactsWidget(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox();
            },
          ),
        ],
      ),
      body: CategoriesListWidget(
        categoriesStore: _categoriesStore,
        scrollController: _scrollController,
        onCategoryTap: (categoryId, categoryName) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductListScreen(
                categoriesStore: _categoriesStore,
                productStore: productStore,
                categoryId: int.parse(categoryId),
                categoryName: categoryName,
              ),
            ),
          );
        },
      ),
    );
  }
}

