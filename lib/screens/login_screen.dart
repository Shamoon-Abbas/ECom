import 'package:e_com/screens/signup_screen.dart';
import 'package:e_com/widget/app_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widget/snack_bar_helper.dart';
import 'bottom_nav.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formkey=GlobalKey<FormState>();

  bool hide=true;

  String email='';
  String pass='';

  TextEditingController emailController=TextEditingController();
  TextEditingController passController=TextEditingController();

  userLogin()async{

      try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass);



        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNav()));

        SnackBarHelper.show(context, "Logged In Successfully", Colors.blue);


      }on FirebaseException catch(e){
        if(e.code=="user-not-found"){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text("User not Found",style: TextStyle(
              fontSize: 18
            ),),
          ));

        }else if(e.code=='wrong-password'){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text("Wrong Password",style: TextStyle(
              fontSize: 18
            ),),
          ));
        }else if(e.code=='invalid-credential'){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text("Invalid Credentials",style: TextStyle(
                fontSize: 18
            ),),
          ));
        } else{
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(e.code,style: TextStyle(fontSize: 18),)));
        }
      }

    }





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
                Center(child: Text("Sign In",style: AppWidget.semiBoldTextFieldStyle(),)),
                SizedBox(height: 10,),
                Text("   Please enter the details below to\n                           continue",style: AppWidget.lightTextFieldStyle(),),
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
                      obscureText: hide,
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return "Please enter the Password";
                        }
                      },
                      onTap: (){
                        setState(() {
                          hide=true;
                        });
                      },
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
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Forgot Password?",style: TextStyle(
                      fontSize: 18,
                      color: Colors.green
                    ),)
                  ],
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
                          email=emailController.text;
                          pass=passController.text;
                        });

                        userLogin();
                      }
                    },
                        child:Text("LOGIN",style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))

                    ),),
                  ),
                ),
                SizedBox(height: 20,),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?",style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                    )),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                      },
                      child: Text(" Sign Up",style: TextStyle(
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
