
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_sql_and_cubit_create/cubit/detail_cubit/detail_cubit.dart';
import '../../main.dart';
import '../../models/todo_model.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void fetchTodos() async {
    emit(HomeLoading(todos: state.todos));
    try {
      final todos = await sql.todos();
      emit(HomeFetchSuccess(todos: todos));
    } catch(e) {
      emit(HomeFailure(todos: state.todos, message: "HOME ERROR: $e"));
    }
  }

}