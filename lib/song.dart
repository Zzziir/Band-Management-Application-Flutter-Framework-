import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'band_entry.dart';
import './main.dart';
import './details.dart';

class Song {
  final String song_name;
  final String release_year;

  Song(this.song_name, this.release_year);
}

class SongEntryForm extends StatefulWidget {
  final int index;
  SongEntryForm(this.index);

  @override
  State<SongEntryForm> createState() => SongEntryFormState(index);
}

class SongEntryFormState extends State<SongEntryForm> {
  final int index;
  SongEntryFormState(this.index);

  String Instrument_dropdownvalue = 'Select Instrument';

  @override
  Widget build(BuildContext context) {
    void submitSong(
        TextEditingController song_name, TextEditingController release_year) {
      setState(() {
        Song song = Song(song_name.text, release_year.text);
        bands_array.elementAt(index).SongList.add(song);
        song_name_controller.clear();
        release_year_controller.clear();
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
                  child: Text('Song Entry'),
                  margin: EdgeInsets.all(15),
                ),
              ]),
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  song_name_controller.clear();
                  release_year_controller.clear();
                  Navigator.pop(context, 'Back');
                },
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              backgroundColor: Colors.green,
              onPressed: () {
                if (song_name_controller.text == "" ||
                    release_year_controller.text == "") {
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
                  submitSong(song_name_controller, release_year_controller);
                }
              },
              elevation: 8,
              label: Text('Save Song'),
              icon: Icon(
                Icons.disc_full,
                color: Colors.white,
                size: 28,
              ),
            ),
            body: Container(
              child: Column(
                children: <Widget>[
                  //Song Name Entry
                  Padding(
                    padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                    child: TextField(
                      controller: song_name_controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Song Name',
                        hintText: 'Enter Song Name',
                      ),
                    ),
                  ),
                  //Release Year Entry
                  Padding(
                    padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                    child: TextField(
                      controller: release_year_controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Release Year',
                        hintText: 'Enter Release Year',
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
