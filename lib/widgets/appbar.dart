import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant_user_app/providers/auth_provider.dart';

var appBar = AppBar(
  automaticallyImplyLeading: false,
iconTheme: IconThemeData(color: Colors.blue),
    // leading: IconButton(icon :Icon(Icons.arrow_back,color: Colors.white,),onPressed: (){
  
    // },),
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 16, 151, 86),
        // leading: Icon(Icons.draw_rounded),
        
        // actions: [
        //   Consumer<AuthProvider>(
            
        //     builder: (context, value,child) {
        //       return CircleAvatar(
                
        //         backgroundColor: Color.fromARGB(255, 16, 151, 86),
        //         radius: 18,
        //         backgroundImage: NetworkImage(value.logedUser ==null?
        //         'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60'
        //         :value.logedUser!.profilepic.toString()),
        //       );
        //     }
        //   ),
        //   Container(
        //     margin: EdgeInsets.only(left: 10),
        //   ),
        // ],
      );