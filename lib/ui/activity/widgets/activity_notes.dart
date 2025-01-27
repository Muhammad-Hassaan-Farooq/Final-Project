import 'dart:io';

import 'package:final_project/domain/activity/note.dart';
import 'package:final_project/domain/home/activity.dart';
import 'package:final_project/routing/router.dart';
import 'package:final_project/routing/routes.dart';
import 'package:final_project/ui/activity/widgets/text_note.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
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
          actions: _viewModel.userID==_viewModel.activity.ownerId?[
            IconButton(onPressed: (){
              context.push("${Routes.updateActivity}/${_viewModel.activity.id}",extra: _viewModel.activity);
            }, icon: Icon(Icons.edit))
          ]:null,
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
                          const SizedBox(
                            height: 100,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          const Expanded(
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
                                  .format(_viewModel.activity.startTime!),
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          // Right Line
                          const Expanded(
                            child: Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          )
                        ],
                      ),
                      switch (_viewModel.currentState) {
                        UIState.LOADING => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        UIState.SUCCESS => _viewModel.notes.isEmpty
                            ? const Center(
                                child: Text("No Notes? Start writing"),
                              )
                            : Column(
                          children: _viewModel.notes.map((note) {
                            return FutureBuilder<String>(
                              future: _viewModel.getEmail(note.userId),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
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
                                    email: "",
                                  );
                                }

                                if (snapshot.hasError) {
                                  return const Text('Error fetching email');
                                }


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
                                  email: email,
                                );
                              },
                            );
                          }).toList(),
                        ),
                        UIState.ERROR =>
                          const Center(child: Text("Error loading notes")),
                      },
                      Row(
                        children: [
                          const SizedBox(
                            height: 100,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          const Expanded(
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
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          // Right Line
                          const Expanded(
                            child: Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                          ),
                          const SizedBox(
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
                            padding: const EdgeInsets.all(16),
                            child: IconButton(
                              onPressed: () =>
                                  _showAddNoteModal(context, _viewModel),
                              icon: const Icon(Icons.add),
                              style: IconButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.surface,
                                  elevation: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: IconButton(
                              onPressed: () =>
                                  _showAddImageModal(context, _viewModel),
                              icon: const Icon(Icons.image),
                              style: IconButton.styleFrom(
                                  backgroundColor:
                                  Theme.of(context).colorScheme.surface,
                                  elevation: 20),
                            ),
                          )
                        ],
                      )
                    : const SizedBox(),
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
                      viewModel.addTextNote(contentController.text);
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

void _showAddImageModal(BuildContext context, ActivityViewModel viewModel) {
  File? selectedImage;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
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
                  'Add New Image',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: selectedImage != null
                      ? Image.file(
                    selectedImage!,
                    fit: BoxFit.cover,
                  )
                      : const Center(
                    child: Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 48,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? pickedImage = await picker.pickImage(
                      source: ImageSource.gallery,
                    );

                    if (pickedImage != null) {
                      setState(() {
                        selectedImage = File(pickedImage.path);
                      });
                    }
                  },
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Choose Image'),
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
                      onPressed: selectedImage != null
                          ? () {
                        viewModel.addImageNote(selectedImage!);
                        Navigator.pop(context);
                      }
                          : null,
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
    },
  );
}
