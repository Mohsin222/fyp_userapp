import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:resturant_user_app/constants/loading_circal.dart';
import 'package:resturant_user_app/services/background_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import '../providers/auth_provider.dart';

class TableBookWidget extends StatefulWidget {
  const TableBookWidget({super.key});

  @override
  State<TableBookWidget> createState() => _TableBookWidgetState();
}

class _TableBookWidgetState extends State<TableBookWidget> {
  TimeOfDay? bookedTime;
    void changeEndTime(TimeOfDay startTimeOfDay) {
    DateTime today = DateTime.now();
    DateTime customDateTime = DateTime(today.year, today.month, today.day,
        startTimeOfDay.hour, startTimeOfDay.minute);

        print(TimeOfDay.fromDateTime(customDateTime.add(Duration(minutes: 2))));
        bookedTime =TimeOfDay.fromDateTime(customDateTime.add(Duration(minutes: 2)));
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
 
      builder: (context, value,child) {
        return Container(
      height: 80,
      child:   StreamBuilder(
      
        stream:  FirebaseFirestore.instance.collection("tablesdataset")
      
                      
      
                      .doc('My')
      
                      // .collection('My')
      
                      .snapshots(),
      
        builder:((context, snapshot) {
      
        if(snapshot.data !=null){
      
      if(snapshot.connectionState == ConnectionState.active){
      
      
      
        if(snapshot.hasData){
      
            DocumentSnapshot snp =snapshot.data as DocumentSnapshot;
      
        return    snp['Length']-snp['filled']> 0?
      
      Container(
                    height: 80,
                    child: StreamBuilder(
                              stream: FirebaseFirestore.instance.collection("Users")
                        .doc(value.logedUser!.uid as String)
                        .snapshots(),
                      builder: (
                      
                      (context, snapshot) {
                      DocumentSnapshot? snp =snapshot.data as DocumentSnapshot;
                           if(snapshot.data !=null){
    if(snapshot.connectionState == ConnectionState.active){
    if(snapshot.hasData){
    
    return    snp['panalty'] == false? 
    
      snp['booktable']==false?

       InkWell(
                    onTap: (){
                      value.bookTable();
          FirebaseFirestore.instance.collection('Users').doc(value.logedUser!.uid).update(
            // value.logedUser!.toMap()
            {
              // "booked": FieldValue.increment(1),
              "booktable":true
    
            }
          ).then((value) async{
    
            
              Workmanager()
                            .registerOneOffTask(simpleTaskKey, simpleTaskKey,
                                inputData: <String, dynamic>{
                                  'int': "MOHSIN IRFAAN",
                                  'bool': true,
                                  'double': 1.0,
                                  'string': 'string',
                                  'array': [1, 2, 3],
                               
                                },


                                initialDelay: Duration(minutes: 1));
                                changeEndTime(TimeOfDay.now());
          SharedPreferences prefs = await SharedPreferences.getInstance();

          prefs.setString('book_time',bookedTime!.hour.toString()+':'+ bookedTime!.minute.toString(),);
    //for model dataset
                  
          }).catchError((e){
        log(e.toString());
          });
            
                 FirebaseFirestore.instance.collection('tablesdataset').doc('My').update({
            // "booked": FieldValue.increment(1),
            // "empty":FieldValue.increment(-1)
              // "booked": 21
           } ).then((value) {}).catchError((e){
            log('aaaaaaaaaa');
           });
                    },
                    child: Container(
                  
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 16, 151, 86),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      margin: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(20),
                      child: Text('BOOK Table',style: TextStyle(color: Colors.white),),
                    ),
                  ):
                  Container(
                   
                  )
    :
    Text('You are in panalty',style: Theme.of(context).textTheme.headline2,);
    
    
    }else{
         return Center(
          child: Text('No Data'),
         );
    }
    }else if(snapshot.connectionState == ConnectionState.waiting){
       return loadingCircle();
    }else{
         return loadingCircle();
    }
                           }else{
                            return loadingCircle();
                           }
                    })),
                  )
      
      
      
            :Center(child: Text('No Table Available',style: Theme.of(context).textTheme.headline3,),);
      
        }else{
      
          return Center(child: Text('No data'),);
      
        }
      
      }
      
      
      
      else{
      
        return loadingCircle();
      
      }
      
        }else{
      
          return loadingCircle();
      
        }
      
      })),
    );
      }
    );
  }
}