
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/task.dart';
import '../services/task.dart';

class GetFavoriteTask extends StatelessWidget {
  const GetFavoriteTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get Favorite Task"),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: StreamProvider.value(
        value: TaskServices().getMyFavorite("1"),
        initialData: [TaskModel()],
        builder: (context, child){
          List<TaskModel> taskList = context.watch<List<TaskModel>>();
          return ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.favorite),
                title: Text(taskList[index].name.toString()),
                subtitle: Text(taskList[index].description.toString()),
              );
            },);
        },
      ),

    );
  }
}