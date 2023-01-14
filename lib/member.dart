import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'band_entry.dart';
import './main.dart';
import './details.dart';

class Member {
  final String member_name;
  final String instrument;

  Member(this.member_name, this.instrument);
}

class MemberEntryForm extends StatefulWidget {
  final int index;
  MemberEntryForm(this.index);

  @override
  State<MemberEntryForm> createState() => MemberEntryFormState(index);
}

class MemberEntryFormState extends State<MemberEntryForm> {
  final int index;
  MemberEntryFormState(this.index);

  String Instrument_dropdownvalue = 'Select Instrument';

  // List of items in our dropdown menu
  var Instrument_items = [
    'Select Instrument',
    'Vocal',
    'Guitar',
    'Bass',
    'Keyboard',
    'Drums',
  ];

  @override
  Widget build(BuildContext context) {
    void submitMember(
        TextEditingController member_name, String Instrument_dropdownvalue) {
      setState(() {
        Member member = Member(member_name.text, Instrument_dropdownvalue);
        bands_array.elementAt(index).MemberList.add(member);
        member_name_controller.clear();
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
                  child: Text('Member Entry'),
                  margin: EdgeInsets.all(15),
                ),
              ]),
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  // Close the screen and return "Yep!" as the result.
                  member_name_controller.clear();
                  Instrument_dropdownvalue = 'Select Instrument';
                  Navigator.pop(context, 'Yep!');
                },
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              backgroundColor: Colors.green,
              onPressed: () {
                if (member_name_controller.text == "" ||
                    Instrument_dropdownvalue == 'Select Instrument') {
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
                  submitMember(
                      member_name_controller, Instrument_dropdownvalue);
                }
              },
              elevation: 8,
              label: Text('Save Member'),
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
                      controller: member_name_controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Member Name',
                        hintText: 'Enter Member Name',
                      ),
                    ),
                  ),
                  //GENRE DROPDOWN BUTTON
                  Card(
                    margin: EdgeInsets.only(
                        top: 15, bottom: 20, left: 20, right: 20),
                    child: ListTile(
                      title: Text("Instrument"),
                      leading: Icon(Icons.music_note),
                      contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      trailing: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isExpanded: false,
                          value: Instrument_dropdownvalue,
                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: Instrument_items.map((String items) {
                            return DropdownMenuItem(
                              child: Text(items),
                              value: items,
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              Instrument_dropdownvalue = newValue!;
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
