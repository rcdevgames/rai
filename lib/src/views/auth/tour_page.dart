import 'package:RAI/src/util/data.dart';
import 'package:RAI/src/util/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';

class TourPage extends StatefulWidget {
  @override
  _TourPageState createState() => _TourPageState();
}

class _TourPageState extends State<TourPage> {
  final _keyTour = GlobalKey<ScaffoldState>();
  bool skipText;
  int currentIndexPage;
  final List<Map<String, String>> listTour = Static.LIST_TOUR;

  @override
  void initState() {
    checkHasTour();
    skipText = false;
    currentIndexPage = 0;
    super.initState();
  }

  checkHasTour() async {
    var hasTour = await sessions.load("tour");
    if (hasTour != null && hasTour == "1") {
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _keyTour,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  // RaisedButton(
                  //   onPressed: () => Navigator.of(context).pushNamed('/term'),
                  //   color: Colors.transparent,
                  //   elevation: 0,
                  //   child: Text("Terms", style: TextStyle(fontWeight: FontWeight.normal, color: Theme.of(context).primaryColor, fontSize: 18)),
                  // ),
                  skipText ? RaisedButton(
                    onPressed: () {
                      sessions.save("tour", "1");
                      Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
                    },
                    color: Colors.transparent,
                    elevation: 0,
                    child: Text("Sign In", style: TextStyle(fontWeight: FontWeight.normal, color: Theme.of(context).primaryColor, fontSize: 18)),
                  ):Container(
                    height: 48,
                  ),
                ],
              ),
            ),
            Center(
              child: SizedBox(
                height: 85,
                width: 85,
                child: SvgPicture.asset('assets/svg/savewise-logo.svg'),
              ),
            ),
            SizedBox(height: 7),
            Text("OneUp.", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: Theme.of(context).primaryColor)),
            Expanded(
              child: CarouselSlider(
                onPageChanged: (i) {
                  if ((i+1) == listTour.length) {
                    setState(() {
                      currentIndexPage = i;
                      skipText = true;
                    });
                  }else{
                    setState(() {
                      currentIndexPage = i;
                      skipText = false;
                    });
                  }
                },
                height: 300.0,
                enableInfiniteScroll: false,
                items: listTour.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 15.0),
                        padding: EdgeInsets.all(20),
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
                            Text(i['description'], style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.white, height: 1.2)),
                          ],
                        )
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: DotsIndicator(
                numberOfDot: listTour.length,
                position: currentIndexPage
              ),
            )
          ],
        )
      ),
    );
  }
}