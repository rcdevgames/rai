import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';

class TourPage extends StatelessWidget {
  final _key = GlobalKey<ScaffoldState>();
  final List<Map<String, String>> listTour = [
    {
      'title': '1',
      'description': 'Welcome to SAVEWISE, we can help you save better with more flexibility.',
      // 'imgSrc': 'css/images/dashboard_image@2x.png',
      'color': '#4493cd'
    },
    {
      'title': '2',
      'description': 'Decide the amount you\'d like to save.',
      // 'imgSrc': 'css/images/maps_image@2x.png',
      'color': '#FFD603'
    },
    {
      'title': '3',
      'description': 'Choose the deposit that\'s best for you.',
      // 'imgSrc': 'css/images/incidents_image@2x.png',
      'color': '#E5003E'
    },
    {
      'title': '4',
      'description': 'Watch your savings grow to maturity.',
      // 'imgSrc': 'css/images/customers_image@2x.png',
      'color': '#009636'
    },
    {
      'title': '5',
      'description': 'Need your money back early? Explore our Early Exit options.',
      // 'imgSrc': 'css/images/customers_image@2x.png',
      'color': '#009636'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              SizedBox(height: 50),
              Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: SvgPicture.asset('assets/svg/savewise-logo.svg'),
                ),
              ),
              SizedBox(height: 30),
              Text("SAVEWISE", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
              Expanded(
                child: CarouselSlider(
                  height: 300.0,
                  enableInfiniteScroll: false,
                  items: listTour.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 15.0),
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
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
                              Text(i['description'], style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.white)),
                            ],
                          )
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton(
                    onPressed: (){},
                    color: Colors.transparent,
                    elevation: 0,
                    child: Text("Terms", style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor, fontSize: 18)),
                  ),
                  RaisedButton(
                    onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false),
                    color: Colors.transparent,
                    elevation: 0,
                    child: Text("Skip", style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor, fontSize: 18)),
                  ),
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}