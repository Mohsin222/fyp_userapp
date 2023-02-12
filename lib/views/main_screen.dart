import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
       
        child: SingleChildScrollView(child: Column(
      
          children: [
             Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                      color: const Color(0xff008000),
              ),
      
            height: 250.0,
            alignment: Alignment.center,
            child: const Text('Fixed Height Content'),
          ),
      
     Container(
      height: 250,
       child: GridView.count(crossAxisCount: 2,

      
       children: [
            Container(
              height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                        color: const Color(0xff008000),
                ),
        
              // height: 250.0,
              alignment: Alignment.center,
              child: const Text('Fixed Height Content'),
            ),
                Container(
                         height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                        color: const Color(0xff008000),
                ),
        
              // height: 250.0,
              alignment: Alignment.center,
              child: const Text('Fixed Height Content'),
            ),
       ],
       ),
     )
     
     ,
               Container(
                   decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                      color: Colors.redAccent,
              ),
         
            height: 280.0,
            alignment: Alignment.center,
            child: const Text('Fixed Height Content'),
          ),

  
          ],
        )),
      ),
    );
  }
}