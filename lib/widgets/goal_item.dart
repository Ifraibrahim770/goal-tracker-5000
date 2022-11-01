import 'package:flutter/material.dart';
import 'package:goal_tracker_5000/model/goal.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoalItem extends StatefulWidget {
  const GoalItem({super.key, required this.id, required this.goal});
  final Goal goal;
  final String id;

  @override
  State<GoalItem> createState() => _GoalItemState();
}

class _GoalItemState extends State<GoalItem> {
  String? name;
  String? date;
  String? primaryColor;
  String? secondaryColor;
  String? duration;
  late Goal goal;
  var inputFormat = DateFormat('MMMM dd, yyyy HH:mm');
  late double percentage;


  @override
  void initState() {
    goal = widget.goal;
    name = goal.name;
    date = inputFormat.format(goal.creationDate!);
    primaryColor = widget.goal.primaryColor;
    secondaryColor = widget.goal.secondaryColor;
    duration = widget.goal.duration;
    percentage = getPercentage(goal.progress!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Card(
        elevation: 0,
        color: Color(int.parse('0xFF${primaryColor!}')),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          child: SizedBox(
            width: 337,
            height: 171,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 27, top: 13),
                        child: Text('$date',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 13))),

                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Text('$name ($duration Days)',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold))),
                ),
                const Padding(
                    padding: EdgeInsets.only(left: 27, top: 19),
                    child: Text('Progress',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold))),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 16, top: 18),
                      child: LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width - 97,
                        animation: true,
                        lineHeight: 11.0,
                        animationDuration: 1000,
                        percent: percentage,
                        barRadius: const Radius.circular(20),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor:
                            Color(int.parse('0xFF${secondaryColor!}')),
                        backgroundColor: Colors.white,
                      )),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 7, right: 28),
                      child: Text('${(percentage * 100).toStringAsFixed(1)}%',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double getPercentage(List<dynamic> progressList) {
    int count = 0;
    for (var i = 0; i < progressList.length; i++) {
      Progress progress = Progress.fromJson(progressList[i]);
      if(progress.isDone == true){
        count++;
      }
    }
    return (count / progressList.length);
  }
}
