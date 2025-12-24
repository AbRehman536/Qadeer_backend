import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qadeer_backend/model/user.dart';

class UserServices{
  String userCollection = "UserCollection";
  ///create User
  Future createUser(UserModel model)async{
    return await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(model.docId)
        .set(model.toJson(model.docId!));
  }

  //get user by ID
  Future<UserModel> getUserByID(String userID)async{
    return await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(userID)
        .get()
        .then((userJson)=> UserModel.fromJson(userJson.data()!));
  }
  ///Update User
  Future updateUser(UserModel model) async {
    return await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(model.docId)
        .update({'name': model.name,
      'phone': model.phone, "address": model.address});
  }

  ///Delete User
  Future deleteUser(String userID) async {
    return await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(userID)
        .delete();
  }
}