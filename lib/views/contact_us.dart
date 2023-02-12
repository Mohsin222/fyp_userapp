import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:resturant_user_app/components/button2.dart';
import 'package:resturant_user_app/constants/loading_circal.dart';
import 'package:resturant_user_app/models/contact_us.dart';
import 'package:resturant_user_app/providers/auth_provider.dart';
import 'package:resturant_user_app/widgets/appbar.dart';

import '../components/text_field.dart';
import '../constants/routes.dart';
import '../widgets/dialog.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}



bool loading =false;






class _ContactUsScreenState extends State<ContactUsScreen> {

TextEditingController descriptionController=TextEditingController();
TextEditingController phoneController =TextEditingController();
GlobalKey<FormState> _addFoodKey = GlobalKey<FormState>();

sendResponse(BuildContext context)async{
final authProvier =Provider.of<AuthProvider>(context,listen:false);
  ContactUs contactUs =ContactUs(
    name: authProvier.logedUser!.fullname.toString(),
    email: authProvier.logedUser!.email.toString(),
    contactNumber:phoneController.text.trim(),
    date: DateTime.now(),
    description: descriptionController.text.trim(),
  );
FirebaseFirestore.instance.collection('ContactsUs')
.add(contactUs.toMap()).then((value) {
  loading=false;
  Navigator.pushReplacementNamed(context, Router1.homeScreen);
}).catchError((err){

  showDialog(context: context, builder: (context){
    return Dialog1(twobtn: false,press: (){},showStatment: err, btnText: 'Back',);
  });

  log('Contact us error');
});
}

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneController.dispose();
    descriptionController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Container(child: SingleChildScrollView(
        child: Form(
          key: _addFoodKey,
          child: Stack(
            children: [
              Column(
                children: [
       
                  
     
                   
                                       //phone 
                                contact_us_text_field(controller: phoneController,labelText: 'Enter Phone',
                                press:(val) {
                   
                                            if (val!.isEmpty) {
                                        return 'Please enter Phone Number';
                                      }else{
                                    
                                      }
                                 
                                       }),
                                
                                
                               
                             
                                       
                                       
                   Container(
              height: 200,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.all(20),
                  child:TextFormField(
              controller: descriptionController,
              maxLines: 10,
              validator: (val) {
                   
                                            if (val!.isEmpty) {
                                        return 'Please enter Description';
                                      }else{
                                    
                                      }
                                 
                                       },
              decoration: InputDecoration(
        
                
              
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: 'Enter Description',
                helperText: "Enter Description",
              ),
                  )
              ),
                  Container(
              width: MediaQuery.of(context).size.width/2,
              child: button2(text: 'Send', press: (){
                 if (_addFoodKey.currentState!.validate()){

setState(() {
  loading=true;

  sendResponse(context);
});
                  print('aaaaaaaaaaaaaaa');
                 }
              })),
                
                ],
              ),

              loading ==true ?
              Positioned(child:loadingCircle()):SizedBox()
            ],
          ),
        ),
      )),
    );
  }
  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }





}


Widget contact_us_text_field({ required String labelText, required  TextEditingController controller,required String? press(value)}){
 return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
    padding: EdgeInsets.all(20),
      child:TextFormField(
        keyboardType: TextInputType.phone,
        controller: controller,
        validator: press,
        decoration: InputDecoration(

          
        
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          hintText: labelText,
          helperText: labelText,
        ),
      )
        );
}
