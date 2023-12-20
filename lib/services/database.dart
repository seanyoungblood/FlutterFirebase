import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee/models/drink.dart';
import 'package:coffee/models/myuser.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {

  final CollectionReference coffeeCollection = FirebaseFirestore.instance.collection('drinks');

  final String? uid;
  DatabaseService({this.uid});

  Future updateUserData(String sugars, String name, int strength) async {
    return await coffeeCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength
    });
  }

  List<Drink> _drinkListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Drink(
        name: doc.get('name') ?? '',
        strength: doc.get('strength') ?? 0,
        sugars: doc.get('sugars') ?? '0'
      );
    }).toList();
  }

  Stream<List<Drink>> get drinks {
    return coffeeCollection.snapshots().map(_drinkListFromSnapshot);
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.get('name'),
      sugars: snapshot.get('sugars'),
      strength: snapshot.get('strength')
    );
  }

  Stream<UserData> get userData {
    return coffeeCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

}