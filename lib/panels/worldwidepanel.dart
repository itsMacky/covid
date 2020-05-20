import 'package:flutter/material.dart';

class WorldwidePanel extends StatelessWidget {
  final Map worldData;

  const WorldwidePanel({Key key, this.worldData}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 2),
        children: <Widget>[
          StatusPanel(
            title: 'CONFIRMED',
            panelColor: Color(0xff292c4b),
            textColor: Color(0xffffc400),
            count: worldData['cases'].toString(),

          ),
          StatusPanel(
            title: 'ACTIVE',
            panelColor: Color(0xff292c4b),
            textColor: Color(0xff7a42d5),
            count: worldData['active'].toString(),
          ),
          StatusPanel(
            title: 'RECOVERED',
            panelColor: Color(0xff292c4b),
            textColor: Colors.green,
            count: worldData['recovered'].toString(),
          ),
          StatusPanel(
            title: 'DEATHS',
            panelColor: Color(0xff292c4b),
            textColor: Colors.red,
            count: worldData['deaths'].toString(),
          ),
          StatusPanel(
            title: 'TODAY ACTIVE CASES',
            panelColor: Color(0xff292c4b),
            textColor: Colors.blueAccent,
            count: worldData['todayCases'].toString(),
          ),
          StatusPanel(
            title: 'TODAY DEATHS',
            panelColor: Color(0xff292c4b),
            textColor: Colors.deepOrange,
            count: worldData['todayDeaths'].toString(),
          ),
        ],
      ),
    );
  }
}

class StatusPanel extends StatelessWidget {

  final Color panelColor;
  final Color textColor;
  final String title;
  final String count;

  const StatusPanel({Key key, this.panelColor, this.textColor, this.title, this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(5.0),
      height: 80,width: width/2,
      color: panelColor,
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: textColor),),
          Text(count,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: textColor),),
        ],
      ) ,
    );
  }
}
