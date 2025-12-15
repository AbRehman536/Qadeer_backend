
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/task.dart';
import '../services/task.dart';

class GetInCompletedTask extends StatelessWidget {
  const GetInCompletedTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("InCompleted Task"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: StreamProvider.value(
        value: TaskServices().getInCompletedTask(),
        initialData: [TaskModel()],
        builder: (context, child){
          List<TaskModel> taskList = context.watch<List<TaskModel>>();
          return ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.task),
                title: Text(taskList[index].name.toString()),
                subtitle: Text(taskList[index].description.toString()),
              );
            },);
        },
      ),

    );
  }
}