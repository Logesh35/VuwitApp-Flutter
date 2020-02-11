import 'package:flutter/material.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({Key key}) : super(key: key);

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
        child: new Icon(Icons.camera_alt,
        color: Colors.white),
        onPressed: ()=>{ print("Requesting Camera for status") },
      ),
  );
}
}