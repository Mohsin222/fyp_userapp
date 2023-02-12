 import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:resturant_user_app/components/button2.dart';

Widget ratdialog(BuildContext context){
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