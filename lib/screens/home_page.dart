import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:goal_tracker_5000/model/goal.dart';
import 'package:goal_tracker_5000/utilities/goal_actions.dart';
import 'package:goal_tracker_5000/widgets/goal_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:goal_tracker_5000/widgets/menus.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final goalNameController = TextEditingController();
  final goalDurationController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  Map<String, dynamic> goals = {};
  Offset _tapPosition = Offset.zero;
  void _getTapPosition(TapDownDetails details) {
    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    setState(() {
      _tapPosition = referenceBox.globalToLocal(details.globalPosition);
    });
  }

  //Context Menu


  @override
  void initState() {
    getGoals().then((value){
      setState(() {
        goals = value;
      });
    });
    super.initState();
  }


  Future<void> _showGoalDetailDialog() async {
    goalNameController.clear();
    goalDurationController.clear();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Goal'),
          content: SingleChildScrollView(
            child: Form(
              key: _key,
              child: ListBody(
                children: <Widget>[
                  TextFormField(
                    validator: validateName,
                    controller: goalNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Goal Name',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: validateDuration,
                    controller: goalDurationController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Duration e.g 60 (in days)',
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Save'),
              onPressed: ()  {
                //Navigator.of(context).pop();
                if (_key.currentState!.validate()) {
                  var result =  saveGoalDetails(goalNameController.text, goalDurationController.text);
                  Navigator.of(context).pop();
                  getGoals().then((value){
                    setState(() {
                      goals = value;
                    });
                  });
                }
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(widget.title),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 18),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
        ),
        backgroundColor: Colors.white70,
      ),

      body: Padding(
          padding: const EdgeInsets.only(left: 26, right: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Figma: TOP SPOT GROUP
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Hello, Ibrahim!',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 13,
                  ),
                  Text(
                    'Have a Nice Day!',
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),

              const SizedBox(
                height: 35,
              ),
              //FIGMA: NAVIGATION BUTTON GROUP
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                      height: 32, //height of button
                      width: 96, //width of button
                      child: ElevatedButton(
                        onPressed: () {
                          if (kDebugMode) {
                            print('Active Button Pressed');
                          }
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEBF3FF),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Active',
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                        //parameters of Button class
                      )),
                  SizedBox(
                      height: 32, //height of button
                      width: 96, //width of button
                      child: ElevatedButton(
                        onPressed: () {
                          if (kDebugMode) {
                            print('Complete Button Pressed');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEBF3FF),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Complete',
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                        //parameters of Button class
                      )),
                  SizedBox(
                      height: 32, //height of button
                      width: 96, //width of button
                      child: ElevatedButton(
                        onPressed: () {
                          if (kDebugMode) {
                            print('Draft Button Pressed');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEBF3FF),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Draft',
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),

                        //parameters of Button class
                      ))
                ],
              ),
              const SizedBox(
                height: 13,
              ),

              const Text('Goals',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),

              const SizedBox(
                height: 21,
              ),

              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: goals.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      String key = goals.keys.elementAt(index);
                      return GestureDetector(

                        onTapDown: (details) => _getTapPosition(details),
                        onLongPress: () {
                          showContextMenu(ctx,key);
                        },
                        child: GoalItem(key: ObjectKey(key), id: key, goal: goals[key],),
                      );
                    }),
              ),
            ],
          )),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFEBF3FF),
        onPressed: _showGoalDetailDialog,
        tooltip: 'Increment',
        child: const Icon(Icons.add, color: Colors.black),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Goal Name is required';
    }
    return null;
  }

  String? validateDuration(String? value) {
    if (value == null || value.isEmpty) {
      return 'Goal Duration is required';
    }
    return null;
  }

  Future<Map<String, Goal>> getGoals() async {
    final sharedGoal = await SharedPreferences.getInstance();
    final keys = sharedGoal.getKeys();
    final prefsMap = <String, Goal>{};
    for(String key in keys) {
      String? goalJsonString = sharedGoal.getString(key);
      Map<String,dynamic> goalMap = jsonDecode(goalJsonString!);
      Goal goal = Goal.fromJson(goalMap);
      prefsMap[key] = goal;
    }
    return prefsMap;
  }


  //Context Menu
  showContextMenu(BuildContext context, String id) async {
    final RenderObject? overlay =
    Overlay.of(context)?.context.findRenderObject();

    final result = await showMenu(
        context: context,

        // Show the context menu at the tap location
        position: RelativeRect.fromRect(
            Rect.fromLTWH(_tapPosition.dx, _tapPosition.dy, 30, 30),
            Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width,
                overlay.paintBounds.size.height)),

        // set a list of choices for the context menu
        items: [
          const PopupMenuItem(
            value: 'delete',
            child: Text('Delete'),
          ),
        ]);

    // Implement the logic for each choice here
    switch (result) {
      case 'delete':
        var sharedGoal = await SharedPreferences.getInstance();
        bool deleted =await sharedGoal.remove(id);
        goals.removeWhere((key, value) => key == id);
        setState(() {
        });
        break;
    }
  }
}
