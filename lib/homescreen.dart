import 'package:flutter/material.dart';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:searchwith7000items/usermodel.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<User> _list = [];
  List<User> _search = [];
  var loading = false;

  Future<Null> fetchData() async {
    setState(() {
      loading = true;
    });
    _list.clear();
    final response = await http.get("https://cmfiflutterapp.s3-ap-southeast-2.amazonaws.com/UnreachedPeoplesGroup.json");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map i in data) {
          _list.add(User.fromJson(i));
          loading = false;
        }
      });
    }
  }

  TextEditingController controller = new TextEditingController();

  onSearch(String text) async {
    _search.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _list.forEach((f) {
      if (f.ctry.contains(text) || f.peopnameincountry.toString().contains(text)) _search.add(f);
    });

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              color: Colors.blue,
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.search),
                  title: TextField(
                    controller: controller,
                    onChanged: onSearch,
                    decoration: InputDecoration(
                        hintText: "Search", border: InputBorder.none),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      controller.clear();
                      onSearch('');
                    },
                    icon: Icon(Icons.cancel),
                  ),
                ),
              ),
            ),
            loading
                ? Center(
              heightFactor: 20.0,
              child: FadingText('Loading...'),
            )
                : Expanded(
              child: _search.length != 0 || controller.text.isNotEmpty
                  ? ListView.builder(
                itemCount: _search.length,
                itemBuilder: (context, i) {
                  final b = _search[i];
                  return GestureDetector(
                    onTap: () {
//                      Navigator.push(
//                          context,
//                          new MaterialPageRoute(
//                              builder: (context) =>
//                                  DetailPage(_search[i])));
                      debugPrint('TopNav');
                    },
                    child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              b.ctry,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(b.peopnameincountry),
                          ],
                        )),
                  );
                },
              )
                  : ListView.builder(
                itemCount: _list.length,
                itemBuilder: (context, i) {
                  final a = _list[i];
                  return GestureDetector(
                    onTap: () {
//                      Navigator.push(
//                          context,
//                          new MaterialPageRoute(
//                              builder: (context) =>
//                                  DetailPage(_list[i])));
                      debugPrint('BottomNav');
                    },
                    child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              a.ctry,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(a.peopnameincountry),
                          ],
                        )
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}