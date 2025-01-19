import 'package:final_project/data/repositories/activity/firebase_note_repository.dart';
import 'package:final_project/data/repositories/activity/mock_note_repository.dart';
import 'package:final_project/data/repositories/activity/note_repository.dart';
import 'package:final_project/data/repositories/auth/auth_repository.dart';
import 'package:final_project/data/repositories/auth/firebase_auth_repository.dart';
import 'package:final_project/data/repositories/auth/mock_auth_repository.dart';
import 'package:final_project/data/repositories/home/activity_repository.dart';
import 'package:final_project/data/repositories/home/firebase_activity_repository.dart';
import 'package:final_project/data/repositories/home/mock_activity_repository.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';


List<SingleChildWidget> _sharedProviders = [];


List<SingleChildWidget> get providersMock {
  return [
    ChangeNotifierProvider<AuthRepository>(
      create: (_) => MockAuthRepository(),
    ),
    ChangeNotifierProvider<ActivityRepository>(
      create: (_) => MockActivityRepository(),
    ),
    ChangeNotifierProvider<NoteRepository>(
      create: (_) => MockNoteRepository(),
    ),
    ..._sharedProviders,
  ];
}

List<SingleChildWidget> get providersNetwork {
  return [
    ChangeNotifierProvider<AuthRepository>(
      create: (_) => FirebaseAuthRepository(),
    ),
    ChangeNotifierProvider<ActivityRepository>(
      create: (_) => FirebaseActivityRepository(),
    ),
    ChangeNotifierProvider<NoteRepository>(
      create: (_) => FirebaseNoteRepository(),
    ),
    ..._sharedProviders,
  ];
}
