import 'package:flutter/material.dart';
import 'package:web_view_polytech/local/shared_pref_helper.dart';


import 'custom_web_view.dart';
import 'home_page.dart';
import 'no_internet.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsHelper.init() ;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'جامعه بوليتكنك فلسطين',
      home: HomePage(),
      routes: {
        CustomWebView.routeName: (context) => CustomWebView(),
        HomePage.routeName: (context) => HomePage(),
        NoInternetScreen.routeName: (context) => NoInternetScreen(),
      },
    );
  }
}
