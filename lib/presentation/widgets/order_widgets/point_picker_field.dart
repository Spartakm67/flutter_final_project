import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_final_project/domain/store/order_store/order_store.dart';

class PointPickerField extends StatelessWidget {
  final OrderStore orderStore;

  const PointPickerField({super.key, required this.orderStore});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return GestureDetector(
          onTap: () => _showPointPicker(context),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Icon(Icons.restaurant_menu,
                    size: 24.0, color: Colors.black,),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    orderStore.selectedPoint.isNotEmpty
                        ? orderStore.selectedPoint
                        : 'Виберіть заклад',
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

  Future<void> _showPointPicker(BuildContext context) async {
    final selected = await showDialog<String>(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.70,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: orderStore.availablePoints.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final point = orderStore.availablePoints[index];
                final isSelected = point == orderStore.selectedPoint;
                return ListTile(
                  title: Text(point),
                  trailing: isSelected
                      ? const Icon(Icons.check, color: Colors.green)
                      : null,
                  onTap: () {
                    orderStore.selectPoint(point);
                    Navigator.pop(context, point);
                  },
                );
              },
            ),
          ),
        );
      },
    );
    if (selected != null) {
      orderStore.selectPoint(selected);
    }
  }
}
