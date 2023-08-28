

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class ThemeCubit extends Cubit<ThemeMode>{
  ThemeCubit():super(ThemeMode.light);

  void changeMode(){
    if(state == ThemeMode.light) {
      return emit(ThemeMode.dark);
    } else {
      emit(ThemeMode.light);
    }
  }
}

