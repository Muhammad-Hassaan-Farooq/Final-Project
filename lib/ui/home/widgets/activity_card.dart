import 'package:final_project/domain/home/activity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActivityCard extends StatelessWidget {
  final Activity _activity;

  const ActivityCard({super.key, required Activity activity})
      : _activity = activity;

  @override
  Widget build(BuildContext context) {
    // Fallback date format in case startTime is null
    String formattedTime = _activity.startTime != null
        ? DateFormat('hh:mm a').format(_activity.startTime!)
        : 'No Time Set'; // You can set a fallback string here

    return Padding(
      padding: EdgeInsets.all(8),
      child: Material(
        elevation: 10,
        color: Colors.transparent,
        child: InkWell(
          onTap: () {

            print("Activity tapped: ${_activity.title}");
          },
          borderRadius: BorderRadius.circular(16),
          child: Ink(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16), // Ensure Ink also has rounded corners
            ),
            child: Container(
              height: 200,
              child: ListTile(
                title: Text(_activity.title),
                subtitle: Text(formattedTime),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
