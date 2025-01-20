import 'package:final_project/routing/routes.dart';
import 'package:final_project/ui/home/bloc/navbar/home_page_bloc.dart';
import 'package:final_project/ui/home/widgets/bottom_nav_bar.dart';
import 'package:final_project/ui/home/widgets/history_page.dart';
import 'package:final_project/ui/home/widgets/home_page.dart';
import 'package:final_project/ui/home/widgets/upcoming_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Layout extends StatelessWidget {
  final HomePageBloc _navBarBloc;
  final String _title;

  const Layout(
      {super.key, required HomePageBloc navBarBloc, required String title})
      : _navBarBloc = navBarBloc,
        _title = title;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider.value(value: _navBarBloc)],
      child: Scaffold(
        extendBody: true,
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add), onPressed: () {
              context.push(Routes.createActivity);
        }),
        bottomNavigationBar: const BottomNavBar(),
        body: BlocBuilder<HomePageBloc, HomePageState>(
          builder: (context, state) {
            Widget currentPage;
            switch (state.index) {
              case 0:
                currentPage = HomePage(
                  state: state,
                );
                break;
              case 1:
                currentPage =UpcomingPage(state: state);
                break;
              case 2:
                currentPage = HistoryPage(
                  state:state
                );
                break;
              default:
                currentPage = Container(); // Fallback for unknown states
            }

            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Container(
                key: ValueKey<int>(state.index), // Unique key for each page
                child: currentPage,
              ),
            );
          },
        ),
      ),
    );
  }
}
