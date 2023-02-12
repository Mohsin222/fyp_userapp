import 'package:flutter/material.dart';
import 'package:resturant_user_app/auth/signup.dart';
import 'package:resturant_user_app/models/food_item.dart';
import 'package:resturant_user_app/views/contact_us.dart';
import 'package:resturant_user_app/views/food_detailsitem_details_screen.dart';
import 'package:resturant_user_app/views/onboarding_screen.dart';

import '../auth/loginmscreen.dart';
import '../views/food_homepage.dart';

import '../views/home_screen.dart';
import '../views/profile_screen.dart';
import '../views/tables.dart';


class Router1 {
  static const String homeRoute = '/';
  static const String foodHomePageRoute = '/foodHomePage';
  static const String homeScreen = '/HomeScreen';

  static const String profileScreen = '/profileScreen';
    static const String tableScreen = '/tableScreen';
    static const String loginScreen = '/loginScreen';
    static const String signUpScreen = '/signUpScreen';
    static const String contactUsScreen = '/contactUsScreen';


  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case foodHomePageRoute:
        return MaterialPageRoute(builder: (_) => const FoodHomePage());
      case profileScreen:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
           case tableScreen:
        return MaterialPageRoute(builder: (_) => TablesScreen());
                 case loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());

                 case signUpScreen:
        return MaterialPageRoute(builder: (_) => SignupScreen());

                    case contactUsScreen:
        return MaterialPageRoute(builder: (_) => ContactUsScreen());
  
         
    
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
