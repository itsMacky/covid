import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 12,horizontal: 10),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('DONATE',style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.0),),
                Icon(Icons.arrow_forward_ios, color: Colors.black,)
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              launch('https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public/myth-busters');
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12,horizontal: 10),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('MYTH BUSTERS',style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.0),),
                  Icon(Icons.arrow_forward_ios, color: Colors.black,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
