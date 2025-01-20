import 'package:final_project/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../domain/home/activity.dart';
import '../bloc/navbar/home_page_bloc.dart';

class HistoryPage extends StatelessWidget {
  final HomePageState state;

  const HistoryPage({super.key, required this.state});

  Map<DateTime, List<Activity>> _groupActivitiesByDate(List<Activity> activities) {
    final Map<DateTime, List<Activity>> grouped = {};

    for (var activity in activities) {
      if (activity.startTime == null) continue;

      final date = DateTime(
        activity.startTime!.year,
        activity.startTime!.month,
        activity.startTime!.day,
      );

      if (!grouped.containsKey(date)) {
        grouped[date] = [];
      }
      grouped[date]!.add(activity);
    }

    grouped.forEach((date, activities) {
      activities.sort((a, b) => b.startTime!.compareTo(a.startTime!));
    });

    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    if (state is HomePageLoadingState) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is HomePageErrorState) {
      return const Center(child: Text('Error loading history'));
    }

    if (state is HomePageSuccessState) {
      final activities = (state as HomePageSuccessState).activites;
      final groupedActivities = _groupActivitiesByDate(activities);
      final sortedDates = groupedActivities.keys.toList()
        ..sort((a, b) => b.compareTo(a));

      return SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(30.0),
                child: Text(
                  'Activity History',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final date = sortedDates[index];
                  final dayActivities = groupedActivities[date]!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 8.0,
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                DateFormat.yMMMd().format(date),
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${dayActivities.length} activities',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ...dayActivities.map((activity) => Padding(
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
                      )),
                    ],
                  );
                },
                childCount: sortedDates.length,
              ),
            ),
          ],
        ),
      );
    }

    return const Center(child: Text('No history available'));
  }
}