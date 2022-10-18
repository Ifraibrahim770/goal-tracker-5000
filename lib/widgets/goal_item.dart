import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class GoalItem extends StatefulWidget {
  const GoalItem({Key? key}) : super(key: key);

  @override
  State<GoalItem> createState() => _GoalItemState();
}

class _GoalItemState extends State<GoalItem> {
  @override
  Widget build(BuildContext context) {
    return Padding (
      padding: const EdgeInsets.only(bottom: 15),
      child: Card(
        elevation: 0,
        color: const Color(0xFFFFD3E2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            debugPrint('Card tapped.');
          },
          child: SizedBox(
            width: 337,
            height: 171,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                    padding: EdgeInsets.only(left: 27, top: 13),
                    child: Text('October 12th, 2020',
                        style: TextStyle(color: Colors.black, fontSize: 13))),
                Container(
                  alignment: Alignment.center,
                  child: const Padding(
                      padding: EdgeInsets.only(top: 25),
                      child: Text('Eat Balanced Diet (60 Days)',
                          style: TextStyle(
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
                        animationDuration: 2500,
                        percent: 0.8,
                        barRadius: const Radius.circular(20),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: const Color(0xFFFF72AD),
                        backgroundColor: Colors.white,
                      )),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: const Padding(
                      padding: EdgeInsets.only(top: 7, right: 28),
                      child: Text('70%',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
