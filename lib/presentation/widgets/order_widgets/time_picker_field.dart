import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_final_project/domain/store/order_store/order_store.dart';
import 'package:flutter_final_project/presentation/widgets/custom_container.dart';

class TimePickerField extends StatelessWidget {
  final OrderStore store;

  const TimePickerField({super.key, required this.store});

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
                    '${store.selectedTime.hour.toString().padLeft(2, '0')}:${store.selectedTime.minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down),
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
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width * 0.70,
            child: ListView.separated(
              itemCount: store.availableTimes.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final time = store.availableTimes[index];
                final isSelected = time == store.selectedTime;
                return ListTile(
                  title: Text(
                    '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
                  ),
                  trailing: isSelected ? const Icon(Icons.check, color: Colors.green) : null,
                  onTap: () {
                    store.selectTime(time);
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
      store.selectTime(selected);
    }
  }
}