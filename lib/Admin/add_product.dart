import 'dart:io';

import 'package:e_com/services/database_methods.dart';
import 'package:e_com/widget/app_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

import '../widget/snack_bar_helper.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {


  final ImagePicker _picker=ImagePicker();
  File? selectedImage;
  TextEditingController nameController=TextEditingController();
  TextEditingController priceController=TextEditingController();
  TextEditingController detailsController=TextEditingController();

  Future getImage()async{
    var image=await _picker.pickImage(source: ImageSource.gallery);
    selectedImage=File(image!.path);
    setState(() {

    });
  }

  uploadItem() async {
    if(selectedImage!=null && nameController.text!=''){
      String addId=randomAlphaNumeric(10);
      Reference firebaseStorageRef=FirebaseStorage.instance.ref().child('blogImage').child(addId);

      final UploadTask task= firebaseStorageRef.putFile(selectedImage!);
      var downloadUrl= await (await task).ref.getDownloadURL();
      String firstLetter= nameController.text.substring(0,1).toUpperCase();


      Map<String,dynamic> addProduct={
        'Name': nameController.text,
        'Image': downloadUrl,
        'SearchKey': firstLetter,
        'UpdatedName': nameController.text.toUpperCase(),
        'Price': priceController.text,
        'Details': detailsController.text,
      };

      await DatabaseMethods().addProduct(addProduct, value!).then((value) async{
        await DatabaseMethods().addAllProducts(addProduct);
        selectedImage=null;
        nameController.text='';
        SnackBarHelper.show(context, "Product has been uploaded Successfully", Colors.green);
      });
    }
  }


  List<String> categoryitem=[
    'Headphone',
    'Laptop',
    'Watch',
    'TV'
  ];
  String? value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text("Add Product",style: AppWidget.boldTextFieldStyle(),),
        centerTitle: true,
        backgroundColor: Colors.white,

        // leading: GestureDetector(
        //     onTap: (){
        //       Navigator.pop(context);
        //     },
        //     child: Icon(Icons.arrow_back_ios_new)),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 50),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Upload the Product Image",style: AppWidget.lightTextFieldStyle(),),
              SizedBox(height: 20,),
              Center(
                child: selectedImage==null ? GestureDetector(
                  onTap: (){
                    getImage();
                  },
                  child: Container(
                    height: 170,
                    width: 170,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                        width: 2
                      )
                    ),
                    child: Icon(Icons.camera_alt_outlined,size: 35,),
                  ),
                ) :Center(
                  child: Material(
                    elevation: 4.0,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 170,
                      width: 170,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.black,
                              width: 2
                          )
                      ),
                      child: ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.file(selectedImage!,fit: BoxFit.cover,)),
                    ),
                  ),
                )
              ),
              SizedBox(
                height: 40,
              ),
              Text("Product Name",style: AppWidget.lightTextFieldStyle(),),
              SizedBox(height: 20,),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: InputBorder.none
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40,),
              Text("Product Category",style: AppWidget.lightTextFieldStyle(),),
              SizedBox(height: 20,),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      items: categoryitem
                                .map((item)=>DropdownMenuItem(
                                value: item,
                                child: Text(item,
                                style: AppWidget.semiBoldTextFieldStyle())))
                      .toList(),
                    onChanged: ((value)=>setState((){
                      this.value=value;
                    })),dropdownColor: Colors.white,
                      hint: Text("Select Category",),
                      iconSize: 36,
                      icon: Icon(Icons.arrow_drop_down,color: Colors.black,),
                      value: value,
                                ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text("Product Price",style: AppWidget.lightTextFieldStyle(),),
              SizedBox(height: 20,),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: TextField(
                    controller: priceController,
                    decoration: InputDecoration(
                        border: InputBorder.none
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text("Product Details",style: AppWidget.lightTextFieldStyle(),),
              SizedBox(height: 20,),
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: TextField(
                    maxLines: 6,
                    controller: detailsController,
                    decoration: InputDecoration(
                        border: InputBorder.none
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50,),
              Center(child: ElevatedButton(onPressed: (){
                uploadItem();
              }, child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Add Product",style: TextStyle(
                  fontSize: 30,
                  color: Colors.purpleAccent
                ),),
              ),style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white
              ),))
            ],
          ),
        ),
      ),


    );
  }
}
