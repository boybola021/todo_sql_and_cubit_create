

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_sql_and_cubit_create/main.dart';
import 'package:todo_sql_and_cubit_create/pages/detail_page.dart';
import 'package:todo_sql_and_cubit_create/pages/home_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: themeCubit.state,
      stream: themeCubit.stream,
      builder: (context,mode) {
        return MaterialApp(
          themeMode: mode.data,
          theme: ThemeData.light(useMaterial3: true),
          darkTheme: ThemeData.dark(useMaterial3: true),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          initialRoute: "/",
          routes: {
            "/" : (context) => HomePage(),
            "/detail": (context) => DetailPage(),
          },
        );
      }
    );
  }
}
