import 'package:flutter/material.dart';
import 'package:flutter_final_project/presentation/styles/text_styles.dart';

class UserAgreementWidget extends StatefulWidget {
  const UserAgreementWidget({super.key});

  @override
  State<UserAgreementWidget> createState() => _UserAgreementWidgetState();
}

class _UserAgreementWidgetState extends State<UserAgreementWidget> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  int page = 1;
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth * 0.95;
        final height = constraints.maxHeight * 0.95;
        return Center(
          child: AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Container(
              width: width,
              height: height,
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
                              'Угода користувача',
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
                  Expanded(
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      controller: _controller,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      children: <Widget>[
                        Container(
                          color: Colors.white60,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Угода користувача\n ',
                                      style: TextStyles.oderAppBarText,
                                    ),
                                    TextSpan(
                                      text:
                                          '''Текст цього документу є договором, публічною пропозицією ФОП Козловський Дмитро Володимирович (надалі “Продавець”, "Ми") укласти на вашу користь (надалі “Ви”, "Покупець") договір на умовах, що викладені нижче.
                                Будь ласка, уважно ознайомтесь з положеннями цієї угоди, перш ніж використовувати наш мобільний додаток (надалі – додаток), адже з моменту прийняття її умов, ця пропозиція виступає юридично обов’язковим договором між нами (надалі разом — «Сторони»).
                                maisternia-mlintsiv2.ps.me — Веб-сайт, тобто набір веб-сторінок, який доступний в Інтернеті під одним доменом за адресою https://maisternia-mlintsiv2.ps.me (надалі “Сайт”, “веб-сайт”). Цей набір включає в себе різні ресурси, такі як Контент, об'єкти інтелектуальної власності, іншу інформацію та матеріали. Метою веб-сайту є централізація інформації про товари та послуги Продавця та продаж товарів Покупцю дистанційним способом.
                                ''',
                                      style: TextStyles.spanBodyText,
                                    ),
                                    TextSpan(
                                      text:
                                          'Предмет та порядок укладення Договору\n ',
                                      style: TextStyles.oderAppBarText,
                                    ),
                                    TextSpan(
                                      text:
                                          '''Предметом цієї угоди є забезпечення Покупцеві можливості отримувати послуги, які доступні на веб-сайті, отримувати доступ до вмісту, розміщеного на веб-сайті, а також придбавати товари: готові страви, фрукти та овочі, хлібобулочні вироби, алкогольні та безалкогольні напої, молочні продукти, м'ясні та ковбасні вироби, кондитерські вироби, тютюнові вироби та предмети, пов’язані з їх вживанням (далі Товари) із каталогу веб-сайту для будь-яких цілей.
                                Покупець виражає згоду на умови цього Договору та укладає цей Договір шляхом реєстрації на Сайті, додатковим підтвердженням згоди на умови цього договору є здійснення оплати.
                                Підтверджуючи свою згоду з умовами цього Договору, покупець таким чином підтверджує, що ці умови не порушують його законних прав та інтересів.
                                Якщо ви не погоджуєтеся з цією Угодою, ви зобов'язані припинити використання Сайту і всіх його сторінок і покинути Сайт.\n''',
                                      style: TextStyles.spanPostText,
                                    ),
                                    TextSpan(
                                      text: 'Реєстрація на Сайті\n ',
                                      style: TextStyles.oderAppBarText,
                                    ),
                                    TextSpan(
                                      text:
                                          '''Для оформлення замовлення на сайті необхідно зареєструватися. Реєстрація відбувається через форму на сайті або за телефоном за допомогою оператора. Після реєстрації Покупцем створюється обліковий запис. Реєстрація є прийняттям цієї угоди в повному обсязі.''',
                                      style: TextStyles.spanPostText,
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),

//                                 Text('''
// Угода користувача
// Текст цього документу є договором, публічною пропозицією ФОП Козловський Дмитро Володимирович (надалі “Продавець”, "Ми") укласти на вашу користь (надалі “Ви”, "Покупець") договір на умовах, що викладені нижче.
// Будь ласка, уважно ознайомтесь з положеннями цієї угоди, перш ніж використовувати наш мобільний додаток (надалі – додаток), адже з моменту прийняття її умов, ця пропозиція виступає юридично обов’язковим договором між нами (надалі разом — «Сторони»).
// maisternia-mlintsiv2.ps.me — Веб-сайт, тобто набір веб-сторінок, який доступний в Інтернеті під одним доменом за адресою https://maisternia-mlintsiv2.ps.me (надалі “Сайт”, “веб-сайт”). Цей набір включає в себе різні ресурси, такі як Контент, об'єкти інтелектуальної власності, іншу інформацію та матеріали. Метою веб-сайту є централізація інформації про товари та послуги Продавця та продаж товарів Покупцю дистанційним способом.
// Предмет та порядок укладення Договору
// Предметом цієї угоди є забезпечення Покупцеві можливості отримувати послуги, які доступні на веб-сайті, отримувати доступ до вмісту, розміщеного на веб-сайті, а також придбавати товари: готові страви, фрукти та овочі, хлібобулочні вироби, алкогольні та безалкогольні напої, молочні продукти, м'ясні та ковбасні вироби, кондитерські вироби, тютюнові вироби та предмети, пов’язані з їх вживанням (далі Товари) із каталогу веб-сайту для будь-яких цілей.
// Покупець виражає згоду на умови цього Договору та укладає цей Договір шляхом реєстрації на Сайті, додатковим підтвердженням згоди на умови цього договору є здійснення оплати.
// Підтверджуючи свою згоду з умовами цього Договору, покупець таким чином підтверджує, що ці умови не порушують його законних прав та інтересів.
// Якщо ви не погоджуєтеся з цією Угодою, ви зобов'язані припинити використання Сайту і всіх його сторінок і покинути Сайт.
// Реєстрація на Сайті
// Для оформлення замовлення на сайті необхідно зареєструватися. Реєстрація відбувається через форму на сайті або за телефоном за допомогою оператора. Після реєстрації Покупцем створюється обліковий запис. Реєстрація є прийняттям цієї угоди в повному обсязі.
// ''',
//                                     style: TextStyles.spanPostText,
//                                   textAlign: TextAlign.justify,),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.green,
                          child: const Center(
                            child: Text(
                              'Page 2',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.blue,
                          child: const Center(
                            child: Text(
                              'Page 3',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.yellow,
                          child: const Center(
                            child: Text(
                              'Page 4',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.orange,
                          child: const Center(
                            child: Text(
                              'Page 5',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.purple,
                          child: const Center(
                            child: Text(
                              'Page 6',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: _previousPage,
                        child: const Text('Previous Page'),
                      ),
                      Text('${page + _currentPage}',
                          style: TextStyles.cartBottomText),
                      ElevatedButton(
                        onPressed: _nextPage,
                        child: const Text('Next Page'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _nextPage() {
    if (_currentPage < 6) {
      _controller.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _controller.animateToPage(
        _currentPage - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}
