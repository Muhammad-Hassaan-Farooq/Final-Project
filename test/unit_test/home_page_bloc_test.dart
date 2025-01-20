import 'package:final_project/data/repositories/auth/mock_auth_repository.dart';
import 'package:final_project/data/repositories/home/mock_activity_repository.dart';
import 'package:final_project/domain/home/activity.dart';
import 'package:final_project/ui/home/bloc/navbar/home_page_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  late MockActivityRepository mockActivityRepository;
  late MockAuthRepository mockAuthRepository;
  late HomePageBloc homePageBloc;

  setUp(() {
    mockActivityRepository = MockActivityRepository();
    mockAuthRepository = MockAuthRepository();
    homePageBloc = HomePageBloc(
      activityRepository: mockActivityRepository,
      authRepository: mockAuthRepository,
    );
  });

  tearDown(() {
    homePageBloc.close();
  });

  group('HomePageBloc', ()
  {
    test('initial state should be HomePageSuccessState', () {
      expect(homePageBloc.state, isA<HomePageSuccessState>());
      expect(homePageBloc.state.index, equals(0));
      expect(homePageBloc.state.previousIndex, equals(0));
    });
  });
}
