import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_final_project/domain/store/order_store/order_store.dart';
import 'package:flutter_final_project/main.dart';
import 'package:flutter_final_project/presentation/styles/text_styles.dart';

class TimePickerField extends StatelessWidget {
  final OrderStore orderStore;

  const TimePickerField({super.key, required this.orderStore});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return GestureDetector(
          onTap: () => _showTimePicker(context),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Icon(Icons.access_time),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    '${orderStore.selectedTime.hour.toString().padLeft(2, '0')}:${orderStore.selectedTime.minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down,
                    size: 24.0, color: Colors.black,),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showTimePicker(BuildContext context) async {
    orderStore.regenerateAvailableTimes();

    final selected = await showDialog<TimeOfDay>(
      context: context,
      builder: (context) {
        final now = DateTime.now();
        final isOutOfWorkingHours = now.hour >= 20 && now.hour < 24;

        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isOutOfWorkingHours)
                Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Text(
                    'Час замовлення на завтра',
                    style: TextStyles.alertKeyText,
                  ),
                ),
              SizedBox(
                width: screenWidth * 0.80,
                height: screenHeight * 0.8,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: orderStore.availableTimes.length,
                  separatorBuilder: (_, __) => const Divider(
                    color: Color(0xFFBDBDBD),
                    thickness: 1,
                    height: 1,
                  ),
                  itemBuilder: (context, index) {
                    final time = orderStore.availableTimes[index];
                    final isSelected = time == orderStore.selectedTime;

                    return ListTile(
                      title: Text(
                        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
                      ),
                      trailing: isSelected
                          ? const Icon(Icons.check, color: Colors.green)
                          : null,
                      onTap: () {
                        orderStore.selectTime(time);
                        Navigator.pop(context, time);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );

      },
    );
    if (selected != null) {
      orderStore.selectTime(selected);
    }
  }
}

// final hasTomorrowSlots = orderStore.availableTimes.any(
//       (t) => t.hour >= 20 && t.hour < 24,
// );