import 'dart:async';
import './band_entry.dart';
import 'package:flutter/material.dart';
import './details.dart';
import './dbhelper.dart';

void main() => runApp(mScreen());

List<Band> bands_array = [];
List<String> litems = [];

final TextEditingController band_name_controller = new TextEditingController();
final TextEditingController member_name_controller =
    new TextEditingController();
final TextEditingController song_name_controller = new TextEditingController();
final TextEditingController release_year_controller =
    new TextEditingController();

class mScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: DynamicList());
  }
}

class DynamicList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DynamicListState();
  }
}

class _DynamicListState extends State<DynamicList> {
  List<Map<String, dynamic>> _bands = [];
  bool _isLoading = true;

  void _refreshData() async {
    final data = await dbhelper.getItems();
    setState(() {
      _bands = data;
      _isLoading = false;
    });
  }

  void initState() {
    super.initState();
    _refreshData();
    print("...number of items ${_bands.length}");
  }

  @override
  Widget build(BuildContext context) {
    FutureOr onGoBack(dynamic value) {
      setState(() {});
    }

    void navigateToBandEntry() {
      Route route = MaterialPageRoute(builder: (context) => BandEntryForm());
      Navigator.push(context, route).then(onGoBack);
    }

    return MaterialApp(
      home: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: navigateToBandEntry,
            elevation: 8,
            child: Icon(
              Icons.add_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
          body: Container(
            color: Color.fromRGBO(51, 51, 51, 1),
            child: Column(
              children: <Widget>[
                Center(
                  child: Container(
                    padding: EdgeInsets.only(top: 70),
                    child: Image.asset(
                      'assets/app_logo.png',
                      width: 220,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: Divider(
                    thickness: 1.5,
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 20, bottom: 20),
                  child: Text(
                    'Band List',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Gotham',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: bands_array.length,
                        itemBuilder: (BuildContext ctxt, int Index) {
                          return Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      blurRadius: 5,
                                      offset: Offset(5, 5))
                                ]),
                            margin:
                                EdgeInsets.only(left: 15, right: 15, top: 15),
                            child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailsForm(
                                              bands_array[Index], Index)));
                                },
                                leading: Icon(
                                  Icons.headphones,
                                  size: 40,
                                ),
                                title: Text(
                                  bands_array[Index].band_name,
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text(bands_array[Index].genre,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis),
                                trailing: Wrap(children: [
                                  Icon(
                                    Icons.chevron_right,
                                    size: 30,
                                  ),
                                ])),
                          );
                          // return Text(litems[Index]);
                        }))
              ],
            ),
          )),
    );
  }
}
