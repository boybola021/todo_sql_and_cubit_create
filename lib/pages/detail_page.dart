import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_sql_and_cubit_create/main.dart';
import 'package:todo_sql_and_cubit_create/models/todo_model.dart';
import '../cubit/detail_cubit/detail_cubit.dart';

class DetailPage extends StatefulWidget {
 final Todo? todo;
  DetailPage({Key? key,this.todo}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();
   bool result = false;
  @override
  void initState() {
    super.initState();
    if (widget.todo?.title != null || widget.todo?.description != null) {
      titleCtrl.text = widget.todo!.title;
      descCtrl.text = widget.todo!.description;
      result = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    detailCubit.stream.listen((state) {
      if (detailCubit.state is DetailFailure) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text((detailCubit.state as DetailFailure).message)));
      }
      if (detailCubit.state is DetailCreateSuccess && context.mounted) {
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
              if(result){
                detailCubit.delate(widget.todo!.id);
                detailCubit.edit(
                    Todo(
                    id: widget.todo!.id,
                    title: titleCtrl.text,
                    description: descCtrl.text,
                    isCompleted: false),
                );
              }
                detailCubit.create(titleCtrl.text, descCtrl.text);
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
