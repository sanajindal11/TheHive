import 'package:flutter/material.dart';
import 'package:flutter_application_1/componants/my_button.dart';
import 'package:flutter_application_1/pages/Calender_Widgits/date_picker.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';


class EventTile extends StatelessWidget {
  final String eventName;
  final String eventDate;
  final String startTime;
  final String endTime; 
  final String eventLocation;
  Function(BuildContext)? deleteFunction;

  EventTile({
    super.key,
    required this.eventName,
    required this.eventDate,
    required this.startTime,
    required this.endTime,
    required this.eventLocation,
    required this.deleteFunction,
  });



  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      color: Color.fromARGB(255, 250, 240, 213),
      elevation: 5,
        child: Slidable(
          endActionPane: ActionPane(
             motion: StretchMotion(),
             children: [
                SlidableAction(
                  onPressed: deleteFunction,
                  icon: Icons.delete,
                  backgroundColor: Colors.red.shade300,
                  borderRadius: BorderRadius.circular(12,
                ),
              ),
             ],
             ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(15),
            title: Text(
              eventName,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Date: $eventDate',
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  'Time: $startTime - $endTime',
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  'Location: $eventLocation',
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            trailing: const Icon(Icons.calendar_month_rounded),
            onTap: () {
              // Navigate to event details screen
            },
          ),
        ),
      
    );
  }
}