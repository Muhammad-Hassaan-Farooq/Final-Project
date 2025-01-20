import 'package:final_project/data/repositories/auth/mock_auth_repository.dart';
import 'package:final_project/data/repositories/home/mock_activity_repository.dart';
import 'package:final_project/domain/home/activity.dart';
import 'package:final_project/ui/home/bloc/create_activity/create_activity_bloc.dart';
import 'package:final_project/ui/home/bloc/navbar/home_page_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  late MockActivityRepository mockActivityRepository;
  late MockAuthRepository mockAuthRepository;
  late CreateActivityBloc createActivityBloc;

  setUp(() {
    mockActivityRepository = MockActivityRepository();
    mockAuthRepository = MockAuthRepository();
    createActivityBloc = CreateActivityBloc(
      activityRepository: mockActivityRepository,
    );
  });

  tearDown(() {
    createActivityBloc.close();
  });

  group('Create Activity Bloc', ()
  {
    test('initial state should be correct', () {
      expect(createActivityBloc.state, isA<CreateActivityState>());
    });

    test('ChangeFormInputEvent should update the state correctly', () async{

      final changeFormInputEvent = ChangeFormInputEvent(
        title: "New Title",
        category: "Work",
        startTime: DateTime(2025, 1, 20, 10, 0),
        endTime: DateTime(2025, 1, 20, 11, 0),
      );


      createActivityBloc.add(changeFormInputEvent);

      await Future.delayed(Duration(milliseconds: 100));


      expect(createActivityBloc.state.title, "New Title");
      expect(createActivityBloc.state.category, "Work");
      expect(createActivityBloc.state.startTime, DateTime(2025, 1, 20, 10, 0));
      expect(createActivityBloc.state.endTime, DateTime(2025, 1, 20, 11, 0));
    });




  });


}
