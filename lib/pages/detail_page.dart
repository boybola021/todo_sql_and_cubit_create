import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_sql_and_cubit_create/main.dart';
import 'package:todo_sql_and_cubit_create/models/todo_model.dart';
import '../cubit/detail_cubit/detail_cubit.dart';

class DetailPage extends StatelessWidget {
  final Todo? todo;

  DetailPage({Key? key, this.todo}) : super(key: key);
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  void initStat() {
    titleCtrl.text = todo?.title ?? "";
    descCtrl.text = todo?.description ?? "";
  }

  @override
  Widget build(BuildContext context) {
    initStat();

    detailCubit.stream.listen((state) {
      if (detailCubit.state is DetailFailure) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text((detailCubit.state as DetailFailure).message)));
      }
      if ((detailCubit.state is DetailCreateSuccess ||
              detailCubit.state is DetailUpdateSuccess) &&
          context.mounted) {
        Navigator.of(context).pop();
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "detail",
          style: Theme.of(context).textTheme.titleLarge,
        ).tr(),
        actions: [
          IconButton(
            onPressed: () {
              if (todo == null) {
                detailCubit.create(titleCtrl.text, descCtrl.text);
              } else {
                detailCubit.edit(todo!, titleCtrl.text, descCtrl.text);
              }
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: titleCtrl,
                  decoration: InputDecoration(
                    hintText: "title".tr(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: descCtrl,
                  decoration: InputDecoration(
                    hintText: "description".tr(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          StreamBuilder(
            initialData: detailCubit.state,
            stream: detailCubit.stream,
            builder: (context, snapshot) {
              if (detailCubit.state is DetailLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
