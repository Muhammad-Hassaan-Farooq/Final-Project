import 'package:final_project/domain/home/activity.dart';
import 'package:final_project/routing/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ActivityCard extends StatelessWidget {
  final Activity _activity;
  final bool _isOwn;
  final bool _isToday;
  final void Function() _delete;
  final void Function() _remove;
  final void Function() _showModal;

  ActivityCard({
    super.key,
    required Activity activity,
    required bool isOwn,
    required bool isToday,
    void Function()? delete,
    void Function()? remove,
    void Function()? showModal,
  })  : _activity = activity,
        _isOwn = isOwn,
        _isToday = isToday,
        _delete = delete ?? (() {}),
        _remove = remove ?? (() {}),
        _showModal = showModal ?? (() {});

  String formatActivityDate(DateTime? startTime) {
    if (startTime == null) return 'No Date Set';

    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final formattedDate = DateFormat('MMMM dd, yyyy').format(startTime);

    if (startTime.isAfter(startOfDay.subtract(Duration(days: 1))) &&
        startTime.isBefore(startOfDay.add(Duration(days: 1)))) {
      return DateFormat('hh:mm a').format(startTime); // Show time if today
    }

    if (startTime.isBefore(now)) {
      final daysAgo = now.difference(startTime).inDays;
      return '$formattedDate\n$daysAgo day${daysAgo > 1 ? 's' : ''} ago';
    }

    final daysToGo = startTime.difference(now).inDays;
    return '$formattedDate\n$daysToGo day${daysToGo > 1 ? 's' : ''} to go';
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime = formatActivityDate(_activity.startTime);

    return Padding(
      padding: EdgeInsets.all(8),
      child: Material(
        elevation: 10,
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            context.push('${Routes.activityNotes}/${_activity.id}',
                extra: _activity);
          },
          borderRadius: BorderRadius.circular(16),
          child: Ink(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(
                  16), // Ensure Ink also has rounded corners
            ),
            child: Container(
              height: 200,
              child: Column(
                children: [
                  _isOwn
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (_isToday)
                              IconButton(
                                onPressed: _showModal,
                                icon: Icon(CupertinoIcons.pen),
                              ),
                            IconButton(
                                onPressed: _delete,
                                icon: Icon(CupertinoIcons.clear))
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: _remove, icon: Icon(Icons.remove))
                          ],
                        ),
                  Text(
                    _activity.title,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    _activity.category,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                  ),
                  Text(
                    formattedTime,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      overflow:TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
