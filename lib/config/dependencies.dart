import 'package:final_project/data/repositories/auth/auth_repository.dart';
import 'package:final_project/data/repositories/auth/firebase_auth_repository.dart';
import 'package:final_project/data/repositories/auth/mock_auth_repository.dart';
import 'package:final_project/data/repositories/home/activity_repository.dart';
import 'package:final_project/data/repositories/home/firebase_activity_service.dart';
import 'package:final_project/data/repositories/home/mock_activity_repository.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// Common shared providers (e.g., services used across the app)
List<SingleChildWidget> _sharedProviders = [];

/// Mock Providers
List<SingleChildWidget> get providersMock {
  return [
    ChangeNotifierProvider<AuthRepository>(
      create: (_) => MockAuthRepository(),
    ),
    ChangeNotifierProvider<ActivityRepository>(
      create: (_) => MockActivityRepository(),
    ),
    ..._sharedProviders,
  ];
}

/// Network Providers
List<SingleChildWidget> get providersNetwork {
  return [
    ChangeNotifierProvider<AuthRepository>(
      create: (_) => FirebaseAuthRepository(),
    ),
    ChangeNotifierProvider<ActivityRepository>(
      create: (_) => FirebaseActivityRepository(),
    ),
    ..._sharedProviders,
  ];
}
