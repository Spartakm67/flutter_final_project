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

    DateTime startDateTime =
        DateTime(now.year, now.month, now.day, start.hour, start.minute);
    DateTime endDateTimeTomorrow = DateTime(
      now.year,
      now.month,
      now.hour < end.hour ? now.day : now.day + 1,
      end.hour,
      end.minute,
    );

    final bool isClosedToday = now.isAfter(startDateTime);
    final bool isClosedTomorrow =
        now.isBefore(endDateTimeTomorrow) && now.hour < end.hour;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isClosedToday && now.isBefore(endDateTimeTomorrow))
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
          if (isClosedTomorrow)
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
        ],
      ),
    );
  }
}
