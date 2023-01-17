import 'package:flutter/material.dart';

import '../widgets/navigation_bar.dart';
import 'add_exercise_screen.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyBottomNavigationBar(selectedIndexNavBar: 1),
      body: SafeArea(
        child: Column(
          children: [
            //TODO StreamBuilder to show documents in exercises collection
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: AddExerciseScreen(),
                      ),
                    );
                  },
                );
              },
              child: Text('Add Exercise'),
            ),
          ],
        ),
      ),
    );
  }
}
