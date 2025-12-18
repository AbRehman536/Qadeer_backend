import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qadeer_backend/model/priority.dart';
import 'package:qadeer_backend/model/task.dart';
import 'package:qadeer_backend/services/task.dart';

class GetPriorityTask extends StatelessWidget {
  final PriorityModel model;
  const GetPriorityTask({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${model.name} Priority Task"),
      ),
      body: StreamProvider.value(
          value: TaskServices().getTaskByPriorityID(model.docId.toString()),
          initialData: [TaskModel()],
        builder: (context, child){
            List<TaskModel> taskList = context.watch<List<TaskModel>>();
            return ListView.builder(itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.task_alt),
                title: Text(taskList[index].name.toString()),
                subtitle: Text(taskList[index].description.toString()),
                trailing: Icon(Icons.add),
              );
            },);
        },
      ),
    );
  }
}
