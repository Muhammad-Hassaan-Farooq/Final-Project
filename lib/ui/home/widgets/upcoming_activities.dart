import 'package:final_project/domain/home/activity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../routing/routes.dart';

class UpcomingActivities extends StatelessWidget {
  final List<Activity> activities;

  const UpcomingActivities({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: activities
          .map((activity) => Padding(
                padding: EdgeInsets.fromLTRB(30, 16, 30, 16),
                child: InkWell(
                  onTap: (){
                    context.push('${Routes.activityNotes}/${activity.id}',
                        extra: activity);
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(16)),
                    child: SizedBox(
                      height: 75,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 75,
                            width: 15,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(16),bottomLeft: Radius.circular(16)),
                                color: Colors.black
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Text(DateFormat('hh:mm a')
                                .format(activity.startTime!),style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700
                            ),),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10,),
                              Text(activity.title,style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400
                              ),),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Theme.of(context).colorScheme.surface,
                                    width: 2,
                                  ),
                                ),
                                child: Text(
                                  activity.collaborators.isEmpty?"You": "+${activity.collaborators.length.toString()}",
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.onPrimary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),)
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
