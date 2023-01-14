import 'package:flutter/material.dart';
import './main.dart';
import './member.dart';
import './song.dart';

class Band {
  final String band_name;
  final String genre;
  List<Member> MemberList = [];
  List<Song> SongList = [];

  Band(this.band_name, this.genre);
}

class BandEntryForm extends StatefulWidget {
  const BandEntryForm({super.key});

  @override
  State<BandEntryForm> createState() => BandEntryForm_State();
}

class BandEntryForm_State extends State<BandEntryForm> {
  // Initial Selected Value
  String dropdownvalue = 'Select Genre';

  // List of items in our dropdown menu
  var items = [
    'Select Genre',
    'Pop',
    'R&B',
    'Rock',
    'Indie',
    'Funk',
  ];

  @override
  Widget build(BuildContext context) {
    void submitBand(TextEditingController band_name, String dropdownValue) {
      setState(() {
        Band band = Band(band_name.text, dropdownValue);
        bands_array.add(band);
        band_name_controller.clear();
      });
      Navigator.pop(context, 'Back');
    }

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(51, 51, 51, 1),
              title: Row(children: [
                Image.asset(
                  'assets/logo_circle.png',
                  width: 30,
                ),
                Container(
                  child: Text('Band Entry'),
                  margin: EdgeInsets.all(15),
                ),
              ]),
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  // Close the screen and return "Yep!" as the result.
                  band_name_controller.clear();
                  dropdownvalue = 'Select Genre';
                  Navigator.pop(context, 'Yep!');
                },
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              backgroundColor: Colors.green,
              onPressed: () {
                if (band_name_controller.text == "" ||
                    dropdownvalue == 'Select Genre') {
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                              title: const Text('Missing Entries'),
                              content: const Text(
                                  'Please fill out the remaining details'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ]));
                } else {
                  submitBand(band_name_controller, dropdownvalue);
                }
              },
              elevation: 8,
              label: Text('Save'),
              icon: Icon(
                Icons.save,
                color: Colors.white,
                size: 28,
              ),
            ),
            body: Container(
              child: Column(
                children: <Widget>[
                  //Band Name Entry
                  Padding(
                    padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                    child: TextField(
                      controller: band_name_controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Band Name',
                        hintText: 'Enter Band Name',
                      ),
                    ),
                  ),
                  //GENRE DROPDOWN BUTTON
                  Card(
                    margin: EdgeInsets.only(
                        top: 15, bottom: 20, left: 20, right: 20),
                    child: ListTile(
                      title: Text("Genre"),
                      leading: Icon(Icons.music_note),
                      contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      trailing: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isExpanded: false,
                          value: dropdownvalue,
                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              child: Text(items),
                              value: items,
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
