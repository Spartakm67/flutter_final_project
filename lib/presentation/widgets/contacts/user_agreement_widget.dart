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
        final height = constraints.maxHeight * 0.8;
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
                      ],
                    ),
                  ),
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
                              child: SingleChildScrollView(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      WidgetSpan(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 8.0,
                                          ),
                                          child: Text(
                                            'Угода користувача',
                                            style: TextStyles.oderAppBarText,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ),
                                      TextSpan(text: '\n'),
                                      TextSpan(
                                        text:
                                            '''Текст цього документу є договором, публічною пропозицією ФОП Козловський Дмитро Володимирович (надалі “Продавець”, "Ми") укласти на вашу користь (надалі “Ви”, "Покупець") договір на умовах, що викладені нижче.
Будь ласка, уважно ознайомтесь з положеннями цієї угоди, перш ніж використовувати наш мобільний додаток (надалі – додаток), адже з моменту прийняття її умов, ця пропозиція виступає юридично обов’язковим договором між нами (надалі разом — «Сторони»).
Мобільний додаток призначений для ознайомлення з товарами та послугами Продавця, здійснення замовлень та оплати Товарів (далі — «Товари») дистанційним способом.
                                  ''',
                                        style: TextStyles.spanBodyText,
                                      ),
                                      WidgetSpan(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 8.0,
                                          ),
                                          child: Text(
                                            'Предмет та порядок укладення Договору',
                                            style: TextStyles.oderAppBarText,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            '''Предметом цієї угоди є забезпечення Покупцеві можливості отримувати послуги, які доступні в мобільному додатку, переглядати його вміст, а також придбавати товари: готові страви, фрукти та овочі, хлібобулочні вироби, алкогольні та безалкогольні напої, молочні продукти, м'ясні та ковбасні вироби, кондитерські вироби, тютюнові вироби та предмети, пов’язані з їх вживанням.
Покупець виражає згоду на умови цього Договору та укладає його шляхом реєстрації в додатку або здійснення замовлення. Додатковим підтвердженням згоди є здійснення оплати.
Погоджуючись з цими умовами, Покупець підтверджує, що вони не порушують його законних прав та інтересів.
Якщо ви не погоджуєтеся з цією Угодою, ви зобов'язані припинити використання додатку.\n''',
                                        style: TextStyles.spanBodyText,
                                      ),
                                      WidgetSpan(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 8.0,
                                          ),
                                          child: Text(
                                            'Реєстрація на Сайті',
                                            style: TextStyles.oderAppBarText,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ),
                                      TextSpan(text: '\n'),
                                      TextSpan(
                                        text:
                                            '''Для оформлення замовлення в мобільному додатку необхідно зареєструватися. Реєстрація відбувається через форму в додатку або за телефоном за допомогою оператора.
Після реєстрації Покупцем створюється обліковий запис. Реєстрація є прийняттям цієї угоди в повному обсязі.''',
                                        style: TextStyles.spanBodyText,
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white60,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SingleChildScrollView(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '''Під час реєстрації Покупець повинен надавати достовірну, точну і вичерпну інформацію про себе. Якщо надана інформація є неправдивою або неповною, Продавець має право відмовити в обслуговуванні.
Покупець несе повну відповідальність за достовірність даних. У разі надання недостовірної інформації Покупець приймає на себе ризик неможливості виконання зобов’язань Продавцем.
Покупець передає Продавцю таку контактну інформацію: ім'я та номер телефону.
Ця інформація використовується виключно для ідентифікації Покупця та виконання умов цього Договору.
Дані Покупця обробляються відповідно до Політики конфіденційності.
Покупець повинен утримуватись від передачі своїх персональних даних третім особам. Продавець не несе відповідальності за наслідки такої передачі.
                                  ''',
                                        style: TextStyles.spanBodyText,
                                      ),
                                      WidgetSpan(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 8.0,
                                          ),
                                          child: Text(
                                            'Умови продажу Товару та надання послуг',
                                            style: TextStyles.oderAppBarText,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            '''Використовуючи мобільний додаток, ви погоджуєтеся з умовами продажу Товарів та послуг, встановленими Продавцем. Ці умови є публічною офертою.
Зображення товарів у додатку мають виключно ілюстративний характер.
Інформація щодо характеристик товарів може містити неточності. Для уточнення деталей рекомендується звертатися до Продавця.
Замовлення Товарів та послуг здійснюється із переліку, запропонованого Продавцем у додатку.
Продавець намагається підтримувати актуальність асортименту, однак у разі відсутності товару може вилучити його з замовлення або анулювати його.
У такому разі вартість скасованих позицій не враховується під час розрахунку між Сторонами.
                                        \n''',
                                        style: TextStyles.spanBodyText,
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white60,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SingleChildScrollView(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Доставка Товару\n ',
                                        style: TextStyles.oderAppBarText,
                                      ),
                                      TextSpan(
                                        text:
                                            '''Доставка здійснюється методами, вказаними у додатку. Її вартість залежить від способу доставки та відстані.
Доставка є окремою послугою і не є частиною товару.
Територія доставки обмежується технічними можливостями та збереженням якості швидкопсувних товарів, але не може перевищувати відстань у 5 (п'ять) кілометрів 
від адреси закладу: м.Київ, проспект Соборності, 7Б.
                          \n''',
                                        style: TextStyles.spanBodyText,
                                      ),
                                      TextSpan(
                                        text: 'Ціна Товару\n ',
                                        style: TextStyles.oderAppBarText,
                                      ),
                                      TextSpan(
                                        text:
                                            '''Ціна товару вказується в мобільному додатку.
Продавець має право змінювати ціни в односторонньому порядку, крім випадків, коли товар вже був замовлений Покупцем.
Для деяких товарів можуть діяти знижки.
Оплата здійснюється одним із способів, запропонованих у додатку.
Всі розрахунки проводяться у гривнях (UAH).
                                  \n ''',
                                        style: TextStyles.spanBodyText,
                                      ),
                                      TextSpan(
                                        text: 'Умови повернення\n ',
                                        style: TextStyles.oderAppBarText,
                                      ),
                                      TextSpan(
                                        text:
                                            '''Повернення товару належної якості можливе згідно з чинним законодавством України, протягом 14 днів, якщо товар не був у використанні, має збережений вигляд і є документ, що підтверджує покупку.
Окремі товари не підлягають поверненню згідно з Постановою КМУ №172 від 19.03.1994.
Повернення коштів здійснюється на банківську картку або готівкою — за домовленістю сторін.\n ''',
                                        style: TextStyles.spanBodyText,
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white60,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SingleChildScrollView(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Відповідальність\n ',
                                        style: TextStyles.oderAppBarText,
                                      ),
                                      TextSpan(
                                        text:
                                            '''Сторони несуть відповідальність за невиконання або неналежне виконання умов цього договору згідно з положеннями цього договору та чинним законодавством України.
Продавець не несе відповідальності за:
• неналежне виконання зобов'язань, якщо Покупець надав неправдиву або неповну інформацію;
• відмінність зовнішнього вигляду товару від зображень у мобільному додатку;
• використання товару не за призначенням чи всупереч опису в додатку;
• наслідки використання товару Покупцем із медичними протипоказаннями або індивідуальною чутливістю.
У максимально дозволеній законом мірі, Продавець не несе відповідальності за будь-які збитки або шкоду (включаючи втрату прибутку, переривання комерційної діяльності, втрату даних), які можуть виникнути в результаті використання або неможливості використання мобільного додатку, незалежно від результату такого використання.
Сторони звільняються від відповідальності за повне або часткове невиконання зобов’язань у випадку форс-мажорних обставин: війна, стихійні лиха, пожежа, дії державних органів, митні обмеження тощо.
Сторона, яка зазнала форс-мажору, зобов’язана негайно повідомити іншу сторону та надати документальне підтвердження таких обставин.\n''',
                                        style: TextStyles.spanBodyText,
                                      ),
                                      TextSpan(
                                        text: 'Заборонена поведінка\n ',
                                        style: TextStyles.oderAppBarText,
                                      ),
                                      TextSpan(
                                        text: '''Покупцю заборонено:
• обходити, вимикати чи іншим чином втручатися в функції безпеки мобільного додатку;
• надавати недостовірну або оманливу інформацію;
• надсилати спам, повторювані або небажані повідомлення;
• здійснювати будь-які незаконні чи протиправні дії;
• втручатися, змінювати або перешкоджати роботі додатку, а також вчиняти дії, що можуть йому зашкодити;
• порушувати права інших користувачів.
У мобільному додатку розміщені матеріали, що охороняються авторським правом: тексти, фотографії, графіка, звукові файли тощо.
Без письмової згоди Продавця Покупець або інші особи не мають права копіювати, розповсюджувати, публікувати або іншим чином використовувати такі матеріали.\n ''',
                                        style: TextStyles.spanBodyText,
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white60,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SingleChildScrollView(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Інші положення\n ',
                                      style: TextStyles.oderAppBarText,
                                    ),
                                    TextSpan(
                                      text:
                                          '''Продавець може тимчасово обмежувати доступ до додатку для проведення технічних робіт без попереднього повідомлення.
Продавець також має право змінювати умови цього договору, ціни, та інші дані в додатку.
У разі питань або претензій Покупець може звертатися через контакти, зазначені в додатку.
Сторони зобов’язуються вирішувати суперечки шляхом переговорів. Якщо згоди досягти не вдалося — спір розглядається в суді за українським законодавством.
Недійсність окремого положення цього Договору не впливає на дійсність інших положень.
Використовуючи мобільний додаток, Ви підтверджуєте свою згоду з цими умовами. Якщо Ви не погоджуєтесь — припиніть його використання.\n''',
                                      style: TextStyles.spanBodyText,
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
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
                      Text(
                        '${page + _currentPage}',
                        style: TextStyles.cartBottomText,
                      ),
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
