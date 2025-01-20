import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_project/domain/home/activity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../routing/routes.dart';

class OngoingActivities extends StatelessWidget {
  final List<Activity> activities;

  const OngoingActivities({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: activities.map((activity) {

          final now = DateTime.now();
          final totalDuration = activity.endTime!.difference(activity.startTime!).inMilliseconds;
          final elapsedDuration = now.difference(activity.startTime!).inMilliseconds;
          final progress = elapsedDuration/totalDuration;

          return Material(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(24),
              elevation: 10,
              child: InkWell(
                onTap: () {
                  context.push('${Routes.activityNotes}/${activity.id}',
                      extra: activity);
                },
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            activity.title,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              stops: [progress, progress],
                              colors: [
                               Theme.of(context).colorScheme.secondary,
                                Theme.of(context).colorScheme.onPrimary
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16)),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(DateFormat('hh:mm a')
                                      .format(activity.startTime!)),
                                  Text("Started"),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(DateFormat('hh:mm a')
                                      .format(activity.endTime!),
                                  style: TextStyle(
                                  )
                                  ),
                                  Text("End"),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ));
        }).toList(),
        options: CarouselOptions(
            enableInfiniteScroll: false,
            autoPlay: true,
            viewportFraction: 0.85,
            enlargeCenterPage: true));
  }
}
