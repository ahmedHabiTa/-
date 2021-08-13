import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:web_view_polytech/constants/cutom_google_drive_lanucher.dart';
import 'package:web_view_polytech/custom_web_view.dart';
import 'package:web_view_polytech/local/shared_pref_helper.dart';
import 'package:web_view_polytech/no_internet.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/HomePage';

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {

    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            width: deviceWidth,
            height: deviceHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.green[300], Colors.red[300], Colors.blue[900]],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left :10.0 ,right: 10),
                  child: customTopCard(),
                ),
                Container(
                  width: 300,
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    children: [
                      customGridCard(
                          initialUrl: 'https://reg.ppu.edu/',
                          imageAsset: 'images/polytechlogo.png',
                          title: 'البوابه الالكترونيه'),
                      customGridCard(
                          initialUrl: 'https://mail.google.com/mail',
                          imageAsset: 'images/Gmail-logo.png',
                          title: 'Gmail\nجيميل'),
                      customGridCard(
                          initialUrl: 'https://eclass.ppu.edu/',
                          imageAsset: 'images/e-learn.png',
                          title: 'ايكلاس'),
                      CustomGoogleDriveLauncher(),
                      customGridCard(
                          initialUrl: 'https://classroom.google.com/',
                          imageAsset: 'images/classroom.png',
                          title: 'كلاس رووم'),
                      customGridCard(
                          initialUrl: 'https://eservices.iqrad.edu.ps/',
                          imageAsset: 'images/eqrad.jpg',
                          title: 'اقراض'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget customGridCard({
    String initialUrl,
    String imageAsset,
    String title,
  }) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () async {
              var connectivityResult = await (Connectivity().checkConnectivity());
              if (connectivityResult == ConnectivityResult.none) {
                return Navigator.of(context).pushReplacementNamed(NoInternetScreen.routeName);
              } else {
                return await Navigator.of(context)
                    .pushNamed(CustomWebView.routeName, arguments: initialUrl).then((value){
                  SharedPrefsHelper.saveData(key: 'initialUrl', value: initialUrl);
                });

              }
          },
          child: Container(
            height: deviceHeight * 0.2,
            width: deviceWidth * 0.38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.purple[200], Colors.purple[100]],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imageAsset,
                  height: 80,
                ),
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),


          ),
        ),
      ),
    );
  }
  Widget customTopCard() {
    var deviceHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: 16),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () async {
            var connectivityResult = await (Connectivity().checkConnectivity());
            if (connectivityResult == ConnectivityResult.none) {
              return Navigator.of(context).pushReplacementNamed(NoInternetScreen.routeName);
            } else {
              return await Navigator.of(context).pushNamed(CustomWebView.routeName,
                  arguments: 'https://dar.ppu.edu/ar/programs');
            }

          },
          child: Container(
            //height: deviceHeight * 0.25,
            // width: deviceWidth * 0.85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.purple[200], Colors.purple[100]],
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'التخصصات',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text(
                          'عرض جميع التخصصات التي\nتحويها جامعه بوليتكنك فلسطين',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Image.asset(
                    'images/polytechlogo.png',
                    height: deviceHeight * 0.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
