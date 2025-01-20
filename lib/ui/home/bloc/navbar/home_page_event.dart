
part of 'home_page_bloc.dart';

abstract class HomePageEvent{

}

class ChangeIndexEvent extends HomePageEvent{
  final int index;
  ChangeIndexEvent({required this.index});
}

class Logout extends HomePageEvent{

}

