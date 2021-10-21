import 'dart:convert';
import 'package:covid19/api/Covid19Tracker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:bezier_chart/bezier_chart.dart';

class CovidTracker extends StatefulWidget {
  const CovidTracker({Key key}) : super(key: key);

  @override
  _CovidTrackerState createState() => _CovidTrackerState();
}

class _CovidTrackerState extends State<CovidTracker> {
  int currentIndex = 0;
  int index = 0;
  Future<List<Covid19Tracker>> covid;
  @override
  void initState() {
    super.initState();
    covid = fetchData();
    currentIndex++;
  }

  Future<List<Covid19Tracker>> fetchData() async {
    final response = await http.get(Uri.parse('https://doh.saal.ai/api/live'),
        headers: {"accept": "application/json"});

    if (response.statusCode == 200) {
      return parseData(response.body);
    } else {
      throw Exception("unable to fetch rest api");
    }
  }

  List<Covid19Tracker> parseData(String responseBody) {
    List<Covid19Tracker> covid = new List();
    Map<String, dynamic> maps = json.decode(responseBody);
    for (int i = 0; i < maps.length; i++) {
      covid.add(Covid19Tracker.fromJson(maps));
    }
    return covid;
  }

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: Text("Covid-19 Tracker"),
        actions: [
          IconButton(icon: Icon(Icons.notifications), onPressed: () {})
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: <Widget>[
            UserAccountsDrawerHeader(
              margin: EdgeInsets.only(bottom: 0),
              accountEmail: Text("swarajya888@gmail.com"),
              accountName: Text("Sunil Shedge"),
              currentAccountPicture: CircleAvatar(
                child: Text("S"),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home_outlined,
                color: Colors.black,
              ),
              title: Text("Home"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              title: Text("Settings"),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CarouselSlider(
              items: [
                Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.asset("asset/1.jpg", fit: BoxFit.cover)),
                Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.asset("asset/2.png", fit: BoxFit.cover)),
                Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.asset("asset/3.jpg", fit: BoxFit.cover)),
                ClipRRect(
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.asset("asset/4.png", fit: BoxFit.cover)),
                ),
                Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.asset("asset/5.jpg", fit: BoxFit.cover)),
              ],
              aspectRatio: 16 / 4,
              autoPlay: true,
              scrollDirection: Axis.horizontal,
              onPageChanged: (int index) {
                setState(() {
                  index++;
                });
              },
              enlargeCenterPage: true,
              pauseAutoPlayOnTouch: Duration(seconds: 5),
              height: 250,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text(
                    "Statistics",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Flexible(
                flex: 1,
                child: FutureBuilder<List<Covid19Tracker>>(
                  future: covid,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return orientation == Orientation.portrait
                          ? gridView(snapshot.data, index, orientation)
                          : gridView(snapshot.data, index, orientation);
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                )),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text("Charts", style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
            bezierChart(covid, currentIndex),
            /* FutureBuilder<List<Covid19Tracker>>(
                future: covid,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return bezierChart(snapshot.data);
                  }
                  return CircularProgressIndicator();
                }), */
          ],
        ),
      ),
    );
  }
}

Widget gridView(List<Covid19Tracker> data, int index, Orientation orientation) {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Card(
      child: DataTable(
        columnSpacing: 40,
        columns: [
          DataColumn(label: Text("Country")),
          DataColumn(label: Text("A"), tooltip: "Active"),
          DataColumn(label: Text("C"), tooltip: "Confirmed"),
          DataColumn(label: Text("D"), tooltip: "Deaths"),
        ],
        rows: data
            .map((e) => DataRow.byIndex(index: index++, cells: [
                  DataCell(Text("${e.countries[index].country}")),
                  DataCell(Text("${e.countries[index].active}")),
                  DataCell(Text("${e.countries[index].confirmed}")),
                  DataCell(Text("${e.countries[index].deaths}")),
                ]))
            .toList(),
      ),
    ),
  );
}

Widget bezierChart(Future<List<Covid19Tracker>> data, int curentIndex) {
  return FutureBuilder<List<Covid19Tracker>>(
      future: data,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Flexible(
            flex: 1,
            child: BezierChart(
              bezierChartScale: BezierChartScale.CUSTOM,
              xAxisCustomValues: [0, 10, 20, 30, 40, 50, 60, 70, 80, 90],
              config: BezierChartConfig(
                startYAxisFromNonZeroValue: false,
                bubbleIndicatorColor: Colors.white.withOpacity(0.9),
                footerHeight: 40,
                verticalIndicatorStrokeWidth: 3.0,
                verticalIndicatorColor: Colors.black26,
                showVerticalIndicator: true,
                verticalIndicatorFixedPosition: false,
                displayYAxis: true,
                stepsYAxis: 10,
                backgroundGradient: LinearGradient(
                  colors: [
                    Colors.red[300],
                    Colors.red[400],
                    Colors.red[400],
                    Colors.red[500],
                    Colors.red,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                snap: true,
              ),
              series: [
                BezierLine(
                    lineColor: Colors.black,
                    data: snapshot.data
                        .map((e) => DataPoint(
                            value: snapshot.data[curentIndex].active.toDouble(),
                            xAxis: snapshot.data[curentIndex].date))
                        .toList()),
              ],
            ),
          );
        }
        return CircularProgressIndicator();
      });
}
