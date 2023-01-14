import 'dart:async';
import './song.dart';
import 'package:flutter/material.dart';
import './main.dart';
import './band_entry.dart';
import './member.dart';

class DetailsForm extends StatefulWidget {
  final Band band;
  final int index;
  DetailsForm(this.band, this.index);

  @override
  State<DetailsForm> createState() => DetailsFormState(band, index);
}

class DetailsFormState extends State<DetailsForm> {
  final Band band;
  final int index;
  DetailsFormState(this.band, this.index);

  String setGenreImage() {
    String genreImage = band.genre;
    switch (band.genre) {
      case 'Pop':
        genreImage = 'assets/pop_music_img.png';
        break;
      case 'R&B':
        genreImage = 'assets/r_and_b_img.png';
        break;
      case 'Rock':
        genreImage = 'assets/rock_music.png';
        break;
      case 'Indie':
        genreImage = 'assets/indie_music_img.png';
        break;
      case 'Funk':
        genreImage = 'assets/funk_music_img.png';
    }
    return genreImage;
  }

  String setInstrumentImage(Member member) {
    String instrumentImage = member.instrument;
    switch (member.instrument) {
      case 'Vocal':
        instrumentImage = 'assets/vocals_logo.png';
        break;
      case 'Guitar':
        instrumentImage = 'assets/guitar_icon.png';
        break;
      case 'Bass':
        instrumentImage = 'assets/bass_logo.png';
        break;
      case 'Keyboard':
        instrumentImage = 'assets/keyboard_logo.png';
        break;
      case 'Drums':
        instrumentImage = 'assets/drums_logo.png';
    }
    return instrumentImage;
  }

//For Testing
  // void addMember() {
  //   setState(() {
  //     Member member = Member('member name', 'gitaris');
  //     band.MemberList.add(member);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    FutureOr onGoBack(dynamic value) {
      setState(() {});
    }

    void navigateToMemberEntry() {
      Route route =
          MaterialPageRoute(builder: (context) => MemberEntryForm(index));
      Navigator.push(context, route).then(onGoBack);
    }

    void navigateToSongEntry() {
      Route route =
          MaterialPageRoute(builder: (context) => SongEntryForm(index));
      Navigator.push(context, route).then(onGoBack);
    }

    void deleteMember(int memberIndex) {
      setState(() {
        bands_array.elementAt(index).MemberList.removeAt(memberIndex);
      });
    }

    void deleteSong(int memberIndex) {
      setState(() {
        bands_array.elementAt(index).SongList.removeAt(memberIndex);
      });
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(51, 51, 51, 1),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(32, 32, 32, 1),
        title: const Text('Band Details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Close the screen and return "Yep!" as the result.
            Navigator.pop(context, 'Yep!');
          },
        ),
      ),
      body: Container(
        color: Color.fromRGBO(51, 51, 51, 1),
        margin: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Expanded(
                child: ListView(children: <Widget>[
              //Band Name Label
              Text(
                band.band_name,
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                    color: Colors.white),
              ),
              //Genre Image
              Container(
                width: double.infinity,
                height: 320,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 5,
                          offset: Offset(5, 5))
                    ],
                    image: DecorationImage(
                        fit: BoxFit.fill, image: AssetImage(setGenreImage())),
                    borderRadius: BorderRadius.all((Radius.circular(15)))),
              ),
              //Members Label
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 15),
                child: Row(
                  children: [
                    //MEMBERS LABEL
                    Text(
                      'Members',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //BUTTON
                    Container(
                      width: 80,
                      height: 20,
                      margin: EdgeInsets.only(left: 15),
                      child: ElevatedButton(
                        onPressed: (() => navigateToMemberEntry()),
                        child: Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              //Band Member List
              Column(
                children: <Widget>[
                  for (var i in band.MemberList)
                    Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 179, 179, 179),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 15),
                      child: ListTile(
                          onTap: null,
                          title: Text(
                            i.member_name,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(i.instrument),
                          leading: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image:
                                          AssetImage(setInstrumentImage(i))))),
                          //Delete Button
                          trailing: ElevatedButton(
                              onPressed: () =>
                                  deleteMember(band.MemberList.indexOf(i)),
                              child: Icon(
                                Icons.delete,
                                color: Colors.black,
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 179, 179, 179)))),
                    )
                ],
              ),
              //Songs List
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 15),
                child: Row(
                  children: [
                    //Song Label
                    Text(
                      'Songs',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //ADD SONG BUTTON
                    Container(
                      width: 80,
                      height: 20,
                      margin: EdgeInsets.only(left: 15),
                      child: ElevatedButton(
                        onPressed: (() => navigateToSongEntry()),
                        child: Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              //Song List
              Column(
                children: <Widget>[
                  for (var i in band.SongList)
                    Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 179, 179, 179),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 15),
                      child: ListTile(
                          onTap: null,
                          title: Text(
                            i.song_name,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(i.release_year),
                          //Delete Button
                          trailing: ElevatedButton(
                              onPressed: () =>
                                  deleteSong(band.SongList.indexOf(i)),
                              child: Icon(
                                Icons.delete,
                                color: Colors.black,
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 179, 179, 179)))),
                    )
                ],
              ),
            ]))
          ],
        ),
      ),
    );
  }
}
