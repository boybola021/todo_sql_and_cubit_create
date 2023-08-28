
part of 'home_cubit.dart';

@immutable
abstract class HomeState{
  final List<Todo> todos;
  const HomeState({required this.todos});
}

class HomeInitial extends HomeState{
  HomeInitial() : super(todos: const []);
}

class HomeLoading extends HomeState{
  HomeLoading({required super.todos});
}

class HomeFailure extends HomeState{
  final String message;
  HomeFailure({required super.todos,required this.message,});
}

class HomeFetchSuccess extends HomeState{
  HomeFetchSuccess({required super.todos});
}