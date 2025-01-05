import 'package:final_project/ui/home/view_models/layout_view_model.dart';
import 'package:final_project/ui/home/view_models/old_activities_view_model.dart';
import 'package:final_project/ui/home/view_models/today_activities_view_model.dart';
import 'package:final_project/ui/home/view_models/upcoming_activities_view_model.dart';
import 'package:final_project/ui/home/widgets/old_activities.dart';
import 'package:final_project/ui/home/widgets/today_activities.dart';
import 'package:final_project/ui/home/widgets/upcoming_activities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Layout extends StatelessWidget {
  final LayoutViewModel _viewModel;
  final String _title;

  const Layout(
      {super.key, required LayoutViewModel viewModel, required String title})
      : _viewModel = viewModel,
        _title = title;

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      TodayActivites(
        viewModel: TodayActivitiesViewModel(
          activityRepository: context.read(),
        ),
      ),
      UpcomingActivities(
          viewModel:
              UpcomingActivitiesViewModel(activityRepository: context.read())),
      OldActivities(
          viewModel:
          OldActivitiesViewModel(activityRepository: context.read())),
      Center(child: Text("Calendar View")),
    ];

    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Consumer<LayoutViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(_title),
              actions: [
                IconButton(
                    onPressed: _viewModel.logout,
                    icon: const Icon(Icons.logout))
              ],
            ),
            body: _pages[_viewModel.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
                onTap: _viewModel.onTabTapped,
                currentIndex: _viewModel.currentIndex,
                backgroundColor: Theme.of(context).colorScheme.primary,
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: Colors.white,
                selectedItemColor: Theme.of(context).colorScheme.secondary,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "Today"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.upcoming), label: "Upcoming"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.history), label: "History"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.calendar_month), label: "Calender"),
                ]),
          );
        },
      ),
    );
  }
}
