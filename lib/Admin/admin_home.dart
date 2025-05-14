import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import'package:flutter/material.dart';

import '../widget/app_widget.dart';
import 'add_product.dart';
import 'all_orders.dart';


class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {

  late List<Widget> pages;

  late AllOrders order;
  late AddProduct product;
  int currentIndex=0;

  @override
  void initState() {
    order=AllOrders();
    product=AddProduct();

    pages=[order,product];
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
        index: currentIndex,

        onTap: (int index){
          setState(() {
            currentIndex=index;
          });

        },

        items: [
          Icon(
            Icons.list_alt_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.add_shopping_cart_outlined,
            color: Colors.white,
          ),

        ]),

    body: pages[currentIndex],
    );
  }
}
