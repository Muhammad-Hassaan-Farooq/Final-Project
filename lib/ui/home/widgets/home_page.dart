import 'package:final_project/ui/home/bloc/navbar/home_page_bloc.dart';
import 'package:final_project/ui/home/widgets/ongoing_activities.dart';
import 'package:final_project/ui/home/widgets/upcoming_activities.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final HomePageState state;
  const HomePage({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
              Row(
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                  const SizedBox(
                    width: 10,
                  ),
                  const CircleAvatar(
                    child: Text("A"),
                  )
                ],
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {},
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.all(8.0),
                child: Material(
                  elevation: true ? 8.0 : 0.0,
                  borderRadius: BorderRadius.circular(16),
                  color: true
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.surface,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    child: Text(
                      "Solo",
                      style: TextStyle(
                        color: true
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () {},
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.all(8.0),
                child: Material(
                  elevation:
                      true ? 8.0 : 0.0, // Change elevation based on state
                  borderRadius: BorderRadius.circular(16),
                  color: true
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.surface,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    child: Text(
                      "Colab",
                      style: TextStyle(
                        color: true
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        if (state is HomePageLoadingState)
          SizedBox(
              height: 500,
              child: Center(
                child: CircularProgressIndicator(),
              ))
        else if (state is HomePageSuccessState)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(30, 16, 24, 16),
                child: const Text(
                  'Ongoing Activities',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              OngoingActivities(
                  activities: (state as HomePageSuccessState).ongoing),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 20, 24, 16),
                child: const Text(
                  'Upcoming Activities',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              UpcomingActivities(
                  activities: (state as HomePageSuccessState).upcoming)
            ],
          )
        else if (state is HomePageErrorState)
          SizedBox(
              height: 500,
              child: Center(
                child: Text("Error loading activities"),
              ))
      ],
    ));
  }
}
