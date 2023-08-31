import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_sql_and_cubit_create/main.dart';
import 'package:todo_sql_and_cubit_create/pages/detail_page.dart';
import '../cubit/detail_cubit/detail_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  void initState() {
    homeCubit.fetchTodos();
    super.initState();

    detailCubit.stream.listen((state) {
      /// agar todoo create bulsa yoki delate bulsa homeCubit.fetchTodos(); boshqatdan  build qiladi
      if(state is DetailDeleteSuccess || detailCubit.state is DetailCreateSuccess){
        homeCubit.fetchTodos();
      }
      if(state is DetailUpdateSuccess){
        homeCubit.fetchTodos();
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("todos",style: Theme.of(context).textTheme.titleLarge,).tr(),
        actions: [
          IconButton(
              onPressed: ()=> themeCubit.changeMode(),
              icon: Icon(themeCubit.state == ThemeMode.light? Icons.dark_mode_outlined : Icons.light_mode)
          ),
          PopupMenuButton<Locale>(
            onSelected: context.setLocale,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            itemBuilder: (context) {
              return const [
                PopupMenuItem(value: Locale('uz', 'UZ'), child: Text("🇺🇿 UZ"),),
                PopupMenuItem(value: Locale('ru', 'RU'), child: Text("🇷🇺 RU")),
                PopupMenuItem(value: Locale('en', 'US'), child: Text("🇺🇸 EN")),
              ];
            },
            icon: const Icon(Icons.language_rounded),
          ),
            const  SizedBox(width: 10,)
        ],
      ),
      body: StreamBuilder(
        initialData: homeCubit.state,
        stream: homeCubit.stream,
        builder: (context,snapshot) {
          final items = snapshot.data!.todos;
          return Stack(
            children: [
              ListView.builder(
                padding: EdgeInsets.all(20),
                itemCount: items.length,
                itemBuilder: (context,i){
                  final item = items[i];
                  return Card(
                    child: ListTile(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPage(todo: item,)));
                        },
                      leading: IconButton(
                        onPressed: () => detailCubit.complete(item),
                        icon: Icon(item.isCompleted? Icons.check_box : Icons.check_box_outline_blank),
                      ),
                      title: Text(item.title),
                      subtitle: Text(item.description),
                      trailing:  IconButton(
                        onPressed: () => detailCubit.delate(item.id),
                        icon: Icon(Icons.delete),
                      ),
                    ),
                  );
                },
              )
            ],
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushNamed("/detail");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
