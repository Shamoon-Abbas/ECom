import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:e_com/screens/profle_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'order_screen.dart';

class BottomNav extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BottomNavState();
  }
}

class BottomNavState extends State<BottomNav> {

  late List<Widget> pages;

  late HomeScreen home;
  late OrderScreen order;
  late ProfileScreen profile;
  int currentIndex=0;

  @override
  void initState() {
    home=HomeScreen();
    order=OrderScreen();
    profile=ProfileScreen();

    pages=[home,order,profile];
    super.initState();
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: CurvedNavigationBar(
        height: 70,
          backgroundColor: Colors.grey.shade300,
          color: Colors.black,
          animationDuration: Duration(milliseconds: 500),
          // index: currentIndex,

          onTap: (int index){
          setState(() {
            currentIndex=index;
          });

          },

          items: [
        Icon(
          Icons.home_outlined,
          color: Colors.white,
        ),
        Icon(
          Icons.shopping_bag_outlined,
          color: Colors.white,
        ),
        Icon(
          Icons.account_circle_outlined,
          color: Colors.white,
        ),

      ]),

      body: pages[currentIndex],

    );
  }

}