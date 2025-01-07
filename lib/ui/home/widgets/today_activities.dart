import 'package:final_project/domain/home/activity.dart';
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
          return Stack(
            children: [
              Column(
                children: [
                  const SizedBox(
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
                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            _viewModel.currentFilter ==
                                                    Filter.ALL
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .secondary
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .primary),
                                    onPressed: () {
                                      _viewModel.changeFilter(Filter.ALL);
                                    },
                                    child: Text("All",
                                        style: TextStyle(
                                            color: _viewModel.currentFilter ==
                                                    Filter.ALL
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .secondary)))),
                            const SizedBox(
                              width: 10,
                            ),
                            Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            _viewModel.currentFilter ==
                                                    Filter.SOLO
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .secondary
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .primary),
                                    onPressed: () {
                                      viewModel.changeFilter(Filter.SOLO);
                                    },
                                    child: Text("Solo",
                                        style: TextStyle(
                                            color: _viewModel.currentFilter ==
                                                    Filter.SOLO
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .secondary)))),
                            const SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          _viewModel.currentFilter ==
                                                  Filter.COLABS
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .secondary
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                  onPressed: () {
                                    viewModel.changeFilter(Filter.COLABS);
                                  },
                                  child: Text(
                                    "Colabs",
                                    style: TextStyle(
                                        color: _viewModel.currentFilter ==
                                                Filter.COLABS
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Theme.of(context)
                                                .colorScheme
                                                .secondary),
                                  )),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  switch (_viewModel.currentStatus) {
                    Status.LOADING => const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    Status.SUCCESS => Expanded(
                        child: ListView.builder(
                            itemCount: _viewModel.activities.length,
                            itemBuilder: (context, index) {
                              return ActivityCard(
                                  activity: _viewModel.activities[index],
                                  isOwn: _viewModel
                                      .isOwn(_viewModel.activities[index]),
                                  isToday: true,
                                  delete: () => _viewModel
                                      .delete(_viewModel.activities[index].id),
                                  remove: () => _viewModel
                                      .remove(_viewModel.activities[index].id),
                                  showModal: () => _showUpdateActivityModal(
                                      context, _viewModel.activities[index]));
                            }),
                      ),
                    Status.ERROR => const Expanded(
                        child: Center(
                          child: Text("Error loading activities"),
                        ),
                      ),
                  },
                ],
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: FloatingActionButton(
                      onPressed: () =>
                          _showCreateActivityModal(context, _viewModel),
                      child: const Icon(Icons.add),
                    ),
                  ))
            ],
          );
        },
      ),
    );
  }

  void _showCreateActivityModal(
      BuildContext context, TodayActivitiesViewModel viewModel) {
    final titleController = TextEditingController();
    final categoryController = TextEditingController();
    DateTime? startDate;
    DateTime? endDate;
    List<String> selectedCollaborators = [];
    List<Map<String, dynamic>> collaborators = [];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          // Use StatefulBuilder to update state within modal
          builder: (BuildContext context, StateSetter setState) {
            return Material(
                child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Create New Activity',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Activity Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: categoryController,
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: const Text('Start Date & Time'),
                    subtitle: Text(startDate?.toString() ?? 'Not set'),
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (date != null) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (time != null) {
                          setState(() {
                            startDate = DateTime(
                              date.year,
                              date.month,
                              date.day,
                              time.hour,
                              time.minute,
                            );
                          });
                        }
                      }
                    },
                  ),
                  ListTile(
                    title: const Text('End Date & Time'),
                    subtitle: Text(endDate?.toString() ?? 'Not set'),
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: startDate ?? DateTime.now(),
                        firstDate: startDate ?? DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (date != null) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (time != null) {
                          setState(() {
                            endDate = DateTime(
                              date.year,
                              date.month,
                              date.day,
                              time.hour,
                              time.minute,
                            );
                          });
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: const Text('Collaborators'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (selectedCollaborators.isEmpty)
                          const Text('No collaborators selected')
                        else
                          Wrap(
                            spacing: 8,
                            children: selectedCollaborators
                                    .take(3)
                                    .map((uid) => Chip(
                                          label: Text(
                                            collaborators.firstWhere((c) =>
                                                    c['uid'] ==
                                                    uid)['displayName'] ??
                                                collaborators.firstWhere((c) =>
                                                    c['uid'] == uid)['email'] ??
                                                'Unknown',
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        ))
                                    .toList() +
                                (selectedCollaborators.length > 3
                                    ? [
                                        Chip(
                                          label: Text(
                                            '+${selectedCollaborators.length - 3} more',
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        )
                                      ]
                                    : []),
                          ),
                      ],
                    ),
                    onTap: () async {
                      final fetchedCollaborators =
                          await viewModel.getCollaborators();
                      setState(() {
                        collaborators = fetchedCollaborators;
                      });
                      if (context.mounted) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Row(
                                children: [
                                  const Text('Select Collaborators'),
                                  const Spacer(),
                                  IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ],
                              ),
                              content: SizedBox(
                                width: double.maxFinite,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Search collaborators...',
                                        prefixIcon: const Icon(Icons.search),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      onChanged: (value) => setState(() {}),
                                    ),
                                    const SizedBox(height: 8),
                                    Flexible(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: collaborators.length,
                                        itemBuilder: (context, index) {
                                          final user = collaborators[index];
                                          final isSelected =
                                              selectedCollaborators
                                                  .contains(user['uid']);
                                          return ListTile(
                                            leading: CircleAvatar(
                                              child: Text(
                                                (user['email'] ??
                                                        user['displayName']
                                                            as String)[0]
                                                    .toUpperCase(),
                                              ),
                                            ),
                                            title: Text(user['email'] ??
                                                user['displayName']),
                                            trailing: isSelected
                                                ? Icon(Icons.check_circle,
                                                    color: Theme.of(context)
                                                        .primaryColor)
                                                : const Icon(
                                                    Icons.check_circle_outline),
                                            onTap: () {
                                              setState(() {
                                                if (isSelected) {
                                                  selectedCollaborators
                                                      .remove(user['uid']);
                                                } else {
                                                  selectedCollaborators
                                                      .add(user['uid']);
                                                }
                                              });
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Done'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          if (titleController.text.isNotEmpty &&
                              categoryController.text.isNotEmpty &&
                              startDate != null &&
                              endDate != null) {
                            _viewModel.add(
                                title: titleController.text,
                                category: categoryController.text,
                                startTime: startDate!,
                                endTime: endDate!,
                                collaborators: selectedCollaborators);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Create'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ));
          },
        );
      },
    );
  }

  void _showUpdateActivityModal(BuildContext context, Activity activity) {
    final titleController = TextEditingController();
    titleController.text = activity.title;
    final categoryController = TextEditingController();
    categoryController.text = activity.category;
    DateTime? startDate = activity.startTime;
    DateTime? endDate = activity.endTime;
    List<String> selectedCollaborators = List.from(activity.collaborators);
    List<Map<String, dynamic>> collaborators = [];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          // Use StatefulBuilder to update state within modal
          builder: (BuildContext context, StateSetter setState) {
            return Material(
                child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Create New Activity',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Activity Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: categoryController,
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: const Text('Start Date & Time'),
                    subtitle: Text(startDate?.toString() ?? 'Not set'),
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (date != null) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (time != null) {
                          setState(() {
                            startDate = DateTime(
                              date.year,
                              date.month,
                              date.day,
                              time.hour,
                              time.minute,
                            );
                          });
                        }
                      }
                    },
                  ),
                  ListTile(
                    title: const Text('End Date & Time'),
                    subtitle: Text(endDate?.toString() ?? 'Not set'),
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: startDate ?? DateTime.now(),
                        firstDate: startDate ?? DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (date != null) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (time != null) {
                          setState(() {
                            endDate = DateTime(
                              date.year,
                              date.month,
                              date.day,
                              time.hour,
                              time.minute,
                            );
                          });
                        }
                      }
                    },
                  ),
                  ListTile(
                    title: const Text('Collaborators'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (selectedCollaborators.isEmpty)
                          const Text('No collaborators selected')
                        else if (collaborators.isEmpty)
                          Text(
                              '${selectedCollaborators.length} collaborators selected')
                        else
                          Wrap(
                            spacing: 8,
                            children: selectedCollaborators.take(3).map((uid) {
                                  final collaborator = collaborators.firstWhere(
                                    (c) => c['uid'] == uid,
                                    orElse: () => {
                                      'displayName': 'Unknown',
                                      'email': 'Unknown'
                                    },
                                  );
                                  return Chip(
                                    label: Text(
                                      collaborator['displayName'] ??
                                          collaborator['email'] ??
                                          'Unknown',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  );
                                }).toList() +
                                (selectedCollaborators.length > 3
                                    ? [
                                        Chip(
                                          label: Text(
                                            '+${selectedCollaborators.length - 3} more',
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        )
                                      ]
                                    : []),
                          )
                      ],
                    ),
                    onTap: () async {
                      final fetchedCollaborators =
                          await _viewModel.getCollaborators();
                      setState(() {
                        collaborators = fetchedCollaborators;
                      });

                      if (context.mounted) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Row(
                                children: [
                                  const Text('Select Collaborators'),
                                  const Spacer(),
                                  IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ],
                              ),
                              content: SizedBox(
                                width: double.maxFinite,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Search collaborators...',
                                        prefixIcon: const Icon(Icons.search),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      onChanged: (value) => setState(() {}),
                                    ),
                                    const SizedBox(height: 8),
                                    Flexible(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: collaborators.length,
                                        itemBuilder: (context, index) {
                                          final user = collaborators[index];
                                          final isSelected =
                                              selectedCollaborators
                                                  .contains(user['uid']);
                                          final displayText =
                                              user['displayName'] ??
                                                  user['email'] ??
                                                  'Unknown';
                                          return ListTile(
                                            leading: CircleAvatar(
                                              child: Text(
                                                displayText.isNotEmpty
                                                    ? displayText[0]
                                                        .toUpperCase()
                                                    : '?',
                                              ),
                                            ),
                                            title: Text(displayText),
                                            trailing: isSelected
                                                ? Icon(Icons.check_circle,
                                                    color: Theme.of(context)
                                                        .primaryColor)
                                                : const Icon(
                                                    Icons.check_circle_outline),
                                            onTap: () {
                                              setState(() {
                                                if (isSelected) {
                                                  selectedCollaborators
                                                      .remove(user['uid']);
                                                } else {
                                                  selectedCollaborators
                                                      .add(user['uid']);
                                                }
                                              });
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Done'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          if (titleController.text.isNotEmpty &&
                              categoryController.text.isNotEmpty &&
                              startDate != null &&
                              endDate != null) {
                            _viewModel.update(
                                title: titleController.text,
                                category: categoryController.text,
                                startTime: startDate!,
                                endTime: endDate!,
                                collaborators: selectedCollaborators,
                                activity: activity,
                                activityId: activity.id);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Update'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ));
          },
        );
      },
    );
  }
}
