import 'package:flutter/material.dart';
import 'package:rai/src/wigdet/savewise_icons.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _key = GlobalKey<ScaffoldState>();
  final _depositInput = TextEditingController();

  @override
  void initState() {
    _depositInput.text = "0";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _key,
      appBar: AppBar(
        elevation: 0,
        title: Text("Choose deposit"),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.help_outline, color: Colors.white),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 6,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor
            ),
            child: Column(
              children: <Widget>[
                Text("How much do you want to save?", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  height: 65,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {},
                        iconSize: 35,
                        icon: Icon(Icons.remove_circle),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _depositInput,
                          decoration: InputDecoration(
                            prefixText: "£",
                            prefixStyle: TextStyle(fontSize: 25),
                            border: InputBorder.none
                          ),
                          style: TextStyle(fontSize: 35),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          onChanged: (val) {
                            if (val == "") {
                              _depositInput.text = "0";
                            }
                          },
                        )
                      ),
                      IconButton(
                        onPressed: () {},
                        iconSize: 35,
                        icon: Icon(Icons.add_circle),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          // Container(
          //   width: double.infinity,
          //   height: MediaQuery.of(context).size.height / 10,
          //   decoration: BoxDecoration(
          //     color: Colors.black12
          //   ),
          //   child: Row(
          //     children: <Widget>[

          //     ],
          //   ),
          // ),
          
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Savewise.icon_deposit),
            title: Text("Deposits")
          ),
          BottomNavigationBarItem(
            icon: Icon(Savewise.icons8_graph),
            title: Text("Summary")
          ),
          BottomNavigationBarItem(
            icon: Icon(Savewise.icons8_user_female),
            title: Text("Profile")
          ),
        ],
      ),
    );
  }
}