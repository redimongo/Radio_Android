import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class NowPlaying extends StatelessWidget {
  

  final String url = "http://139.59.108.222:2199/rpc/drn1/streaminfo.get";
  List data;

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width;

    return new Container (
      padding: const EdgeInsets.all(16.0),
      width: c_width,
      child: new SingleChildScrollView(
        child: new Column (
          children: <Widget>[
            Row(
              children: <Widget>[
                new Text('DRN',style: TextStyle(color: Colors.black, fontSize: 20.0),),
                new Text('1', style: TextStyle(color: Colors.red, fontSize: 20.0),),
                new Text(': Now Playing',style: TextStyle(color: Colors.black, fontSize: 20.0),)

              ],
            ),
            Column (
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text ("When it comes to listening to music in this digital world there are so many ways to do it, either via YouTube, iTunes, Spotify, Google Music or the old fashioned Radio, where you get the commercial artists forced at you over and over again.", textAlign: TextAlign.left),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text ("DRN1 is different. We are proud to show real talent, and artists that listeners may never of heard before but will quickly fall in love with. Sure, the music might not get publicised by major labels, and may not have the budget to get old styled radio stations playing. But, why should music come down to how much money you can throw at an artist just to hope that the listeners will end up buying said track or album?", textAlign: TextAlign.left),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}