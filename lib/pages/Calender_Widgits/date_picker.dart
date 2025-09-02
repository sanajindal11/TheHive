import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  final Function(DateTime?) onDateSelected; // Callback to pass the selected date

  const DatePicker({super.key, required this.onDateSelected});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? selectedDate;

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2025, 3, 25),
      firstDate: DateTime(2024),
      lastDate: DateTime(2026),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
      widget.onDateSelected(selectedDate);  // Pass selected date back to parent
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            Text("Date: ", style: TextStyle(fontSize: 18, color: Colors.grey.shade800)),
            SizedBox(width: 25),
            OutlinedButton(
              onPressed: _selectDate,
              child: const Text('Select Date',
              style: TextStyle(color: Color.fromARGB(255, 70, 58, 36)),
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Text(
              selectedDate != null
                  ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                  : 'No date selected',
            ),
            SizedBox(width: 25),
          ],
        ),
        Divider(
          color: Colors.grey.shade800,
          thickness: 1,
        ),
      ],
    );
  }
}
