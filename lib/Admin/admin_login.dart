import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widget/app_widget.dart';
import '../widget/snack_bar_helper.dart';
import 'admin_home.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {


  TextEditingController passController=TextEditingController();
  TextEditingController nameController=TextEditingController();





  bool hide=true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Container(
        margin: EdgeInsets.only(left: 20,right: 20,top: 50),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/login.png"),
              SizedBox(height: 10,),
              Center(child: Text("Admin Panel",style: AppWidget.semiBoldTextFieldStyle(),)),
              SizedBox(height: 30,),

              Text("Username",style: AppWidget.semiBoldTextFieldStyle(),),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade200
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left:20),
                  child: TextFormField(
                    controller: nameController,

                    decoration: InputDecoration(
                        hintText: "Name",
                        border: InputBorder.none
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),

              Text("Password",style: AppWidget.semiBoldTextFieldStyle(),),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade200
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left:20),
                  child: TextFormField(
                    onTap: (){
                      setState(() {
                        hide=true;
                      });
                    },
                    obscureText: hide,
                    controller: passController,

                    decoration: InputDecoration(
                        hintText: "Password",
                        suffixIcon: GestureDetector(
                            onTap: (){
                              setState(() {
                                hide=false;
                              });
                            },
                            child: Icon(Icons.remove_red_eye)),
                        border: InputBorder.none
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20,),
              Center(
                child: Container(
                  height: 50,
                  width: MediaQuery.sizeOf(context).width/2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2)
                  ),
                  child: ElevatedButton(onPressed: (){
                    LoginAdmin();
                  },
                    child:Text("SIGN IN",style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

                    ),),
                ),
              ),
              SizedBox(height: 20,),

              SizedBox(height: 40,)

            ],
          ),
        ),
      ),
    );
  }

  LoginAdmin()async{
    FirebaseFirestore.instance.collection('admin').get().then((snapshot){
      snapshot.docs.forEach((result){
        if(result.data()['Name']!=nameController.text.trim()){
          SnackBarHelper.show(context, "Invalid Username", Colors.redAccent);
        }
        else if(result.data()['Password']!=passController.text){
          SnackBarHelper.show(context,"Invalid Password", Colors.redAccent);
        }
        else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AdminHome()));
        }
      });
    });
  }
}
