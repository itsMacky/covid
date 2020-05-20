import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List countryData;
  fetchCountryData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries');
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    fetchCountryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000023),
      appBar: AppBar(
        title: Text('Country Stats'),
        backgroundColor: Colors.black,
      ),
      body: countryData==null?Center(child: CircularProgressIndicator(),):ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            height: 130,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(color: Color(0xff292c4b), boxShadow: [
              BoxShadow(color: Colors.grey[100],blurRadius:0,),

            ]),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(countryData[index]['country'],style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                      Image.network(countryData[index]['countryInfo']['flag'],height: 50,width: 60,),
                    ],
                  ) ,
                ),
                Expanded(child: Container(

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('CONFIRMED:'+ countryData[index]['cases'].toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
                      Text('ACTIVE:'+ countryData[index]['active'].toString(), style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueAccent),),
                      Text('RECOVERED:'+ countryData[index]['recovered'].toString(), style:  TextStyle(fontWeight: FontWeight.bold, color: Colors.green),),
                      Text('DEATHS:'+ countryData[index]['deaths'].toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),),
                    ],
                  ),

                ),),
              ],
            ),
          );
        },
        itemCount: countryData == null ? 0 : countryData.length,
      ),
    );
  }
}
