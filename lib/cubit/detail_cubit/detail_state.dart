
part of 'detail_cubit.dart';


@immutable
abstract class DetailState{
  const DetailState();
}

class DetailInitial extends DetailState{}

class DetailFailure extends DetailState{
  final String message;
  const DetailFailure({required this.message});
}
class DetailLoading extends DetailState{}

class DetailCreateSuccess extends DetailState {
  final String message;
  const DetailCreateSuccess({required this.message});
}
class DetailReadSuccess extends DetailState {}

class DetailUpdateSuccess extends DetailState {
  final String message;
  const DetailUpdateSuccess({required this.message});
}
class DetailDeleteSuccess extends DetailState {
  final String message;
  const DetailDeleteSuccess({required this.message});
}