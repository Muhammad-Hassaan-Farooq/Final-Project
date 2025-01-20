import 'package:final_project/routing/router.dart';
import 'package:final_project/routing/routes.dart';
import 'package:final_project/ui/home/bloc/create_activity/create_activity_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';


class CreateActivityPage extends StatelessWidget {
  final CreateActivityBloc createActivityBloc;

  const CreateActivityPage({super.key, required this.createActivityBloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: createActivityBloc,
      child: const CreateActivityForm(),
    );
  }
}
class CreateActivityForm extends StatefulWidget {
  const CreateActivityForm({super.key});

  @override
  State<CreateActivityForm> createState() => _CreateActivityFormState();
}

class _CreateActivityFormState extends State<CreateActivityForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final createActivityBloc = context.read<CreateActivityBloc>();

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
              BlocBuilder<CreateActivityBloc, CreateActivityState>(
                builder: (context, state) {
                  return TextFormField(
                    initialValue: state.title,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      createActivityBloc.add(ChangeFormInputEvent(title: value));
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
              BlocBuilder<CreateActivityBloc, CreateActivityState>(
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
                      createActivityBloc.add(ChangeFormInputEvent(category: value));
                    },
                  );
                },
              ),
              const SizedBox(height: 16),

              // Start Time
              BlocBuilder<CreateActivityBloc, CreateActivityState>(
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
                        createActivityBloc.add(ChangeFormInputEvent(startTime: picked));
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 16),

              // End Time
              BlocBuilder<CreateActivityBloc, CreateActivityState>(
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
                        createActivityBloc.add(ChangeFormInputEvent(endTime: picked));
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 32),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {

                    context.read<CreateActivityBloc>().add(SubmitEvent());
                    context.push(Routes.home);

                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Create Activity'),
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
