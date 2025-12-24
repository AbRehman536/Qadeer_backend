import 'package:flutter/material.dart';
import 'package:qadeer_backend/model/user.dart';
import 'package:qadeer_backend/services/auth.dart';
import 'package:qadeer_backend/services/user.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Column(children: [
        TextField(controller: nameController,),
        TextField(controller: emailController,),
        TextField(controller: passwordController,),
        TextField(controller: phoneController,),
        TextField(controller: addressController,),
        isLoading ? Center(child: CircularProgressIndicator(),)
            :ElevatedButton(onPressed: ()async{
              try{
                isLoading = true;
                setState(() {});
                await AuthService().registerUser(
                    email: emailController.text,
                    password: passwordController.text)
                    .then((value)async{
                      await UserServices().createUser(UserModel(
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                        address: addressController.text,
                          createdAt: DateTime.now().millisecondsSinceEpoch))
                          .then((val){
                        isLoading = false;
                        setState(() {});
                            showDialog(context: context, builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text("Register Successfully"),
                                actions: [
                                  TextButton(onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                                  }, child: Text("Okay"))
                                ],
                              );
                            }, );
                      });
                });
              }catch(e){
                isLoading = false;
                setState(() {});
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(e.toString())));

              }
        }, child: Text("Register"))
      ],),
    );
  }
}
