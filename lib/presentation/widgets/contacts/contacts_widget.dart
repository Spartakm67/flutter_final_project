import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_final_project/presentation/styles/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

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
          height: MediaQuery.of(context).size.height * 0.6,
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
                      const Text(
                        'КОНТАКТИ',
                        style: TextStyles.cartBottomText,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              final messenger = ScaffoldMessenger.of(context);
                              final uri = Uri(scheme: 'tel', path: '+380633425372');
                              final canLaunch = await canLaunchUrl(uri);
                              if (canLaunch) {
                                await launchUrl(uri);
                              } else {
                                messenger.showSnackBar(
                                  const SnackBar(content: Text('Cannot launch phone dialer')),
                                );
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              color: Colors.transparent,
                              child: const Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.phone, color: Colors.black),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '+380633425372',
                                          style: TextStyles.cartBottomText,
                                        ),
                                        Divider(
                                          thickness: 1,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          GestureDetector(
                            onTap: () async {
                              final messenger = ScaffoldMessenger.of(context);
                              final uri = Uri(
                                scheme: 'mailto',
                                path: 'mlintsi83@gmail.com',
                                query: Uri.encodeQueryComponent('subject=Hello&body=Your message here'),
                              );
                              final canLaunch = await canLaunchUrl(uri);
                              if (canLaunch) {
                                await launchUrl(uri);
                              } else {
                                messenger.showSnackBar(
                                  const SnackBar(content: Text('Cannot launch email client')),
                                );
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              color: Colors.transparent,
                              child: const Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.email, color: Colors.black),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'mlintsi83@gmail.com',
                                          style: TextStyles.cartBottomText,
                                        ),
                                        Divider(
                                          thickness: 1,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          GestureDetector(
                            onTap: () async {
                              final messenger = ScaffoldMessenger.of(context);
                              final uri = Uri.parse('https://www.google.com/maps/search/?q=проспект+соборності,+7Б,+Київ');
                              final canLaunch = await canLaunchUrl(uri);
                              if (canLaunch) {
                                await launchUrl(uri);
                              } else {
                                messenger.showSnackBar(
                                  const SnackBar(content: Text('Cannot launch Google Maps')),
                                );
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              color: Colors.transparent,
                              child: const Text(
                                'проспект соборності, 7Б, Київ',
                                style: TextStyles.cartBottomText,
                              ),
                            ),
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
