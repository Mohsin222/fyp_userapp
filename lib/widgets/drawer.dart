import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:page_transition/page_transition.dart';

import 'package:provider/provider.dart';
import 'package:resturant_user_app/components/rate_dialog.dart';
import 'package:resturant_user_app/views/a11.dart';
import 'package:resturant_user_app/views/aboutusScreen.dart';
import 'package:resturant_user_app/views/main_screen.dart';
import 'package:resturant_user_app/views/map.dart';
import 'package:resturant_user_app/views/profile_screen.dart';
import 'package:resturant_user_app/views/ratingScreen.dart';
import 'package:resturant_user_app/views/settings_screen.dart';
import 'package:resturant_user_app/views/tables.dart';
import 'package:resturant_user_app/widgets/dialog.dart';

import '../constants/routes.dart';
import '../providers/auth_provider.dart';
import '../views/onboarding_screen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      // margin: EdgeInsets.symmetric(vertical: 39),
      child: Drawer(
        backgroundColor: Colors.white,
        width: 100,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
        ),
        // backgroundColor: Colors.green[500],

        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Consumer<AuthProvider>(builder: ((context, value, child) {
              return UserAccountsDrawerHeader(
            
                currentAccountPicture: CircleAvatar(
               backgroundColor: Color.fromARGB(255, 16, 151, 86),
                  backgroundImage: NetworkImage(value.logedUser!.profilepic ??
                      'https://images.unsplash.com/photo-1671212041192-443a5a171150?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw5MHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60'),
                ),
                accountEmail: Text(value.logedUser!.email.toString()),
                accountName: Text(
                  value.logedUser!.fullname.toString(),
                  style: TextStyle(fontSize: 24.0),
                ),
                decoration: BoxDecoration(
                  color:       Color.fromARGB(255, 16, 151, 86),
                ),
              );
            })),
            Container(
              padding: EdgeInsets.all(24),
              child: Wrap(
                spacing: 19,
                // runSpacing: 16,
                children: [
                  drawerTile(
                      icon: Icons.table_restaurant,
                      press: () {
                        Navigator.push(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: TablesScreen()));

                        // Navigator.pushNamed(context, Router1.tableScreen);
                      },
                      title: 'Tables'),
                  drawerTile(
                      icon: Icons.home,
                      press: () {
                         Navigator.push(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: ProfileScreen()));

                        // Navigator.pushNamed(context, Router1.profileScreen);
                      },
                      title: 'Profile'),
                  drawerTile(icon: Icons.menu, press: () {
                     Navigator.push(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: AboutUsScreen()));

                    // Navigator.push(context, MaterialPageRoute(builder: (context)=> AboutUsScreen()));
                  }, title: 'About Us'),
                  drawerTile(
                      icon: Icons.album_outlined,
                      press: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => RatingScreen()));
                        Navigator.pop(context);
                        showDialog(context: context, builder: (context)=> ratdialog(context));
                      },
                      title: 'Rate Us'),
                  Divider(),
//Settings
    drawerTile(
                      icon: Icons.settings,
                      press: () {
                         Navigator.push(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: SettingsScreen()));
                  
                      },
                      title: 'Settings'),

                      //maps

                          drawerTile(
                      icon: Icons.directions_car,
                      press: () {
                        MapsLauncher.launchCoordinates(
                    24.914015, 67.106898, 'Shafiq Resturant');
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) {
                        //   return Z11();
                        // }));
                      },
                      title: 'Direction'),

                      //xxxxxxxxxxxxxxxxxxxxxxxxx Settings xxxxxxxxxxxxxxxxxxx
                  //logout
                  drawerTile(
                      icon: Icons.logout,
                      press: () async {
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog1(
                                twobtn: true,
                                btnText: 'Logout',
                                showStatment: 'Are you sure',
                                press: () async {
                                  final authprovider =
                                      Provider.of<AuthProvider>(context,
                                          listen: false);
                                  await FirebaseAuth.instance
                                      .signOut()
                                      .then((value) async {
                                    await AuthProvider.deleteSavedUserData();
                                    authprovider.nullLogedUser();
                                    Navigator.popUntil(
                                        context, (route) => route.isFirst);
                                    Navigator.pushNamed(
                                        context, Router1.homeRoute);
                                  }).catchError((e) {});
                                },
                              );
                            });
                      },
                      title: 'Logout'),

                          //logout xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
              
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  drawerTile(
      {required VoidCallback press,
      required String title,
      required IconData icon}) {
    return Container(
      margin: EdgeInsets.all(3),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        // shape:
        //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        leading: Icon(icon,color:   Colors.green,),
        title: Text(
          title,
          style: TextStyle(fontSize: 20.0),
        ),
        onTap: press,
      ),
    );
  }
}
