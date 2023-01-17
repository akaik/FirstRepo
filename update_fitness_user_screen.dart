import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/fitness_user.dart';
import '../widgets/navigation_bar.dart';
import '../utilities/firebase_calls.dart';

class UpdateFitnessUserScreen extends StatefulWidget {
  const UpdateFitnessUserScreen({Key? key}) : super(key: key);

  @override
  State<UpdateFitnessUserScreen> createState() =>
      _UpdateFitnessUserScreenState();
}

class _UpdateFitnessUserScreenState extends State<UpdateFitnessUserScreen> {
  //TODO add gender, activityLevel, goal throughout this screen

  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyBottomNavigationBar(selectedIndexNavBar: 2),
      body: SafeArea(
        child: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
            stream: fitnessUsersCollection
                .where('userid', isEqualTo: auth.currentUser?.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.docs.isNotEmpty) {
                  QueryDocumentSnapshot doc = snapshot.data!.docs[0];
                  ageController.text = doc.get('age').toString();
                  weightController.text = doc.get('weight').toString();
                  heightController.text = doc.get('height').toString();
                }
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Text(
                    'Update Fitness User',
                    textAlign: TextAlign.center,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(labelText: 'Age'),
                    controller: ageController,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(labelText: 'Weight'),
                    controller: weightController,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(labelText: 'Height'),
                    controller: heightController,
                  ),
                  ElevatedButton(
                    child: const Text('Save'),
                    onPressed: () {
                      fitnessUser = FitnessUser(
                        age: int.parse(ageController.text),
                        weight: int.parse(weightController.text),
                        height: int.parse(heightController.text),
                      );
                      FirebaseCalls().updateFitnessUser(fitnessUser);
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
