import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/priority.dart';

class PriorityService{
  ///Create Priority
  Future createPriority(PriorityModel model) async {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('PriorityCollection')
        .doc();
    return await FirebaseFirestore.instance
        .collection('PriorityCollection')
        .doc(documentReference.id)
        .set(model.toJson(documentReference.id));
  }

  ///Update Priority
  Future updatePriority(PriorityModel model) async {
    return await FirebaseFirestore.instance
        .collection('PriorityCollection')
        .doc(model.docId)
        .update({'name': model.name,});
  }

  ///Delete Priority
  Future deletePriority(String priorityID) async {
    return await FirebaseFirestore.instance
        .collection('PriorityCollection')
        .doc(priorityID)
        .delete();
  }

  ///Get All Priority
  Stream<List<PriorityModel>> getAllPriority() {
    return FirebaseFirestore.instance
        .collection('PriorityCollection')
        .snapshots()
        .map(
          (PriorityList) => PriorityList.docs
          .map((PriorityJson) => PriorityModel.fromJson(PriorityJson.data()))
          .toList(),
    );
  }
  ///Get Priority
  Future<List<PriorityModel>> getPriority() {
    return FirebaseFirestore.instance
        .collection('PriorityCollection')
        .get()
        .then(
          (PriorityList) => PriorityList.docs
          .map((PriorityJson) => PriorityModel.fromJson(PriorityJson.data()))
          .toList(),
    );
  }
}