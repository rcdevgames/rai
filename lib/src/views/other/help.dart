import 'package:RAI/src/util/data.dart';
import 'package:RAI/src/views/other/help_detail.dart';
import 'package:RAI/src/wigdet/appbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var style = TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor, fontSize: 15);
    var styleChild = TextStyle(color: Theme.of(context).primaryColor, fontSize: 15, height: 1.3);
    return Scaffold(
      key: _key,
      appBar: OneupBar("Help"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text("How Does it work?", style: style),
            ),
            CarouselSlider(
              viewportFraction: 0.9,
              height: MediaQuery.of(context).size.height / 2.3,
              enableInfiniteScroll: false,
              items: Static.LIST_TOUR.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 15.0),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white
                            ),
                            child: Center(
                              child: Text(i['title'], style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(i['description'], style: TextStyle(fontSize: (MediaQuery.of(context).size.width / 1080) * 65, fontWeight: FontWeight.bold, color: Colors.white, height: 1.3)),
                        ],
                      )
                    );
                  },
                );
              }).toList(),
            ),
          ]..addAll(Static.LIST_HELP.map((v) {
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(v.categoryName, style: style),
                  ),
                ]..addAll(v.articles.map((i) {
                  return InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => HelpDetailPage(v.categoryName, i))),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(15, 15, 0, 15),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1, color: Theme.of(context).primaryColor.withOpacity(0.3)))
                      ),
                      child: Text(i.title, style: styleChild),
                    ),
                  );
                }).toList()),
              ),
            );
          }).toList()),
        ),
      ),
    );
  }
}