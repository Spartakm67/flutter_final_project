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
                          _currentPage =
                              index;
                        });
                      },
                      children: <Widget>[
                        Container(
                          color: Colors.white60,
                          child: const Center(
                              child: Text('Page 1',
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.black,),),),
                        ),
                        Container(
                          color: Colors.green,
                          child: const Center(
                              child: Text('Page 2',
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white,),),),
                        ),
                        Container(
                          color: Colors.blue,
                          child: const Center(
                              child: Text('Page 3',
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white,),),),
                        ),
                        Container(
                          color: Colors.yellow,
                          child: const Center(
                              child: Text('Page 4',
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white,),),),
                        ),
                        Container(
                          color: Colors.orange,
                          child: const Center(
                              child: Text('Page 5',
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white,),),),
                        ),
                        Container(
                          color: Colors.purple,
                          child: const Center(
                              child: Text('Page 6',
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white,),),),
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
