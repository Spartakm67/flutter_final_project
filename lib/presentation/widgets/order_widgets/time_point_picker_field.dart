import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_final_project/domain/store/order_store/order_store.dart';

class TimePointPickerField extends StatelessWidget {
  final OrderStore orderStore;

  const TimePointPickerField({super.key, required this.orderStore});

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
                    size: 24.0, color: Colors.black),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showTimePicker(BuildContext context) async {
    final selected = await showDialog<TimeOfDay>(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.70,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: orderStore.availablePointTimes.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final time = orderStore.availablePointTimes[index];
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
        );
      },
    );
    if (selected != null) {
      orderStore.selectTime(selected);
    }
  }
}
