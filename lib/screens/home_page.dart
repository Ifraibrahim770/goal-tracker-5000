import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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


        body: Padding(padding: const EdgeInsets.only(left: 26, right: 26),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children:  <Widget>[
              // Figma: TOP SPOT GROUP
             Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Hello, Ibrahim!',style: TextStyle(fontSize: 30, fontWeight:FontWeight.bold )),
                  SizedBox(height: 13,),
                  Text('Have a Nice Day!', style: TextStyle(fontSize: 20),)

                ],

              ),

             const SizedBox(height: 35,),
              //FIGMA: NAVIGATION BUTTON GROUP
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  <Widget> [
                SizedBox(
                    height:32, //height of button
                    width:96, //width of button
                    child:ElevatedButton(onPressed: () {
                      if (kDebugMode) {
                        print('Active Button Pressed');
                      }

                    },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEBF3FF),
                        elevation: 0,
                      ), child: const Text('Active', style: TextStyle(color: Colors.black,fontSize: 13),),
                      //parameters of Button class
                    )
                ),

                  SizedBox(
                      height:32, //height of button
                      width:96, //width of button
                      child:ElevatedButton(onPressed: () {
                        if (kDebugMode) {
                          print('Complete Button Pressed');
                        }


                      },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEBF3FF),
                            elevation: 0,
                        ), child: const Text('Complete', style: TextStyle(color: Colors.black, fontSize: 13),),
                        //parameters of Button class
                      )
                  ),

                  SizedBox(
                      height:32, //height of button
                      width:96, //width of button
                      child:ElevatedButton(onPressed: () {
                        if (kDebugMode) {
                          print('Draft Button Pressed');
                        }


                      },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEBF3FF),
                            elevation: 0,
                        ), child: const Text('Draft', style: TextStyle(color: Colors.black,fontSize: 13),),

                        //parameters of Button class
                      )
                  )

                ],
              )


            ],
          )
        ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
