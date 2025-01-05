import 'package:final_project/ui/home/view_models/today_activities_view_model.dart';
import 'package:final_project/ui/home/widgets/activity_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodayActivites extends StatelessWidget {
  final TodayActivitiesViewModel _viewModel;

  const TodayActivites({super.key, required TodayActivitiesViewModel viewModel})
      : _viewModel = viewModel;

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.changeFilter(Filter.ALL);
    });

    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Consumer<TodayActivitiesViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.6)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        _viewModel.currentFilter == Filter.ALL
                                            ? Theme.of(context)
                                                .colorScheme
                                                .secondary
                                            : Theme.of(context)
                                                .colorScheme
                                                .primary),
                                onPressed: () {
                                  _viewModel.changeFilter(Filter.ALL);
                                },
                                child: Text("All",style:
                                TextStyle(
                                    color: _viewModel.currentFilter == Filter.ALL
                                        ? Theme.of(context)
                                        .colorScheme
                                        .primary
                                        : Theme.of(context)
                                        .colorScheme
                                        .secondary
                                )))),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                    _viewModel.currentFilter == Filter.SOLO
                                        ? Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        : Theme.of(context)
                                        .colorScheme
                                        .primary),
                                onPressed: () {
                                  viewModel.changeFilter(Filter.SOLO);
                                }, child: Text("Solo",style:
                            TextStyle(
                                color: _viewModel.currentFilter == Filter.SOLO
                                    ? Theme.of(context)
                                    .colorScheme
                                    .primary
                                    : Theme.of(context)
                                    .colorScheme
                                    .secondary
                            )))),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  _viewModel.currentFilter == Filter.COLABS
                                      ? Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      : Theme.of(context)
                                      .colorScheme
                                      .primary),
                              onPressed: () {
                                viewModel.changeFilter(Filter.COLABS);
                              }, child: Text("Colabs",style:
                            TextStyle(
                              color: _viewModel.currentFilter == Filter.COLABS
                                  ? Theme.of(context)
                                  .colorScheme
                                  .primary
                                  : Theme.of(context)
                                  .colorScheme
                                  .secondary
                            ),)),
                        )
                      ],
                    ),
                  )
                ],
              ),
              switch(_viewModel.currentStatus){


                Status.LOADING => Expanded(child: Center(
                  child: CircularProgressIndicator(),
                ),),

                
                Status.SUCCESS => Expanded(child: ListView.builder(itemCount: _viewModel.activities.length,itemBuilder: (context,index){
                  return ActivityCard(activity: _viewModel.activities[index]);
                }),),

                Status.ERROR => Expanded(child: Center(
                  child: Text("Error loading activities"),
                ),),
              }

            ],
          );
        },
      ),
    );
  }
}
