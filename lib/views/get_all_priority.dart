import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qadeer_backend/model/priority.dart';
import 'package:qadeer_backend/services/priority.dart';
import 'package:qadeer_backend/views/create_priority.dart';
import 'package:qadeer_backend/views/get_completed_task.dart';
import 'package:qadeer_backend/views/get_inCompleted_task.dart';
import 'package:qadeer_backend/views/get_priority_task.dart';
import 'package:qadeer_backend/views/update_task.dart';

import '../model/task.dart';
import '../services/task.dart';
import 'create_task.dart';

class GetAllPriorityTask extends StatelessWidget {
  const GetAllPriorityTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Get All Priority Task"),

        ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> CreatePriority(model: PriorityModel(), isUpdateMode: false)));
        },child: Icon(Icons.add),),
        body: StreamProvider.value(
          value: PriorityService().getAllPriority(),
          initialData: [PriorityModel()],
          builder: (context, child){
            List<PriorityModel> priorityList = context.watch<List<PriorityModel>>();
            return ListView.builder(
              itemCount: priorityList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    leading: Icon(Icons.task),
                    title: Text(priorityList[index].name.toString()),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> CreatePriority(model: PriorityModel(), isUpdateMode: true)));
                        }, icon: Icon(Icons.edit)),
                        IconButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> GetPriorityTask(model: PriorityModel())));
                        }, icon: Icon(Icons.arrow_forward)),

                      ],
                    )
                );
              },);
          },
        )
    );
  }
}
