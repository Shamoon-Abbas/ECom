import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_com/services/database_methods.dart';
import 'package:e_com/services/shared_preference_helper.dart';
import 'package:e_com/widget/app_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OrderScreenState();
  }
}

class OrderScreenState extends State<OrderScreen> {
  Stream? orderStream;

  String? email;

  getthesharedpref() async {
    email = await SharedPreferencesHelper().getUserEmail();
    setState(() {});
  }

  getontheload() async {
    await getthesharedpref();
    orderStream = await DatabaseMethods().getOrders(email!);
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    // TODO: implement initState
    super.initState();
  }

  Widget allOrders() {
    return StreamBuilder(
        stream: orderStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot snap = snapshot.data.docs[index];

                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 20.0),
                      child: Material(
                        elevation: 10.0,
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.network(
                                      snap['ProductImage'],
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            snap['Product'],
                                            style: AppWidget
                                                .semiBoldTextFieldStyle(),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            snap["Detail"],
                                            style: TextStyle(),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Row(
                                            children: [
                                              snap["Status"] == "Packaging"
                                                  ? Text(
                                                      snap["Status"],
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.purple,
                                                          fontSize: 16),
                                                    )
                                                  : snap["Status"] ==
                                                          "On the Way"
                                                      ? Text(
                                                          snap["Status"],
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.blue,
                                                              fontSize: 16),
                                                        )
                                                      : Text(
                                                          snap["Status"],
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.green,
                                                              fontSize: 16),
                                                        ),
                                              // SizedBox(width: 80,),
                                              Spacer(),
                                              Text(
                                                "\$" + snap["Price"],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.orange,
                                                    fontSize: 24),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Current Orders",
          style: AppWidget.boldTextFieldStyle(),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade300,
      body: Container(
        child: Column(
          children: [Expanded(child: allOrders())],
        ),
      ),
    );
  }
}
