import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:resturant_user_app/widgets/appbar.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Container(
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(20),
              // height: 600,
 
              child: RichText(
                textAlign: TextAlign.center,
                    text:TextSpan(
                    text: 'Welcome To ',
                    // style:  TextStyle(
                    //   color: Colors.black,
                    //         fontSize: 28,
                    //         fontWeight: FontWeight.w700
                    //       ),
                    style: Theme.of(context).textTheme.headline1,
                          children: [
                            TextSpan(
                              text: 'Shafiq Resturant',
                               style: Theme.of(context).textTheme.headline1!.copyWith(color: Colors.green),
                            ),
                          ]
                  ) ),
            ),
                 Container(
                   margin: EdgeInsets.all(20),
              height: 200,
              width: double.infinity,
decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
image: DecorationImage(image: NetworkImage('https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cmVzdGF1cmFudHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60'),fit: BoxFit.fill)
),
           
            ),

            Container(
      margin: EdgeInsets.all(20),
              child: Text('When you are looking for Middle Eastern or Turkish restaurants in Karachi, you cannot go past Zeytin. We have captured the exotic flavours of the Mediterranean seaside region through to Turkey & created a exotic dining experience you will never forget. While we largely focus on offering delicious Middle Eastern & Turkish food, we also draw on Mediterranean influences to give our menu that extra twist. Meals are served up from traditionally Meze style to flavoursome chargrills giving you and your loved ones the chance to share your food, stories and laughs. We offer a warm and friendly dining restaurant, and an ambience to remember, making us the ideal venue for all your special occasions. Whether it is family dinner, casual parties or a corporate luncheon, we are the perfect place to go. In true Middle Eastern fashion, we love to celebrate food and we know our diners do too! That’s why we offer the best quality and tasting food every day in a spectacular',
              style: TextStyle(fontSize: 20,fontFamily:"Merriweather",fontWeight: FontWeight.w100 ),
              ),),
          ]),
        ),
      ),
    );
  }
}