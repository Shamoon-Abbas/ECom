import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_com/screens/category_product.dart';
import 'package:e_com/screens/product_detail.dart';
import 'package:e_com/services/database_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/shared_preference_helper.dart';
import '../widget/app_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen>{

  String? name,image;

  getthesharedpref()async{
    name=await SharedPreferencesHelper().getUserName();
    image=await SharedPreferencesHelper().getUserImage();

    setState(() {

    });
  }


  ontheload()async{
    await getthesharedpref();
    setState(() {

    });
  }

  @override
  void initState() {
    ontheload();
    // TODO: implement initState
    super.initState();

  }


  var array=[
    "assets/images/headphone_icon.png",
    "assets/images/laptop.png",
    "assets/images/watch.png",
    "assets/images/TV.png",
  ];

  List categoryName=[
    "Headphone",
    "Laptop",
    "Watch",
    "TV"
  ];

  bool search=false;
  var queryResultSet=[];
  var tempSearchStore=[];
  TextEditingController searchController=new TextEditingController();


  initiateSearch(value){
    if(value.length==0){
      setState(() {
        queryResultSet=[];
        tempSearchStore=[];
      });
    }

    setState(() {
      search=true;
    });

    var capitalizedValue=value.substring(0,1).toUpperCase()+value.substring(1);
    if(queryResultSet.isEmpty && value.length==1){
      DatabaseMethods().search(value).then((QuerySnapshot docs){
        for(int i=0;i<docs.docs.length;++i){
          queryResultSet.add(docs.docs[i].data());
          // tempSearchStore.add(docs.docs[i].data());
        }
        setState(() {});
      });
    }else{
      tempSearchStore=[];
      queryResultSet.forEach((element){
        if(element['Updatedname'].startsWith(capitalizedValue)){
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  var array1=[
    {
      "img":"assets/images/headphone2.png",
      "text":"Headphone",
      "price":"\$100"
    },
    {
      "img":"assets/images/watch2.png",
      "text":"Apple Watch",
      "price":"\$300"
    },
    {
      "img":"assets/images/laptop2.png",
      "text":"Laptop",
      "price":"\$700"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: name==null? Center(child: CircularProgressIndicator()) : SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60,),

            search?
            ListView(
              padding: EdgeInsets.only(right: 10.0, left:10.0),
              primary: false,
              shrinkWrap: true,
              children: tempSearchStore.map((element){
                return buildResultCard(element);
              }).toList(),
            ):
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          RichText(text: TextSpan(
                            text: "Hey, "+name!,
                            style: AppWidget.boldTextFieldStyle(),
                            children: <TextSpan>[
                              TextSpan(
                                text: "\nGood Morning",
                                style: AppWidget.lightTextFieldStyle()
                              )
                            ]
                          ),

                          )
                        ],
                      ),

                      ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(image!,height: 105,width: 105,fit: BoxFit.cover,))

                    ],
                  ),
                ),


            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: TextField(
                   controller: searchController,
                  onChanged: (value){
                    initiateSearch(value.toUpperCase());
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Colors.white,
                      prefixIcon: search? GestureDetector(
                        onTap: (){
                          search=false;
                          tempSearchStore=[];
                          queryResultSet=[];
                          searchController.text="";
                          setState(() {

                          });
                        },
                          child: Icon(Icons.close)) :
                      Icon(Icons.search),
                    hintText: "Search Products",
                    hintStyle: AppWidget.lightTextFieldStyle()
                  ),
                ),
              )
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Categories",style: AppWidget.semiBoldTextFieldStyle(),),
                  Text("see all",style: TextStyle(fontSize: 22,color: Colors.orange,fontWeight: FontWeight.bold),)
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      height: 180,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(20)

                      ),
                      child: Center(
                        child: Text("All",style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),),
                      ),
                    ),
                  ) ),

                  Expanded(
                    child: SizedBox(height: 180,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: ListView.builder(itemBuilder: (context,index){
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryProduct(category: categoryName[index])));
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 20),
                              height: 180,
                              width: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white

                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset('${array[index]}',height:120,width: 100,fit: BoxFit.cover,),
                                    Icon(Icons.arrow_forward)
                                  ],
                                ),
                              ),
                            ),
                          );
                        }, itemCount: array.length,scrollDirection: Axis.horizontal,),
                      ),
                    ),
                  ),

              ],
            ),

            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("All Products",style: AppWidget.semiBoldTextFieldStyle(),),
                  Text("see all",style: TextStyle(fontSize: 22,color: Colors.orange,fontWeight: FontWeight.bold),)

                ],
              ),
            ),
            SizedBox(height: 30,),
            SizedBox(
              height: 350,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListView.builder(itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Container(
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('${array1[index]['img']}',height: 250, width: 250, fit: BoxFit.cover,),
                          Text("${array1[index]['text']}",style: AppWidget.semiBoldTextFieldStyle(),),
                          Padding(
                            padding: const EdgeInsets.only(left: 20,right:20,bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${array1[index]['price']}",style: TextStyle(
                                fontSize: 22,color: Colors.orange,fontWeight: FontWeight.bold

                                ),),
                                Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(7)

                                  ),
                                  child: Icon(Icons.add,color: Colors.white,),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },itemCount: array1.length,scrollDirection: Axis.horizontal,),
              ),
            )


              ],
            ),

          ],
        ),
      ),

    );

  }

  Widget buildResultCard(data){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetail(detail: data['Detail'], image: data['Image'], name: data['Name'], price: data['Price'] )));
      },
      child: Container(
        padding: EdgeInsets.only(left: 20.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
        ),
        height: 100,
        child: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(data['Image'],height: 70,width: 70,fit: BoxFit.cover,)),
            SizedBox(width: 20.0,),
            Text(data['Name'],style: AppWidget.semiBoldTextFieldStyle(),)
          ],
        ),
      ),
    );
  }

}