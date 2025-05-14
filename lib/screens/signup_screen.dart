import 'package:e_com/screens/bottom_nav.dart';
import 'package:e_com/services/shared_preference_helper.dart';
import 'package:e_com/widget/snack_bar_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

import '../services/database_methods.dart';
import '../widget/app_widget.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  String? name,email,pass;

  TextEditingController emailController=TextEditingController();
  TextEditingController passController=TextEditingController();
  TextEditingController nameController=TextEditingController();

  final _formkey=GlobalKey<FormState>();


  registration() async {
    if(name!=null && email!=null && pass!=null ){
      try{
        UserCredential userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email!, password: pass!);


        String id=randomAlphaNumeric(10);

        await SharedPreferencesHelper().saveUserId(id);
        await SharedPreferencesHelper().saveUserName(nameController.text);
        await SharedPreferencesHelper().saveUserEmail(emailController.text);
        await SharedPreferencesHelper().saveUserImage("https://img.freepik.com/free-vector/anime-chibi-boy-wearing-cap-character_18591-82515.jpg?w=360");


        Map<String,dynamic> userInfoMap={
          "Name":nameController.text,
          "Email":emailController.text,
          "Id":id,
          "Image": "https://img.freepik.com/free-vector/anime-chibi-boy-wearing-cap-character_18591-82515.jpg?w=360"
        };

        await DatabaseMethods().AddUserDetails(userInfoMap, id);

        Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNav()));
        SnackBarHelper.show(context, "Registered Successfully", Colors.blue);
        
  } on FirebaseException catch(e){
        if(e.code=="weak-password"){

          SnackBarHelper.show(context, "Password is too weak!", Colors.redAccent);
        } else if(e.code=="email-already-in-use"){

          SnackBarHelper.show(context, "Email Already in Use!", Colors.redAccent);
        }else{

          SnackBarHelper.show(context, e.code, Colors.redAccent);

        }
      }
  }
  }

  bool hide=true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Container(
        margin: EdgeInsets.only(left: 20,right: 20,top: 50),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("assets/images/login.png"),
                SizedBox(height: 10,),
                Center(child: Text("Sign Up",style: AppWidget.semiBoldTextFieldStyle(),)),
                SizedBox(height: 10,),
                Text("   Please enter the details below to\n                           continue",style: AppWidget.lightTextFieldStyle(),),
                SizedBox(height: 20,),
                Text("Name",style: AppWidget.semiBoldTextFieldStyle(),),
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

                      validator:(value){
                        if(value==null || value.isEmpty){
                          return "Please enter the Name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Name",
                          border: InputBorder.none
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Text("Email",style: AppWidget.semiBoldTextFieldStyle(),),
                SizedBox(height: 20,),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade200
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left:20),
                    child: TextFormField(
                      controller: emailController,
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return "Please enter the Email";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Email",
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
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return "Please enter the Password";
                        }
                        return null;
                      },
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
                      if(_formkey.currentState!.validate()){

                        setState(() {
                          name=nameController.text;
                          email=emailController.text;
                          pass=passController.text;
                        });

                        registration();
                      }
                    },
                      child:Text("SIGN UP",style: TextStyle(
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
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?",style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                    )),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      },
                      child: Text(" Sign In",style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.w500
                      ),),
                    )
                  ],
                ),
                SizedBox(height: 40,)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
