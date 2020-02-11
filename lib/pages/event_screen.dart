import 'package:flutter/material.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({Key key}) : super(key: key);

  @override
 Widget build(BuildContext context) {
  return Scaffold(
    // appBar: AppBar(
    //   title: const Text('Floating Action Button Label'),
    // ),
    body: Center(
      child: const Text('Press the button with a label below!'),
    ),
   
floatingActionButton: new FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: new Icon(Icons.add,
        color: Colors.white),
        onPressed: ()=>{ print("Create New Event") },
      ),
  );
}
}