import 'dart:convert';
import 'dart:math';

import 'package:goal_tracker_5000/model/goal.dart';
import 'package:goal_tracker_5000/utilities/string_actions.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool>saveGoalDetails(String name, String duration) async{

  final sharedGoal = await SharedPreferences.getInstance();
  var primaryColors = ['FFD3E2','BAF3D2', 'FEE4CB'];
  var secondaryColors = ['FF72AD','02CF51','EE7848'];
  int rand = Random().nextInt(3);
  List<Progress> progressList = [];
  var date = DateTime.now();


  for( var i = 0 ; i <= int.parse(duration); i++ ) {
    date = date.add(const Duration(days: 1));
    var progress = Progress(date,false,false);
    progressList.add(progress);
  }

  var goal = Goal(name, DateTime.now(),duration, primaryColors[rand],
      secondaryColors[rand], false, progressList);
  bool result = await sharedGoal.setString(getRandomString(5), jsonEncode(goal.toJson()));

  return result;
}
