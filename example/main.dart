import 'package:flutter/material.dart';
import 'package:mncapps/mncapps.dart';

void main() {
  runApp(MaterialApp(
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.near_me),
            onPressed: () {
              //Example Full Screen MNC More Apps
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MNCAppsScreen(
                    userID: "YOUR USER ID",
                    cachingStrategy: CachingStrategy.Weekly,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      //Example Implemented in body of widget
      body: MNCAppsBody(
        userID: "YOUR USER ID",
        cachingStrategy: CachingStrategy.Weekly,
      ),
    );
  }
}
