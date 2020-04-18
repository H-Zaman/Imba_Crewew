import 'package:brewcrew/models/brew.dart';
import 'package:brewcrew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;

  DatabaseService({this.uid});

  //collection reference to read/write
  final CollectionReference brewCollection = Firestore.instance.collection('brews');

  Future updateUserData(String sugar,String name,int strength ) async{
    return await brewCollection.document(uid).setData({
      'sugar' : sugar,
      'name' : name,
      'strength' : strength,
    });
  }

  //brew list from document>
  List<Brew> _brewListFromDocuments(QuerySnapshot snapshot){
    return snapshot.documents.map((doc) {
      return Brew(
          name : doc.data['name'] ?? 'null',
          //TODO: sugar or sugars
          sugar : doc.data['sugar'] ?? 'null',
          strength : doc.data['strength'] ?? 100,
      );
    }).toList();
  }

  //User data from Snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugar'],
      strength: snapshot.data['strength'],
    );
  }

  //stream to notify database changes
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots()
        .map(_brewListFromDocuments);
  }
  //get user doc stream
  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots()
    .map(_userDataFromSnapshot);
  }
}