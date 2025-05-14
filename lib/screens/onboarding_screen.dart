import 'package:e_com/screens/home_screen.dart';
import 'package:e_com/screens/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OnboardingScreenState();
  }
}

class OnboardingScreenState extends State<OnboardingScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 234, 235, 232),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
          ),
          Image.asset("assets/images/headphone.PNG"),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text("Explore",style: TextStyle(
              color: Colors.black,
              fontSize: 50,
              fontFamily: "serif-bold"
            ),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text("the",style: TextStyle(
              color: Colors.black,
              fontSize: 35,
              fontFamily: "serif-bold"
            ),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text("Best Products!",style: TextStyle(
              color: Colors.black,
              fontSize: 60,
              fontFamily: "serif-bold"
            ),),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ElevatedButton(onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignupScreen(),));
                }, child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Next",style: TextStyle(
                    fontSize: 20,
                    color: Colors.white
                  ),),
                ),style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: const CircleBorder(),
                  padding: EdgeInsets.all(30)
                ),),
              ),
            ],
          )

        ],
      ),
    );
  }

}
