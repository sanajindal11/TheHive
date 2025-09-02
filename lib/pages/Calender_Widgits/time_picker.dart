import 'package:flutter/material.dart';

class TimePicker extends StatelessWidget {
  final Function(TimeOfDay) onTimeSelected;

  const TimePicker({super.key, required this.onTimeSelected});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.access_time),
      onPressed: () async {
        // Show time picker
        final TimeOfDay? selectedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
    
        if (selectedTime != null) {
          onTimeSelected(selectedTime); // Pass selected time back
        }
      },
    );
  }
}
