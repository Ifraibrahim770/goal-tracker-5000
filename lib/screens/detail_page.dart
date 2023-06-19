import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/goal.dart';

class DetailBody extends StatefulWidget {
  const DetailBody({super.key, required this.id, required this.goal});
  final Goal goal;
  final String id;

  @override
  State<DetailBody> createState() => _DetailBodyState();
}

class _DetailBodyState extends State<DetailBody> {
  String? name;
  String? date;
  String? primaryColor;
  String? secondaryColor;
  String? duration;
  String? daysRemaining;
  late Goal goal;
  var inputFormat = DateFormat('dd MMMM, yyyy');
  late double percentage;
  bool? checked = true;
  String? goalId;
  String? nextCheckDate;
  String? nextUpdatedDate;

  @override
  void initState() {
    goal = widget.goal;
    getPageInfo(goal);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.black, //change your color here
            ),
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 18),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context,true);
                },
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
            ),
            backgroundColor: Colors.white70,
          ),
          body: LayoutBuilder(builder: (context, constraint) {
            return Padding(
              padding: const EdgeInsets.only(left: 26, right: 26),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('$name ($duration Days)',
                                style: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 13,
                            ),
                            Text(
                              '$daysRemaining',
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: CircularPercentIndicator(
                            animation: true,
                            animationDuration: 1000,
                            radius: 100.0,
                            lineWidth: 17.0,
                            percent: percentage,
                            center: Text(
                              "${(percentage * 100).toStringAsFixed(1)}%",
                              style: const TextStyle(fontSize: 40),
                            ),
                            progressColor:
                                Color(int.parse('0xFF${secondaryColor!}')),
                            backgroundColor:
                                Color(int.parse('0xFF${primaryColor!}')),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        const Spacer(),
                        const Text(
                          'Check-in',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        checked == false
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'Have you done this activity for today?',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 58,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            backgroundColor: Color(int.parse(
                                                '0xFF${secondaryColor!}')),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      20), // <-- Radius
                                            )),
                                        child: const Text(
                                          'Yes!',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        onPressed: () async {
                                          updateGoal(widget.goal);
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 58,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          side: BorderSide(
                                              width: 1.5,
                                              color: Color(int.parse(
                                                  '0xFF${secondaryColor!}'))),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          backgroundColor:
                                              const Color(0xFFFFFFFF),
                                        ),
                                        child: Text(
                                          'No, not really',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Color(int.parse(
                                                  '0xFF${secondaryColor!}'))),
                                        ),
                                        onPressed: () async {},
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'Have you done this activity for today?',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Icon(Icons.done_all,
                                        size: 80,
                                        color: Color(int.parse(
                                            '0xFF${secondaryColor!}'))),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: const Text('Yes!',
                                        style: TextStyle(fontSize: 30)),
                                  ),
                                ],
                              ),
                        const SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 75),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Next Check-in: $nextUpdatedDate',
                              style: const TextStyle(fontSize: 17),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          })

          // This trailing comma makes auto-formatting nicer for build methods.
          ),
    );
  }

  void getPageInfo(Goal goal) {
    int count = 0;
    String? nextDateUpdated;
    bool isChecked = true;
    List<dynamic> progressList = goal.progress;
    var remainingDays =
        goal.endingDate?.difference(DateTime.now()).inDays.toString();

    for (var i = 0; i < progressList.length; i++) {
      Progress progress = Progress.fromJson(progressList[i]);
      if (progress.isDone == true) {
        count++;
      }
      if (progress.dateCreated == DateUtils.dateOnly(DateTime.now())) {
        nextDateUpdated = inputFormat
            .format(Progress.fromJson(progressList[i + 1]).dateCreated!);

        if (Progress.fromJson(progressList[i]).isDone == false &&
            Progress.fromJson(progressList[i]).isManualUpdate == false) {
          isChecked = false;
        }
      }
    }
    setState(() {
      name = goal.name;
      date = inputFormat.format(goal.creationDate!);
      percentage = (count / progressList.length);
      checked = isChecked;
      daysRemaining = '$remainingDays Days Remaining';
      primaryColor = goal.primaryColor;
      secondaryColor = goal.secondaryColor;
      duration = goal.duration;
      nextUpdatedDate = nextDateUpdated;
    });
  }

  Future<void> updateGoal(Goal goal) async {
    final sharedGoal = await SharedPreferences.getInstance();
    var currentDate = DateUtils.dateOnly(DateTime.now());
    var index = goal.progress.indexWhere(
        (progress) => Progress.fromJson(progress).dateCreated == currentDate);
    if (index != -1) {
      Progress progress = Progress(currentDate, true, true);
      goal.progress[index] = progress.toJson();
      bool result =
          await sharedGoal.setString(widget.id, jsonEncode(goal.toJson()));
      if (result == true) {
        getPageInfo(goal);
      }
    }
  }
}
