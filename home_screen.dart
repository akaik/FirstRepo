import 'package:flutter/material.dart';

import '../models/bmi.dart';
import '../utilities/api_calls.dart';
import '../utilities/firebase_calls.dart';
import '../widgets/navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness'),
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut();
              Navigator.pushReplacementNamed(context, '/');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      bottomNavigationBar: MyBottomNavigationBar(selectedIndexNavBar: 0),
      body: SafeArea(
        child: Column(
          children: [
            Text('Welcome ${auth.currentUser?.displayName}'),
            FutureBuilder<Bmi>(
              future: ApiCalls().fetchBmi(fitnessUser),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListTile(
                    title: Text(
                      snapshot.data!.health,
                      //style: kCityTextStyle,
                    ),
                    subtitle: Text(
                      snapshot.data!.bmi.toString(),
                    ),
                    trailing: Text(
                      snapshot.data!.healthyBmiRange,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const Center(child: CircularProgressIndicator());
              },
            )
            //TODO widget to show bmi, health and healthyBmiRange
            //TODO widget to show daily calorie requirement of user
          ],
        ),
      ),
    );
  }
}
