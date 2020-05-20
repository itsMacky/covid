import 'dart:convert';

import 'package:covid/pages/countrypage.dart';
import 'package:covid/panels/mostaffectedcountries.dart';
import 'package:covid/panels/worldwidepanel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pie_chart/pie_chart.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _isLoading = false;

  Map worldData;
  fetchWorldWideData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/v2/all');
    // setState(() {
    worldData = json.decode(response.body);
    // });
  }

  List countryData;
  fetchCountryData() async {
    http.Response response =
    await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');
    // setState(() {
    countryData = json.decode(response.body);
    // });
  }

  Future fetchData() async {
    await fetchWorldWideData();
    await fetchCountryData();
    print('Refreshed!!!');
  }

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });

    fetchData().then((_) {
      setState(() {
        _isLoading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000023),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'COVID-19 TRACKER',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: fetchData,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'WORLDWIDE',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CountryPage()));
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)),
                          padding: EdgeInsets.all(6.0),
                          child: Text(
                            'OTHER COUNTRIES',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )),
                    ),
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 30, horizontal: 10),
                  child: PieChart(
                    chartLegendSpacing: 32.0,
                    legendStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    chartRadius: MediaQuery.of(context).size.width / 2.7,
                    chartValueBackgroundColor: Colors.white,
                    chartValueStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    animationDuration: Duration(milliseconds: 800),
                    chartType: ChartType.ring,
                    dataMap: {
                      'CONFIRMED': worldData['cases'].toDouble(),
                      'ACTIVE': worldData['active'].toDouble(),
                      'RECOVERED': worldData['recovered'].toDouble(),
                      'DEATHS': worldData['deaths'].toDouble(),
                    },
                    colorList: [
                      Color(0xffffc400),
                      Color(0xff7a42d5),
                      Colors.green,
                      Colors.red,
                    ],
                  ),
                ),
              ),
              Center(
                  child: WorldwidePanel(
                    worldData: worldData,
                  )),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'MOST AFFECTED COUNTRIES',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: countryData == null
                    ? CircularProgressIndicator()
                    : MostAffectedPanel(
                  countryData: countryData,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Text(
                    'WE ARE TOGETHER IN THIS',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.white),
                  )),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text('Made with ❤️ by Macky ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white)),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
