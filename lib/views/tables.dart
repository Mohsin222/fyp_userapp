import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';
import 'package:resturant_user_app/models/userModel.dart';
import 'package:resturant_user_app/providers/find_food_provider.dart';
import 'package:resturant_user_app/services/background_services.dart';
import 'package:resturant_user_app/widgets/appbar.dart';
import 'package:resturant_user_app/widgets/table_book_wodget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';


import '../providers/auth_provider.dart';

class TablesScreen extends StatefulWidget {
  


  @override
  State<TablesScreen> createState() => _TablesScreenState();
}

class _TablesScreenState extends State<TablesScreen> {
  void initilizeBackgroundService()async{
   await  Workmanager().initialize(
                      callbackDispatcher,
                      isInDebugMode: true,
                    );
  }

   List<UserModel> bookTables=[];
  int bookedTables=0;
  void getAllbookedTables()async{


    //  Timer.periodic(Duration(seconds: 10), (timer)async {
 
  
                 bookedTables=0;
   
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('Users');
   QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    // final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
UserModel userModel =UserModel();

    
    querySnapshot.docs.forEach((element) { 
      bookTables.add( UserModel.fromMap(element.data() as Map<String,dynamic>));

      });
         bookedTables=0;
      for (var element in bookTables) {
      print(element.booktable.toString());
        if(element.booktable ==true){
   
        bookedTables += 1;
        log(bookedTables.toString());
 
        }
  // print(bookedTables);
      }
      setState(() {
        
      });
      
    
    

     
    // });

 
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllbookedTables();
  }
      var time;
  getTime()async{
               SharedPreferences prefs = await SharedPreferences.getInstance();
        time=    prefs.getString("book_time");
        // setState(() {
          
        // });
  }

  @override
  Widget build(BuildContext context) {
    getTime();
    return Scaffold(
  //     appBar: AppBar(title: Text('Tables'),
  //     actions: [IconButton(onPressed: ()async{
  // initilizeBackgroundService();
  //     }, icon: Icon(Icons.abc_outlined))],
  //     ),
      appBar: appBar,

      body: Consumer<AuthProvider>(

        builder: (context, value,child) {
          return Column(
            children: [

              
           StreamBuilder(
            stream:  FirebaseFirestore.instance.collection("Users")
                
                .doc(value.logedUser!.uid)
                // .collection('My')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active){
                if(snapshot.hasData){
   DocumentSnapshot snp =snapshot.data as DocumentSnapshot;
      return  snp['panalty'] ==true?
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('You are in panalty',style: Theme.of(context).textTheme.headline3,),
                  IconButton(onPressed: (){
                    showDialog(context: context, builder: (context) {
                      return CupertinoAlertDialog(
  title: Padding(
    padding: const EdgeInsets.all(15.0),
    child: new Text("panalty",style:Theme.of(context).textTheme.headline3,),
  ),
  content: new Text("Contact with hotel management to remove panalty"),
  // actions: <Widget>[
  //   CupertinoDialogAction(
  //     isDefaultAction: true,
  //     child: Text("Yes"),
  //   ),
  //   CupertinoDialogAction(
  //     child: Text("No"),
  //   )
  // ],
);
                    },);
                  }, icon: Icon(Icons.help))
                ],
              )
               :
 TableBookWidget();

                }else if(snapshot.hasError){
                  return Center(child: Text("ERROR"),);
                }
                
              }
              return Container();
            },
           ),
    


      //xxxxxxxxxxxxxxxxxxxxxxxxx booktable button end xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx//
                 Container(
height: 150,
                decoration: BoxDecoration(
                  // color: Colors.grey,
                  borderRadius: BorderRadius.circular(10)
                ),
                margin: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
              
                
                alignment: Alignment.center,
                // padding: EdgeInsets.all(20),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("Users")
                  .doc(value.logedUser!.uid as String)
                  .snapshots(),
                  builder: (context, snapshot) {
                      DocumentSnapshot snp =snapshot.data as DocumentSnapshot;
                  
          
                   if(snapshot.data !=null){
                     if(snapshot.connectionState ==ConnectionState.active){
                      if(snapshot.hasData){
                
                
                    return Container(
                   height: 120,
width: 150,

                      child:  snp['booktable'] == true ?   Card(
                        child:  Column(
                          children: [
                            Text('My Table'),
                            Expanded(
                              child: Container(
                                // height: 40,
                                          
                                            
                                             
                                  child: Lottie.asset(
                                        'assets/animations/table.json',fit: BoxFit.cover),
                                ),
                                
                            ),
                              Container(child: Text('4 chairs',style: TextStyle(color: Colors.black,fontSize: 22),)),

                                    // Container(child: Text('Table book for 5 minutes',style: TextStyle(color: Colors.black,fontSize: 10),)),
                                     Container(child: Text('Table book till ${time}',style: TextStyle(color: Colors.black,fontSize: 10),)),
                          ],
                        ),
                      )
                      :
                      Center(
                        child: Text('No Table'),
                      ),
                    );
                    }else{
                       return  Center(
                        child: Text('No Table'),
                      );
                    }
                    }
                    else{
                    return   Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                   }
                     return   Center(
                        child: CircularProgressIndicator(),
                      );
                    
                  }
                ),
              ),
                // ElevatedButton(
                //   child: Text("Cancel All"),
                //   onPressed: () async {
                //     await Workmanager().cancelAll();
                //     print('Cancel all tasks completed');
                //   },
                // ),


                //tables list
      Container(
       child: Text( 'Available Tables',style: Theme.of(context).textTheme.headline2,),
      ),
      
              Expanded(
                child: StreamBuilder(stream:  FirebaseFirestore.instance.collection("tablesdataset")
                
                .doc('My')
                // .collection('My')
                .snapshots(),
              
                
                builder: ((context, snapshot) {
          
              if (snapshot.connectionState == ConnectionState.active){
              
                 if(snapshot.hasData){
                 DocumentSnapshot snp =snapshot.data as DocumentSnapshot;
                  // QuerySnapshot? dataSnapshot =snp as QuerySnapshot;
           return     snp['empty']> 0 ?
                   Consumer<FindFood>(
                 
                     builder: (context, value,child) {
               
                       return GridView.builder(
                        // itemCount: snp['Length'],
                                 
                                 gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                       maxCrossAxisExtent: 200,
                              childAspectRatio: 3 / 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20
                                   
                                 ),
                  
                                   //    itemCount: snp['empty']-snp['booked'],
                                  //  itemCount: bookedTables >=0?
                                  //  snp['Length']-snp['filled']- bookedTables:
              itemCount:      bookedTables <=0?
              snp['Length']-snp['filled'] 
              :snp['Length']-snp['filled']- bookedTables ,
                        itemBuilder: (context,index){
                        // return Container(
                                    
                        //   child: Icon(Icons.table_bar,
                        // color: Colors.grey,
                        // size: 100,),);
                                 
                        return   Container(
                              height: MediaQuery.of(context).size.height/2,
                                        margin: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                          
                                            
                                             
                                  child: Lottie.asset(
                                        'assets/animations/table.json',fit: BoxFit.cover),
                                ),
                              ),
                              Container(child: Text('4 chairs',style: TextStyle(color: Colors.black,fontSize: 22),),)
                            ],
                          ),
                        );
                                     }, );
                     }
                   )
                  
                  
                       :Center(child: Text('No Table Available',style: Theme.of(context).textTheme.headline3,),);
                  
                  
                 }
              }
                   else{
                                   return Center(child: CircularProgressIndicator());
                          }
                                     return Center(child: Text('NO DATA'));
                }
                ),
                   ),
              ),
            ],
          );
        }
      ) );
  }
}