import 'dart:io';

import 'package:e_com/screens/onboarding_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

import '../services/auth_methods.dart';
import '../services/shared_preference_helper.dart';
import '../widget/app_widget.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState();
  }
}


class ProfileScreenState extends State<ProfileScreen> {

  String? image, name, email;
  final ImagePicker _picker=ImagePicker();
  File? selectedImage;

  getthesharedpref() async {
    image = await SharedPreferencesHelper().getUserImage();
    name = await SharedPreferencesHelper().getUserName();
    email = await SharedPreferencesHelper().getUserEmail();
    setState(() {});
  }

  Future getImage()async{
    var image=await _picker.pickImage(source: ImageSource.gallery);
    selectedImage=File(image!.path);
    uploadItem();
    setState(() {

    });
  }


  uploadItem() async {
    if(selectedImage!=null ){
      String addId=randomAlphaNumeric(10);
      Reference firebaseStorageRef=FirebaseStorage.instance.ref().child('blogImage').child(addId);

      final UploadTask task= firebaseStorageRef.putFile(selectedImage!);
      var downloadUrl= await (await task).ref.getDownloadURL();
      await SharedPreferencesHelper().saveUserImage(downloadUrl);





    }
  }







  @override
  void initState() {
    getthesharedpref();
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: AppWidget.boldTextFieldStyle(),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade300,
      body: name==null ? Center(child: CircularProgressIndicator()) : Container(
        child: Column(
          children: [
            SizedBox(height: 20,),
            selectedImage!=null?
            Center(child: Stack(children:[ClipOval(child: Image.file(selectedImage!,height: 250,width:250, fit: BoxFit.cover,)),
              Positioned(left: 170,bottom:0,child: GestureDetector(onTap: (){
                getImage();
              },child: Icon(Icons.edit)))
            ] ),
            )
            :
                Center(child: Stack(children:[
                  ClipOval(child: Image.network(image!,height: 250,width:250, fit: BoxFit.cover,)),
                  Positioned(left: 170,bottom:0,child: GestureDetector(onTap: (){
                    getImage();
                  }, child: Icon(Icons.edit)))]),),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Material(
                borderRadius: BorderRadius.circular(15),
                elevation: 3.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Icons.account_circle_outlined,size: 45,color: Colors.blueGrey,),
                        SizedBox(width: 15,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Name",style: AppWidget.lightTextFieldStyle(),),
                            Text(name!,style: AppWidget.semiBoldTextFieldStyle(),)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Material(
                borderRadius: BorderRadius.circular(15),
                elevation: 3.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Icons.email_outlined,size: 45,color: Colors.blueGrey,),
                        SizedBox(width: 15,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Email",style: AppWidget.lightTextFieldStyle(),),
                            Text(email!,style: AppWidget.semiBoldTextFieldStyle(),)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: GestureDetector(
                onTap: ()async{


                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.grey.shade300,
                        title: const Text('Logout'),
                        content: const Text('Are you sure you want to Logout?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog without confirming
                            },
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () async{
                              await AuthMethods().Signout().then((value){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OnboardingScreen()));
                              });
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      );
                    },
                  );




                },
                child: Material(
                  borderRadius: BorderRadius.circular(15),
                  elevation: 3.0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Icon(Icons.logout_outlined,size: 45,color: Colors.blueGrey,),
                          SizedBox(width: 15,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Logout",style: AppWidget.semiBoldTextFieldStyle(),),
                            ],
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_outlined,)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),


            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: GestureDetector(
                onTap: ()async{



                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.grey.shade300,
                        title: const Text('Account Deletion'),
                        content: const Text('Are you sure you want to permanently Delete your Account?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog without confirming
                            },
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () async{
                              await AuthMethods().deleteUser().then((value){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OnboardingScreen()));
                              });
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      );
                    },
                  );


                  // await AuthMethods().deleteUser().then((value){
                  //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OnboardingScreen()));
                  // });
                },
                child: Material(
                  borderRadius: BorderRadius.circular(15),
                  elevation: 3.0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.redAccent.shade200,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Icon(Icons.delete_outline_sharp,size: 45,),
                          SizedBox(width: 15,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Delete Account",style: AppWidget.semiBoldTextFieldStyle(),)
                            ],
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_outlined,)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            

          ],
        ),
      ),
    );
  }

}