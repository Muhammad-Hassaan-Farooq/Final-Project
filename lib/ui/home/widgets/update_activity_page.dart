import 'package:final_project/domain/home/activity.dart';
import 'package:final_project/ui/home/bloc/update_activity/update_activity_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../routing/routes.dart';

class UpdateActivityPage extends StatelessWidget{

  final UpdateActivityBloc updateActivityBloc;

  const UpdateActivityPage({super.key, required this.updateActivityBloc});

  @override
    Widget build(BuildContext context) {
      return BlocProvider.value(
        value: updateActivityBloc,
        child: const UpdateActivityForm(),
      );
    }
  }



class UpdateActivityForm extends StatefulWidget {
  const UpdateActivityForm({super.key});

  @override
  State<UpdateActivityForm> createState() => _CreateActivityFormState();
}

class _CreateActivityFormState extends State<UpdateActivityForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final updateActivityBloc = context.read<UpdateActivityBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Activity'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title Input
              BlocBuilder<UpdateActivityBloc, UpdateActivityState>(
                builder: (context, state) {
                  return TextFormField(
                    initialValue: state.title,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      updateActivityBloc.add(ChangeFormInputEvent(title: value));
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  );
                },
              ),
              const SizedBox(height: 16),

              // Category Dropdown
              BlocBuilder<UpdateActivityBloc, UpdateActivityState>(
                builder: (context, state) {
                  return DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(),
                    ),
                    value: state.category ?? 'Work',
                    items: ['Work', 'Personal', 'Study', 'Exercise', 'Other']
                        .map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (value) {
                      updateActivityBloc.add(ChangeFormInputEvent(category: value));
                    },
                  );
                },
              ),
              const SizedBox(height: 16),

              // Start Time
              BlocBuilder<UpdateActivityBloc, UpdateActivityState>(
                builder: (context, state) {
                  return ListTile(
                    title: const Text('Start Time'),
                    subtitle: Text(
                      state.startTime != null
                          ? DateFormat('MMM dd, yyyy - hh:mm a')
                          .format(state.startTime!)
                          : 'Not set',
                    ),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final picked = await _showDateTimePicker(context);
                      if (picked != null) {
                        updateActivityBloc.add(ChangeFormInputEvent(startTime: picked));
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 16),

              // End Time
              BlocBuilder<UpdateActivityBloc, UpdateActivityState>(
                builder: (context, state) {
                  return ListTile(
                    title: const Text('End Time'),
                    subtitle: Text(
                      state.endTime != null
                          ? DateFormat('MMM dd, yyyy - hh:mm a')
                          .format(state.endTime!)
                          : 'Not set',
                    ),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final picked = await _showDateTimePicker(context);
                      if (picked != null) {
                        updateActivityBloc.add(ChangeFormInputEvent(endTime: picked));
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 32),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {

                    context.read<UpdateActivityBloc>().add(SubmitEvent());
                    context.push(Routes.home,
                        extra: updateActivityBloc.activity);

                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Update Activity'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<DateTime?> _showDateTimePicker(BuildContext context) async {
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
        return DateTime(date.year, date.month, date.day, time.hour, time.minute);
      }
    }
    return null;
  }
}
