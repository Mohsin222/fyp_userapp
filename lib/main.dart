import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:provider/provider.dart';
import 'package:resturant_user_app/constants/routes.dart';

import 'package:resturant_user_app/providers/auth_provider.dart';
import 'package:resturant_user_app/providers/find_food_provider.dart';
import 'package:resturant_user_app/providers/adds_provider.dart';
import 'package:resturant_user_app/services/background_services.dart';
import 'package:workmanager/workmanager.dart';

import 'models/userModel.dart';

void main() async{
  
  await   WidgetsFlutterBinding.ensureInitialized();
    Workmanager().initialize(
    callbackDispatcher, // The top level function, aka callbackDispatcher
    isInDebugMode: true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  );
  MobileAds.instance.initialize();

    await Firebase.initializeApp();

     User? currentUser = FirebaseAuth.instance.currentUser;
       if(currentUser != null) {
        // UserModel? thisUserModel = await HelperClass.getSavedData();
        AuthProvider authProvider =AuthProvider();
//  UserModel? thisUserModel = 
 await authProvider.getSavedDetails();
// runApp(
//   DevicePreview(
//     enabled: !kReleaseMode,
//     builder: (context) =>  MyApp1(userModel: thisUserModel!,), // Wrap your app
//   ),
//   );
// runApp(MyApp1(userModel: thisUserModel!));
  runApp(
          MyApp(currentUser:currentUser));
       }else{
        runApp(
           MyApp(currentUser:null));
       }
  
}




class MyApp extends StatelessWidget {
  final User? currentUser;

  const MyApp({super.key, required this.currentUser, });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
  ChangeNotifierProvider(create: (_) => AuthProvider()),

          ChangeNotifierProvider(create: (_) => FindFood()),
                 ChangeNotifierProvider(create: (_) => AddsProvider()),
    ],
    child:  MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       

         primarySwatch: Colors.blue,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
 iconTheme: IconThemeData(color: Colors.green),
        textTheme: TextTheme(

             headline1: TextStyle(
                        color: Colors.black,
                              fontSize: 35,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Merriweather',
                              letterSpacing: 2
                            ),
          headline2: TextStyle(
                        color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Sevillana',
                              letterSpacing: 2
                            ),

                            headline3:  TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700
                          ),
        )
      ),
      // home: FoodHomePage(),
      initialRoute:  currentUser==null ?Router1.homeRoute:Router1.homeScreen,
  onGenerateRoute: Router1.generateRoute,
    ),
    );
  }
}



class MyApp1 extends StatelessWidget {
  // final UserModel? userModel;
  // const MyApp1({super.key,  required this.userModel});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
  ChangeNotifierProvider(create: (_) => AuthProvider()),

        ChangeNotifierProvider(create: (_) => FindFood()),
    ],
    child:  MaterialApp(
          useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
        useMaterial3: true,
        scaffoldBackgroundColor: Color(0xffecedf4)
        
        
      ),
      
      // home: FoodHomePage(),
      initialRoute: Router1.foodHomePageRoute,
  onGenerateRoute: Router1.generateRoute,
    ),
    );
  }
}

