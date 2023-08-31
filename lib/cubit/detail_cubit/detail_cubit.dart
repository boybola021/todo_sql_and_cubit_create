
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import '../../main.dart';
import '../../models/todo_model.dart';
part 'detail_state.dart';
class DetailCubit extends Cubit<DetailState>{
  DetailCubit() : super(DetailInitial());


   @override
  void onChange(Change<DetailState> change) {
     debugPrint(" ==> $change");
    super.onChange(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    debugPrint(" error '"
        "==> $error,stackTrace: $stackTrace");
    super.onError(error, stackTrace);
  }

  void create(String title,String description)async{
    if(title.isEmpty || description.isEmpty){
      emit(const DetailFailure(message: "Please fill in all the fields"));
      return;
    }
    emit(DetailLoading());
    try{
      final todo = Todo(id: 1, title: title, description: description, isCompleted: false);
      await sql.insert(todo);
      emit(DetailCreateSuccess(message: "Todo created success full"));
    }catch(e){
      debugPrint("Error: $e");
      emit(DetailFailure(message: "Detail Error: $e"));
    }
  }

  void delate(int id)async{
    emit(DetailLoading());
    try{
      await sql.delete(id);
      emit(DetailDeleteSuccess(message: "Todo delate success full"));
    }catch(e){
      debugPrint("Error: $e");
      emit(DetailFailure(message: "Detail Error: $e"));
    }
  }

  void complete(Todo todo)async {
    emit(DetailLoading());
    try {
      todo.isCompleted = !todo.isCompleted;
      sql.update(todo);
      emit(DetailUpdateSuccess(message: "Todo update"));
    } catch (e) {
      emit(DetailFailure(message: "Detail ERROR: $e"));
    }
  }

  void edit(Todo todo ,String title,String description)async{
    if(title.isEmpty || description.isEmpty){
      emit(const DetailFailure(message: "Please fill in all the fields"));
      return;
    }
    emit(DetailLoading());
    try{
      todo.title = title;
      todo.description = description;
      await sql.update(todo);
      emit(DetailCreateSuccess(message: "Todo update success full"));
    }catch(e){
      debugPrint("Error: $e");
      emit(DetailFailure(message: "Detail Error: $e"));
    }
  }
}