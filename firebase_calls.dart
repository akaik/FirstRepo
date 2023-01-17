import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/fitness_user.dart';
import '../models/exercise.dart';

late FitnessUser fitnessUser;

FirebaseAuth auth = FirebaseAuth.instance;
CollectionReference fitnessUsersCollection =
    FirebaseFirestore.instance.collection('fitnessUsers');
CollectionReference exercisesCollection =
    FirebaseFirestore.instance.collection('exercises');

class FirebaseCalls {
  Future<FitnessUser> getFitnessUser(String uid) async {
    QuerySnapshot querySnap =
        await fitnessUsersCollection.where('userid', isEqualTo: uid).get();

    if (querySnap.docs.isNotEmpty) {
      QueryDocumentSnapshot doc = querySnap.docs[0];

      fitnessUser = FitnessUser(
        age: doc.get('age'),
        weight: doc.get('weight'),
        height: doc.get('height'), //TODO add gender, activityLevel, goal
      );
    }
    return fitnessUser;
  }

  Future<void> updateFitnessUser(FitnessUser fitnessUser) async {
    //check if there is an existing record of user
    QuerySnapshot querySnap = await fitnessUsersCollection
        .where('userid', isEqualTo: auth.currentUser?.uid)
        .get();

    if (querySnap.docs.isNotEmpty) {
      //Existing user
      QueryDocumentSnapshot doc = querySnap.docs[0];
      await doc.reference.update({
        'age': fitnessUser.age,
        'weight': fitnessUser.weight,
        'height': fitnessUser.height, //TODO add gender, activityLevel, goal
      });
    } else {
      //New user
      await fitnessUsersCollection.add({
        'age': fitnessUser.age,
        'weight': fitnessUser.weight,
        'height': fitnessUser.height, //TODO add gender, activityLevel, goal
        'userid': auth.currentUser?.uid
      });
    }
  }

  Future<void> addExercise(Exercise newExercise) async {
    //TODO Add newExercise to exercises collection
  }
}
