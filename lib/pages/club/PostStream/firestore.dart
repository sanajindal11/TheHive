import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase {
  // current logged-in user
  User? user = FirebaseAuth.instance.currentUser;
  
  // get a collection of clubs from firebase
  final CollectionReference clubs = 
  FirebaseFirestore.instance.collection('club');

  // create a post within a specific club
  Future<void> addPost(String message, String clubName) {
    return clubs.doc(clubName).collection('Posts').add({
      'UserEmail': user!.email,
      'PostMessage': message,
      'TimeStamp': Timestamp.now(),
    });
  }

  // read posts from a specific club
  Stream<QuerySnapshot> getPostStream(String clubName) {
    final postsStream = clubs
      .doc(clubName)
      .collection('Posts')
      .orderBy('TimeStamp', descending: true)
      .snapshots();

    return postsStream;
  }
}
