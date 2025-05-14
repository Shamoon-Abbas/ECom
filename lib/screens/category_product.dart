import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_com/screens/product_detail.dart';
import 'package:e_com/widget/app_widget.dart';
import 'package:flutter/material.dart';

import '../services/database_methods.dart';

class CategoryProduct extends StatefulWidget {

  String category;
  CategoryProduct({required this.category});

  @override
  State<CategoryProduct> createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {

  Stream? CategoryStream;

  getontheload() async{
    CategoryStream=await DatabaseMethods().getProducts(widget.category);
    setState(() {

    });
  }

  @override
  void initState() {
    getontheload();
    // TODO: implement initState
    super.initState();
  }

  Widget allProducts() {
    return StreamBuilder(
        stream: CategoryStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.6,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot snap = snapshot.data.docs[index];

                    return Container(
                      // margin: EdgeInsets.  only(right: 20),
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                      decoration: BoxDecoration(color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(snap["Image"],height:150, width:150,fit: BoxFit.cover),
                          SizedBox(height:10,),
                          Text(snap["Name"],style: AppWidget.semiBoldTextFieldStyle(),),
                          Spacer(),
                          Row(
                            children: [
                              Text("\$"+snap["Price"],style: AppWidget.semiBoldTextFieldStyle(),),
                              SizedBox(width: 10,),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetail(image: snap["Image"], name: snap["Name"], price: snap["Price"], detail: snap["Detail"])));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(5)),
                                  child: Icon(Icons.add,color: Colors.white)
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: allProducts())
          ],
        ),
      ),
    );
  }
}
