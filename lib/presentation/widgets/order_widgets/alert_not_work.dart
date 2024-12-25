import 'package:flutter/material.dart';
import 'package:flutter_final_project/presentation/widgets/custom_container.dart';
import 'package:flutter_final_project/presentation/styles/text_styles.dart';

class AlertNotWork extends StatelessWidget {
  const AlertNotWork({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    const start = TimeOfDay(hour: 19, minute: 30);
    const end = TimeOfDay(hour: 9, minute: 0);

    final bool isClosedToday = now.hour >= start.hour &&
        now.hour < 24;

    final bool isClosedTmrw = (now.hour >= 24 && now.hour < end.hour);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isClosedToday)
            CustomContainer(
              backgroundColor: Colors.black.withAlpha(30),
              children: const [
                Text(
                  'Зараз наш заклад не працює.\nЗробіть замовлення, а ми приготуємо його завтра після 9:00.',
                  style: TextStyles.cartText,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          if (isClosedTmrw)
            CustomContainer(
              backgroundColor: Colors.black.withAlpha(30),
              children: const [
                Text(
                  'Зараз наш заклад не працює.\nЗробіть замовлення, а ми приготуємо його після 9:00.',
                  style: TextStyles.cartText,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          // if (!isClosedToday && !isClosedTmrw) const SizedBox(),
        ],
      ),
    );
  }
}
