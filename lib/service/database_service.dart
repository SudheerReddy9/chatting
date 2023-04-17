import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("Users");
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");
  Future updateUserData(String fullName, String email) async {
    return await userCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "groups": [],
      "profilePic": '',
      "uid": uid
    });
  }

  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  //get user groups
  getUserGroups() async {
    return userCollection.doc(uid).snapshots();
  }

  //Creating groups
  Future CreatGroup(String userName, String id, String groupName) async {
    DocumentReference groupdocumentReference = await groupCollection.add({
      "groupName": groupName,
      "groupIcon": '',
      "admin": '$id-$userName',
      "members": [],
      "groupId": '',
      "recentMessage": '',
      "recentMessageSender": '',
    });
    await groupdocumentReference.update({
      "members": FieldValue.arrayUnion(['$id-$userName']),
      "groupId": groupdocumentReference.id,
    });
    DocumentReference userdocumentReference = userCollection.doc(uid);
    return await userdocumentReference.update({
      "groups":
          FieldValue.arrayUnion(["${groupdocumentReference.id}_$groupName"])
    });
  }

  getChats(String groupId) {
    return groupCollection
        .doc(groupId)
        .collection("messages")
        .orderBy("time")
        .get();
  }
  Future getGroupAdmin( String groupId) async{
    DocumentReference d = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['admin'];
  }
  getGroupMembers(groupId){
    return groupCollection.doc(groupId).snapshots();
  }
}
