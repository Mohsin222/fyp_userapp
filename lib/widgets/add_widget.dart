import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:resturant_user_app/providers/adds_provider.dart';

class AddWidget extends StatefulWidget {
  const AddWidget({super.key});

  @override
  State<AddWidget> createState() => _AddWidgetState();
}

class _AddWidgetState extends State<AddWidget> {

  
    bool isloding=false;
  late BannerAd bannerAd;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
     _initBannerAd();
  }
  void _initBannerAd(){

    
    bannerAd =BannerAd(
      size: AdSize.banner,
     adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      listener: BannerAdListener(
onAdLoaded: (val){
isloding=true;
setState(() {
  
});
},
onAdFailedToLoad: (ad,err){}
      ), 
      request: AdRequest());

      bannerAd.load();
    setState(() {
      
    });
  }


  @override
  Widget build(BuildContext context) {
    // return Consumer<AddsProvider>(builder: (context, value, child) {
    //     return value.isloding  ? Container(
    //       height: value.bannerAd.size.height.toDouble(),
    //        width: value.bannerAd.size.width.toDouble(),
    //        child: AdWidget(ad: value.bannerAd,),
    //     )
    //     :SizedBox();
    //   },);


         return isloding  ? Container(
          height: bannerAd.size.height.toDouble(),
           width: bannerAd.size.width.toDouble(),
           child: AdWidget(ad: bannerAd,),
        )
        :SizedBox();
  }
}

