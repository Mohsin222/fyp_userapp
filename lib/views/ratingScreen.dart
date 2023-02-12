import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';

import '../components/button2.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen>with SingleTickerProviderStateMixin  {


  @override
  Widget build(BuildContext context) {

    Widget ratdialog(){
      return Dialog(
        child: Container(
          height: 300,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Text('RATE US',
            
              style: Theme.of(context).textTheme.headline3),
                    SizedBox(height: 30,),
               Container(
      
      child: RatingBar.builder(
   initialRating: 3,
   minRating: 1,
   direction: Axis.horizontal,
   allowHalfRating: true,
   itemCount: 5,
   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
   itemBuilder: (context, _) => Icon(
     Icons.star,
     color: Colors.amber,
   ),
   onRatingUpdate: (rating) {
     print(rating);
   },
),


      ),
      SizedBox(height: 30,),
       button2(press: () {  }, text: 'Rate',)
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(actions: [IconButton(onPressed: (){
        showDialog(context: context, builder: (context){
          return ratdialog();
        });
      }, icon: Icon(Icons.add))],),
      body:Center(child: Container(height: 200,
      
      child: RatingBar.builder(
   initialRating: 3,
   minRating: 1,
   direction: Axis.horizontal,
   allowHalfRating: true,
   itemCount: 5,
   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
   itemBuilder: (context, _) => Icon(
     Icons.star,
     color: Colors.amber,
   ),
   onRatingUpdate: (rating) {
     print(rating);
   },
),
      ),)
    );
  }


  

}