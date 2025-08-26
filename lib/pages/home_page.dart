import 'package:flutter/material.dart';
import 'package:projeto_ddm/app_controller.dart';

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
 
}

class HomePageState extends State<HomePage> {
  int counter = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          CustomSwitcher(),
        ],
        centerTitle: true,
      ),
      body: Center(
        child: CustomSwitcher(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            counter++;
          });
        },
      ));
  }
}

class CustomSwitcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: AppController.instance.isDartTheme ,
      onChanged: (value) {
        AppController.instance.changeTheme();
      }
      );
    }
  }