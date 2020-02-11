import 'package:flutter/material.dart';
import 'package:vuwit_app_ios/pages/call_screen.dart';
import 'package:vuwit_app_ios/pages/camera_screen.dart';
import 'package:vuwit_app_ios/pages/chat_screen.dart';
import 'package:vuwit_app_ios/pages/event_screen.dart';
import 'package:vuwit_app_ios/pages/status_screen.dart';

class VuwitAppHome extends StatefulWidget {
  VuwitAppHome({Key key}) : super(key: key);

  @override
  _VuwitAppHomeState createState() => _VuwitAppHomeState();
}

class _VuwitAppHomeState extends State<VuwitAppHome> with SingleTickerProviderStateMixin {
  TabController  _tabController ;
  @override
  void initState() { 
    super.initState();
    _tabController = new TabController(vsync: this,initialIndex: 1,length: 5) ;    
  }
  @override
  Widget build(BuildContext context) {
    // var white;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("VuwitApp"),
        elevation: 0.7,
        bottom: new TabBar(
          isScrollable: true,
          controller: _tabController,
          indicatorColor: Colors.white ,
          tabs: <Widget>[
            new Tab(icon: new Icon(Icons.camera_alt)),
            new Tab(text: "Chats"),
            new Tab(text: "Status"),
            new Tab(text: "Events"),
            new Tab(text: "Calls")
          ],
        ),
        actions: <Widget>[
          new Icon(Icons.search),
          new Icon(Icons.more_vert)
        ],
      ),
      body: new TabBarView(
        controller: _tabController,
        children: <Widget>[
          new CameraScreen(),
          new ChatScreen(),
          new StatusScreen(),
          new EventScreen(),
          new CallScreen()
        ],
      ),
      
    );
  }
}