
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
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

  void complete(Todo todo){
    final list = state.todos;
    final index = list.indexOf(todo);
    todo.isCompleted = !todo.isCompleted;
    list.replaceRange(index, index + 1, [todo]);
    emit(HomeFetchSuccess(todos: [...list]));
  }
}