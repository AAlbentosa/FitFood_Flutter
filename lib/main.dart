import 'dart:math';
import 'package:flutter/material.dart';

import './models/Food.dart';
import './widgets/activities_list.dart';
import './widgets/new_activity.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Activity> _activities =[];

  final randomGen = Random();

  void _addNewActivity(String name, int kcal, DateTime date) {
    final newAct = Activity(
      id: randomGen.nextInt(10000),
      name: name,
      kcal: kcal,
      date: date,
    );

    setState(() {
      _activities.add(newAct);
    });
  }

  void _startNewActivity(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewActivity(_addNewActivity);
      },
    );
  }

  void _deleteActivity(Activity activity){

    setState(() {

      _activities.remove(activity);

    });

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Main(
        activities: _activities,
        addNewActivity: _addNewActivity,
        startNewActivity: _startNewActivity,
        deleteActivity: _deleteActivity,
      ),
    );
  }
}



class Main extends StatelessWidget {
  final Function(BuildContext) startNewActivity;
  final Function(String, int, DateTime) addNewActivity;
  final List<Activity> activities;
  final Function(Activity) deleteActivity;

  Main({
    required this.startNewActivity,
    required this.addNewActivity,
    required this.activities,
    required this.deleteActivity
  });


  @override
  Widget build(BuildContext context) {
    activities.sort((a, b)=> b.date.compareTo(a.date));
    return Scaffold(
      appBar: AppBar(
        title: Text("Activity App"),
      ),
      body: ListView(
        children: [
          // NewActivity(addNewActivity),
          if(activities.length>0)...[
            ActivitiesList(activities, deleteActivity)
          ]else...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 100),
                  child: Text("Actualmente no tienes ningun registro",
                      style: TextStyle(
                          fontSize: 20)
                  ),
                ),
              ],
            ),
        ]
        ]),// crossAxisAlignment: CrossAxisAlignment.start,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          startNewActivity(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
