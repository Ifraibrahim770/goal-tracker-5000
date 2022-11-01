import 'package:flutter/cupertino.dart';

class CheckIn extends StatefulWidget {
  const CheckIn({Key? key}) : super(key: key);

  @override
  State<CheckIn> createState() => _CheckInState();
}

class _CheckInState extends State<CheckIn> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: const Text('Check-in '),
    );
  }
}



class CheckedIn extends StatefulWidget {
  const CheckedIn({Key? key}) : super(key: key);

  @override
  State<CheckedIn> createState() => _CheckedInState();
}

class _CheckedInState extends State<CheckedIn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text('Already Checked In'),
    );
  }
}

