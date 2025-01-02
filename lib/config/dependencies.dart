import 'package:final_project/data/repositories/auth/auth_repository.dart';
import 'package:final_project/data/repositories/auth/mock_auth_repository.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
List<SingleChildWidget> _sharedProviders = [

];

List<SingleChildWidget> get providersMock{
  return [
    ChangeNotifierProvider.value(
      value: MockAuthRepository() as AuthRepository,
    )
    ,..._sharedProviders
  ];
}