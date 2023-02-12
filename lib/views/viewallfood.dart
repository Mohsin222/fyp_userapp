import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:provider/provider.dart';
import 'package:resturant_user_app/widgets/appbar.dart';

import '../models/food_item.dart';
import '../providers/find_food_provider.dart';
import '../widgets/add_widget.dart';
import 'food_detailsitem_details_screen.dart';

class ViewAllFoodScreen extends StatelessWidget {
var x=0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  bottomNavigationBar: AddWidget(),
      backgroundColor: Colors.white,
appBar: appBar,
      body: Consumer<FindFood>(builder: (context, value, child) {
        return SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [

                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.centerLeft,
                  child: Text('Categories',style: Theme.of(context).textTheme.headline2,),
                ),
              SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        height:200,
                        child: Row(
                          children: List.generate(value.categoryIcon.length,(val){
                            return  Container(
                              margin: EdgeInsets.all(5),
                              child: Column(
                                children: [
                                   InkWell(
                                    onTap: (){
                                      x=val;
                                    value.selectCategory(value.categorytext[val]);
                                      print(value.categorytext[val]);
                                      value.updateSearchQuery(value.categorytext[val]);
                                    },
                                     child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 50,
                                      backgroundImage: AssetImage(
                                        value.foodImages[val]
                                      ),
                                     )
                                   ),
                              Flexible(child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(value.categorytext[val]),
                              )),

                             
                                ],
                              ),
                            );
                          } )
                        ),
                      ),
                    ),
                 Expanded(
                   child: categories_card(),
                 ),
              ],
            ),
          ),
        );
      },),
    );
  }
}

class categories_card extends StatefulWidget {


  @override
  State<categories_card> createState() => _categories_cardState();
}

class _categories_cardState extends State<categories_card> with SingleTickerProviderStateMixin  {

  AnimationController? _animationController;
  Animation? _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      
      duration: Duration(seconds: 1),
    );
    _animationController!.forward();
    _animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.fastOutSlowIn,
    ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FindFood>(
      builder: (context, value, child) {

        return  ListView.builder(
                          itemCount: value.getFilteredData().length,
                          itemBuilder: (context,index){
  FoodItem foodItem =
                               value.getFilteredData()[index];
                          if(value.getFilteredData().length >0){
                            return Container(
       decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
       
       color: Theme.of(context).scaffoldBackgroundColor),
                 child:AnimatedBuilder(
                   animation: _animationController!,
                  builder: (context, child) {
                    return Transform(
                 
                           transform: Matrix4.translationValues(
                  _animation!.value * 100,
                  0.0,
                  0.0,
                ),
                    child:  InkWell(
                         onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> FoodItemDetailScreen(foodItem: foodItem)));
                      },
                      child: Container(
                                       child: Material(
                      elevation: 20,
                       child: Column(
                         children: [
                           Container(
                             
                             height: 140,
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight:  Radius.circular(30)),
                               image: DecorationImage(image: NetworkImage(foodItem.picture.toString()),fit: BoxFit.cover)),
                         
                           ),
                         Container(
                           margin: EdgeInsets.symmetric(horizontal: 10),
                           padding: EdgeInsets.symmetric(vertical: 5),
                           child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             //name
                             Text(foodItem.name.toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                               Icon(Icons.star,color: Colors.yellow,),
                           ],
                           ),
                         ),
                             //name
                         Container(
                                       
                           margin: EdgeInsets.symmetric(horizontal: 10),
                           padding: EdgeInsets.symmetric(vertical: 5),
                         
                           child: Text(foodItem.description.toString(),maxLines: 2,style: TextStyle(fontSize: 12,color: Colors.black87,
                           
                           ),),
                         ),
                                       
                                  Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                              Container(
                           margin: EdgeInsets.symmetric(horizontal: 10),
                           padding: EdgeInsets.symmetric(vertical: 5),
                           child: Text('Rs '+foodItem.price.toString(),maxLines: 2,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                      
                                     
                         ),
                                     
                                Container(
                           margin: EdgeInsets.symmetric(horizontal: 10),
                           padding: EdgeInsets.symmetric(vertical: 5),
                           child: Text('Discount  ${foodItem.discount}%',maxLines: 2,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                      
                                     
                         ),
                                   ],
                                  ),
                         
                         ],
                       ),
                                       ),
                                     ),
                    ),
                      )  ;
                  },
                 ));
                          }

                          else{
                            return Center(
                              child: Text('No Data',style: TextStyle(fontSize: 25),),
                            );
                          }

                        });
 
      },
    );
  }
}


