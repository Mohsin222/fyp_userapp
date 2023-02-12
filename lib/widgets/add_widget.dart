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
  @override
  Widget build(BuildContext context) {
    return Consumer<AddsProvider>(builder: (context, value, child) {
        return value.isloding  ? Container(
          height: value.bannerAd.size.height.toDouble(),
           width: value.bannerAd.size.width.toDouble(),
           child: AdWidget(ad: value.bannerAd,),
        )
        :SizedBox();
      },);
  }
}

