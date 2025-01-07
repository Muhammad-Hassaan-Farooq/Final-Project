import 'package:final_project/domain/activity/note.dart';
import 'package:final_project/domain/home/activity.dart';
import 'package:final_project/ui/activity/widgets/text_note.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../view_models/activity_view_model.dart';

class ActivityNotes extends StatelessWidget {
  final ActivityViewModel _viewModel;

  ActivityNotes({super.key, required ActivityViewModel viewModel})
      : _viewModel = viewModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_viewModel.activity.title),
        ),
        body: Consumer<ActivityViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.grey, // Color of the line
                              thickness: 1, // Thickness of the line
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              DateFormat('hh:mm a')
                                  .format(_viewModel.activity.startTime!),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey, // Text color
                              ),
                            ),
                          ),
                          // Right Line
                          Expanded(
                            child: Divider(
                              color: Colors.grey, // Color of the line
                              thickness: 1, // Thickness of the line
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          )
                        ],
                      ),
                      switch (_viewModel.currentState) {
                        UIState.LOADING => Center(
                            child: CircularProgressIndicator(),
                          ),
                        UIState.SUCCESS => _viewModel.notes.isEmpty
                            ? Center(
                                child: Text("No Notes? Start writing"),
                              )
                            : Column(
                          children: _viewModel.notes.map((note) {
                            return FutureBuilder<String>(
                              future: _viewModel.getEmail(note.userId), // Fetch email for each note
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return CircularProgressIndicator(); // Show loading indicator while fetching email
                                }

                                if (snapshot.hasError) {
                                  return Text('Error fetching email');
                                }

                                // Get email from snapshot
                                String email = snapshot.data ?? 'No email found';

                                return TextNote(
                                  content: note.content,
                                  time: note.timestamp,
                                  user: note.userId,
                                  isOwn: _viewModel.userID == note.userId,
                                  delete: () {
                                    _viewModel.deleteNote(note.id);
                                  },
                                  showModal: () {
                                    _showUpdateNoteModal(context, _viewModel, note);
                                  },
                                  email: email, // Pass the email to TextNote widget
                                );
                              },
                            );
                          }).toList(),
                        ),
                        UIState.ERROR =>
                          Center(child: Text("Error loading notes")),
                      },
                      Row(
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              DateFormat('hh:mm a')
                                  .format(_viewModel.activity.endTime!),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          // Right Line
                          Expanded(
                            child: Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          )
                        ],
                      ),
                    ],
                  ),
                )),
                _viewModel.isActive
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: IconButton(
                              onPressed: () =>
                                  _showAddNoteModal(context, _viewModel),
                              icon: Icon(Icons.add),
                              style: IconButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.surface,
                                  elevation: 20),
                            ),
                          )
                        ],
                      )
                    : SizedBox(),
              ],
            );
          },
        ),
      ),
    );
  }
}

void _showAddNoteModal(BuildContext context, ActivityViewModel viewModel) {
  final contentController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
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
              'Add New Note',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: contentController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Note Content',
                border: OutlineInputBorder(),
              ),
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
                    if (contentController.text.isNotEmpty) {
                      viewModel.addNote(contentController.text);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      );
    },
  );
}
void _showUpdateNoteModal(BuildContext context, ActivityViewModel viewModel, Note note) {
  final contentController = TextEditingController(text: note.content);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
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
              'Update Note',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: contentController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Note Content',
                border: OutlineInputBorder(),
              ),
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
                    if (contentController.text.isNotEmpty) {
                      viewModel.updateNote(note.id, contentController.text);
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
      );
    },
  );
}
