import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/track.dart';

class TracksWidget extends StatefulWidget {
  @override
  _TracksWidgetState createState() => _TracksWidgetState();
}

class _TracksWidgetState extends State<TracksWidget> {
  Timer timer;


  Future<Track> track;

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width;
    return new FutureBuilder<Track>(
      future: track,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Track track = snapshot.data;
          return new Container(
            decoration:
            new BoxDecoration(color: new Color(0xFF434547)),
              padding: const EdgeInsets.all(16.0),
              width: c_width,
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Text('NOW ',style: TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold)),
                        new Text('PLAYING', style: TextStyle(color: Colors.red, fontSize: 50.0, fontWeight: FontWeight.bold)),
                      ],
                    ),
                        Image.network(track.imageurl, width:200.0, height: 200.0,fit: BoxFit.cover),
                        Text(track.title, style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold)),
                        Text(track.artist, style: TextStyle(color: Colors.red, fontSize: 18.0, fontWeight: FontWeight.bold))
              ]),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        //By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    timer = new Timer.periodic(Duration(seconds: 5), (Timer t) => addValue());
  }

  void addValue() {
    setState(() {
      track = fetchTrack();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }


  Future<Track> fetchTrack() async {
    final response =
        await http.get('http://139.59.108.222:2199/rpc/drn1/streaminfo.get');

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      var responseJson = json.decode(response.body);
      // assume there is only one track to display
      // SO question mentioned 'display current track'
      var track = responseJson['data']
          .map((musicFileJson) => Track.fromJson(musicFileJson['track']))
          .first;
      return track;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
