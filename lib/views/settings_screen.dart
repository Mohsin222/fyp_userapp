import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:resturant_user_app/widgets/appbar.dart';

import '../constants/routes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: appBar,
      body: Container(child: SingleChildScrollView(
    child: colorTiles(context),

      )),
    );
  }
  Widget colorTiles(BuildContext context){
    return Column(
      children: [
        colorTile(Icons.person_outline, Colors.deepPurple, "Profile",(){}),
        
           colorTile(Icons.person_outline, Colors.deepOrange, "About Us",(){}),
              colorTile(Icons.contact_support, Colors.blueAccent, "Contact ",(){
                Navigator.pushNamed(context, Router1.contactUsScreen);
              }),
                 colorTile(Icons.directions, Colors.pinkAccent, "Direction",(){
                  MapsLauncher.launchCoordinates(
                    24.914015, 67.106898, 'Shafiq Resturant');
                 }),
      ],
    );
  }

  Widget colorTile(IconData icon, Color color , String text, VoidCallback press){
    Widget leading =    Container(height: 50,width: 50,
      child: Icon(icon,color: color,),
      decoration: BoxDecoration(
         color: color.withOpacity(0.09),
         borderRadius: BorderRadius.circular(18)
      ),
    
    
      );
       Widget title =Text(text,style: TextStyle(fontWeight: FontWeight.w500),) ;
       Widget tralling = Icon(Icons.arrow_forward_ios,color: Color.fromARGB(255, 16, 151, 86),size: 24,);
    return ListTile(
      onTap: press,
      contentPadding: EdgeInsets.all(10),
      leading: leading,

title: title,
trailing: tralling,      
   
    );
  }

  Widget divider(){
    return Padding(padding: EdgeInsets.all(8.0),
    child: Divider(thickness: 1.5,),
    );
  }
}