import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../constants/routes.dart';
import '../models/userModel.dart';
import '../widgets/dialog.dart';
import 'auth_provider.dart';

class AddsProvider extends ChangeNotifier{

  bool isloding=false;
  late BannerAd bannerAd;

  AddsProvider(){
    _initBannerAd();
  }


  

  void _initBannerAd(){

    
    bannerAd =BannerAd(
      size: AdSize.banner,
     adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      listener: BannerAdListener(
onAdLoaded: (val){
isloding=true;
notifyListeners();
},
onAdFailedToLoad: (ad,err){}
      ), 
      request: AdRequest());

      bannerAd.load();
      notifyListeners();
  }




@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bannerAd.dispose();
  }




}


