import 'package:flutter/material.dart';
import 'package:web_view_polytech/home_page.dart';

class NoInternetScreen extends StatelessWidget {
  static const routeName = '/NoInternetScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset('images/noconnection.jpg'),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(15),
              ),
              child: FlatButton(
                onPressed: ()=>Navigator.pushReplacementNamed(context, HomePage.routeName) ,
                child: Column(
                  children: [
                    Icon(Icons.wifi_protected_setup,size: 50,color: Colors.white,),
                    Text('Reload',style: TextStyle(color: Colors.white,fontSize: 17),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
