import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_final_project/presentation/styles/text_styles.dart';
import 'package:flutter_final_project/presentation/widgets/contacts/interactive_gesture_detector.dart';

class ContactsWidget extends StatefulWidget {
  const ContactsWidget({super.key});

  @override
  State<ContactsWidget> createState() => _ContactsWidgetState();
}

class _ContactsWidgetState extends State<ContactsWidget> {
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
                child: Row(
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
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Observer(
                  builder: (_) => Column(
                    children: [
                      Text(
                        'КОНТАКТИ',
                        style: TextStyles.cartBottomText,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: [
                          InteractiveGestureDetector(
                            label: '+380633425372',
                            actionUri: 'tel:+380633425372',
                            icon: Icons.phone,
                            errorMessage: 'Cannot open the phone dialer',
                            textStyle: TextStyles.cartBottomText,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          InteractiveGestureDetector(
                            label: 'mlintsi83@gmail.com',
                            actionUri: 'mailto:mlintsi83@gmail.com?subject=Hello&body=Your+message+here',
                            icon: Icons.email,
                            errorMessage: 'Cannot open the email client',
                            textStyle: TextStyles.cartBottomText,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          InteractiveGestureDetector(
                            label: 'проспект соборності, 7Б, Київ',
                            actionUri: 'geo:0,0?q=проспект+соборності,+7Б,+Київ',
                            icon: Icons.location_on,
                            errorMessage: 'Cannot launch Google Maps',
                            textStyle: TextStyles.cartBottomText,
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
