import 'package:flutter/material.dart';
import 'package:qadeer_backend/model/priority.dart';
import 'package:qadeer_backend/services/priority.dart';

class CreatePriority extends StatefulWidget {
  final PriorityModel model;
  final bool isUpdateMode;
  const CreatePriority({super.key, required this.model, required this.isUpdateMode});

  @override
  State<CreatePriority> createState() => _CreatePriorityState();
}

class _CreatePriorityState extends State<CreatePriority> {
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;
  @override
  void initState(){
    nameController = TextEditingController(
      text: widget.model.name.toString()
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isUpdateMode ? "Update Task" : "Create Task"),
        backgroundColor: widget.isUpdateMode ? Colors.blue : Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Column(children: [
        TextField(controller: nameController,),
        isLoading ? Center(child:  CircularProgressIndicator(),)
            :ElevatedButton(onPressed: ()async{
              try{
                isLoading = true;
                setState(() {});
                if(widget.isUpdateMode == true){
                  await PriorityService().updatePriority(PriorityModel(
                    docId: widget.model.docId.toString(),
                      name: nameController.text.toString(),
                    createdAt: DateTime.now().millisecondsSinceEpoch
                  )).then((value){

                    isLoading = false;
                    setState(() {});
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Thank You"),
                          content: Text("Update Successfully"),
                          actions: [
                            TextButton(onPressed: (){}, child: Text("Okay"))
                          ],
                        );
                      },);
                  });
                }else{
                  await PriorityService().createPriority(PriorityModel(
                      name: nameController.text.toString(),
                      createdAt: DateTime.now().millisecondsSinceEpoch
                  )).then((value){
                    isLoading = false;
                    setState(() {});
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Thank You"),
                          content: Text("Create Successfully"),
                          actions: [
                            TextButton(onPressed: (){}, child: Text("Okay"))
                          ],
                        );
                      },);
                  });
                }
              }catch(e){
                isLoading = false;
                setState(() {});
                ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.toString())));
              }
        },
            child: Text(widget.isUpdateMode == true ? "Update Task" : "Create Task"))
      ],),
    );
  }
}
