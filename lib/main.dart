
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_sql_and_cubit_create/cubit/detail_cubit/detail_cubit.dart';
import 'package:todo_sql_and_cubit_create/cubit/theme_mod_cubit/theme_mode.dart';
import 'package:todo_sql_and_cubit_create/services/sql_service.dart';
import 'app/app.dart';
import 'cubit/home_cubit/home_cubit.dart';
import 'package:path/path.dart';
/// service locator
final sql = SQLService();
final homeCubit = HomeCubit();
final detailCubit = DetailCubit();
final themeCubit = ThemeCubit();

void main()async{
  WidgetsFlutterBinding.ensureInitialized();

  /// Sql setting
  final databasePath = await getDatabasesPath();
  final path = join(databasePath, "TodoApp");
  await sql.open(path);

  /// Localization


  await EasyLocalization.ensureInitialized();
   runApp(
     EasyLocalization(
     supportedLocales: const [
       Locale('en', 'US'),
       Locale('uz', 'UZ'),
       Locale('ru', 'RU'),
     ],
     path: "assets/translate",
       fallbackLocale: const Locale("en","US"),
       child: App(),
     ),
   );
}