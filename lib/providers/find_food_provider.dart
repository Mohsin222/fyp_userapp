

import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resturant_user_app/models/dealModel.dart';
import 'package:resturant_user_app/models/food_item.dart';
import 'package:resturant_user_app/models/userModel.dart';


import '../views/food_detailsitem_details_screen.dart';

class FindFood extends ChangeNotifier{
  FindFood(){
    getListOfFood();
    getListOfDeals();
// getAllbookedTables();
  }


  List<UserModel> bookTables=[];
  int bookedTables=0;
  void getAllbookedTables()async{

  
     Timer.periodic(Duration(seconds: 5), (timer)async {
        bookedTables=0;
          log('MOSHS');
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('Users');
   QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    // final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
UserModel userModel =UserModel();

    
    querySnapshot.docs.forEach((element) { 
      bookTables.add( UserModel.fromMap(element.data() as Map<String,dynamic>));

      });
        
      for (var element in bookTables) {
      // print(element.booktable.toString());
        if(element.booktable ==true){
        bookedTables += 1;
        notifyListeners();
        }
  // print(bookedTables);
      }
// print(bookTables);
      notifyListeners();
    });

 
  }

  String searchcategory='chicken';

  void selectCategory(String value){

searchcategory=value;
notifyListeners();
  }

  List<Icon> categoryIcon =[
    // Icon( Icons.new_releases, ),

Icon( FontAwesomeIcons.bowlFood,size: 35, ),
Icon( FontAwesomeIcons.bowlFood,size: 35, ),
Icon(FontAwesomeIcons.pizzaSlice,size: 35,color: Colors.white,),
Icon( FontAwesomeIcons.burger,size: 35, ),
Icon( FontAwesomeIcons.coffee,size: 35, ),
Icon(FontAwesomeIcons.plateWheat,size: 35,),
Icon(Icons.food_bank,size: 35,),

  ];
  // List categorytext = ["pizza","burger","Drink","Lunch","Beackfast"];

    List categorytext =[
    "chicken",
    "beef",
    "pizza",
    "burger",
    "drink",
    "chapati",
    "paratha",

  ];
      var foodImages =[
    "assets/category_img/chicken.jpg",
    "assets/category_img/beef.jpg",
    "assets/category_img/pizza.jpg",
    "assets/category_img/burger.jpg",
   "assets/category_img/drink.jpg",
    "assets/category_img/roti.jpg",
    "assets/category_img/paratha.jpg",
    

  ];


FoodItem foodItem =FoodItem(available: false, description: '', name: '', price: 0, uid: '',popular: false,foodType: '',category: '');
  bool singlefoodloading =false;
  FoodItem? singleFoodItem;
 Future  findFood(String uid,BuildContext context)async{
try {
  singlefoodloading =true;
  singleFoodItem=null;

     FirebaseFirestore.instance.collection('foodItems')
    .where("uid",isEqualTo: uid)
    
    .snapshots()
    .listen((value) {
      print(value.docs[0]['price'].toString());
//  DocumentSnapshot querySnapshot = value.docs as DocumentSnapshot;


  List<QueryDocumentSnapshot<Map<String, dynamic>>> querySnapshot =value.docs ;
 singleFoodItem =FoodItem.fromMap(querySnapshot[0].data());
   singlefoodloading =false;

     Navigator.push(context, MaterialPageRoute(builder: (context)=>FoodItemDetailScreen(foodItem: singleFoodItem!)));
 
//  singleFoodItem=null;
 notifyListeners();



    
    });

} catch (e) {
  log(e.toString());
}
  // return singleFoodItem!;
  }
List<FoodItem> allFood =[];


//chanr single food after moving to details screen
void chnageSingleFoodToNew(FoodItem foodItem){
  singleFoodItem =foodItem;
  // singlefoodloading=false;
  notifyListeners();
}
  
  
  //get list of all foods
  getListOfFood()async{
  
allFood.clear();
    final docRef = FirebaseFirestore.instance.collection("foodItems");
docRef.snapshots().listen(
      (event) {
        //  print("current data: ${event.docs}");
       List<QueryDocumentSnapshot<Map<String, dynamic>>> querySnapshot =event.docs ;



try {
    querySnapshot.forEach((element) { 
      allFood.add( FoodItem.fromMap(element.data()));
      //  print(element.data()[1].toString() +'111');
      // print(element['price']);
   
      });
      notifyListeners();
      // print(allFood);

} catch (e) {
  log(e.toString()+'aaaaaaaaaaaaaaaaa');
}


  
   

  
      
      },
      onError: (error) => print("Listen failed: $error"),
    );
  }
//food search
String searchQuery="chicken";
updateSearchQuery(String val){
  searchQuery=val;
  notifyListeners();
}
  //serach food in food list
 List<FoodItem> getFilteredData(){
 
  return allFood.where((element) =>
  
  element.category!.contains(searchQuery)
   ).toList();
  

 }


 //deals
 List<DealModel> allDeals =[];
   getListOfDeals()async{
    allDeals.clear();
      final docRef = FirebaseFirestore.instance.collection("deals");
docRef.snapshots().listen(
      (event) {
        //  print("current data: ${event.docs}");
       List<QueryDocumentSnapshot<Map<String, dynamic>>> querySnapshot =event.docs ;



try {
    querySnapshot.forEach((element) { 
      allDeals.add( DealModel.fromMap(element.data()));
      //  print(element.data()[1].toString() +'111');
      // print(element['price']);
   
      });
      notifyListeners();
      // print(allFood);

} catch (e) {
  log(e.toString()+'aaaaaaaaaaaaaaaaa');
}


  
   

  
      
      },
      onError: (error) => print("Listen failed: $error"),
    );


   }

}