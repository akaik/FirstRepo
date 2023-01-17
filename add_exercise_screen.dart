import 'package:flutter/material.dart';

import '../models/exercise_type.dart';

class AddExerciseScreen extends StatefulWidget {
  const AddExerciseScreen({Key? key}) : super(key: key);

  @override
  State<AddExerciseScreen> createState() => _AddExerciseScreenState();
}

class _AddExerciseScreenState extends State<AddExerciseScreen> {
  final TextEditingController durationController = TextEditingController();

  //TODO Shortlist your exercises
  final List<ExerciseType> _exercises = <ExerciseType>[
    ExerciseType(id: 'ru_5', description: 'Running, 4 mph (13 min/mile)'),
    ExerciseType(id: 'ru_6', description: 'Running, 5 mph (12 min/mile)'),
    ExerciseType(id: 'ru_7', description: 'Running, 5.2 mph (11.5 min/mile)'),
    ExerciseType(id: 'ru_8', description: 'Running, 6 mph (10 min/mile)'),
  ];

  ExerciseType? _selectedExercise;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton<ExerciseType>(
          value: _selectedExercise,
          items: _exercises
              .map(
                (desc) => DropdownMenuItem(
                  value: desc,
                  child: Text(desc.description),
                ),
              )
              .toList(),
          onChanged: (value) {
            setState(() {
              _selectedExercise = value!;
            });
          },
        ),
        TextField(
          textAlign: TextAlign.center,
          decoration: const InputDecoration(labelText: 'Duration'),
          controller: durationController,
        ),
        ElevatedButton(
          child: const Text("ADD"),
          onPressed: () {
            //TODO ApiCalls().fetchBurnedCalories()
            //TODO FirebaseCalls().addExercise()
          },
        ),
      ],
    );
  }
}
