import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';
//import './screens/trackswidget.dart';
//import 'about_widget.dart';



/*
//GET NOW PLAYING INFO

List<Nplaying> nplayingFromJson(String str) =>
    List<Nplaying>.from(json.decode(str).map((x) => Nplaying.fromJson(x)));

String nplayingToJson(List<Nplaying> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Nplaying {
  Nplaying({
    this.track,
  });

  Track track;

  factory Nplaying.fromJson(Map<String, dynamic> json) => Nplaying(
    track: Track.fromJson(json["track"]),
  );

  Map<String, dynamic> toJson() => {
    "track": track.toJson(),
  };
}

class Track {
  Track({
    this.artist,
    this.title,
    this.imageurl,
    this.url,
    this.type,
  });

  String artist;
  String title;
  String imageurl;
  String url;
  String type;

  factory Track.fromJson(Map<String, dynamic> json) => Track(
    artist: json["artist"],
    title: json["title"],
    imageurl: json["imageurl"],
    url: json["url"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "artist": artist,
    "title": title,
    "imageurl": imageurl,
    "url": url,
    "type": type,
  };
}
/* END NOWPLAYING JSON */
/* TO FETCH NowPlaying */
Future<List<Nplaying>> fetchNowPlaying(http.Client client) async {

  try {
    final response = await client.get('https://api.drn1.com.au:9000/nowplaying/DRN1?uuid=3b9c4e7adf59b4fb');
        if (response.isEmpty) return null;
    Map<String, dynamic> data = json.decode(response);

    List<dynamic> result = data['data'];

    if (result == null) return null;

    List<Nplaying> nplayinglist=
    result.map((f) => Nplaying.fromJson(f)).toList();


    return nplayinglist;

  } catch (e) {
    print(e);
  }

}


class NowPhotosList extends StatelessWidget {
  final Photo photos;
  final uuid;

  NowPhotosList({Key key, this.photos, this.uuid}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        //  childAspectRatio: MediaQuery.of(context).size.width /
        //      (MediaQuery.of(context).size.height / 4), //childAspectRatio: 200,
      ),
      scrollDirection: Axis.horizontal,
      itemCount: photos.data.length,
      itemBuilder: (context, index) {
        return  RaisedButton(
          padding: const EdgeInsets.all(0),
          textColor: Colors.white,
          color: Colors.black,
          onPressed: () async {  print("hello");
          },

          child: CachedNetworkImage(
            imageUrl: photos.data[index].imageurl,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        );
        // return Image.network(photos.data[index].imageurl, width: 80.0, height: 80.0,);
      },
    );
  }
}


*/
//CODE ABOVE DOES NOT WORK AND KEEPS CRASHING THE APP - IT IS A CLONE OF THE CODE BELOW BUT FOR SOME REASON IT WONT LOAD THE JSON NOW PLAYING










//GET STATIONS
/* TO FETCH PHOTOS */
Photo photoFromJson(String str) => Photo.fromJson(json.decode(str));

String photoToJson(Photo data) => json.encode(data.toJson());

class Photo {
  Photo({
    this.data,
  });

  List<Datum> data;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

/*START OF STATIONS JSON*/
class Datum {
  Datum({
    this.id,
    this.name,
    this.imageurl,
    this.website,
    this.listenlive,
  });

  String id;
  String name;
  String imageurl;
  String website;
  String listenlive;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    name: json["name"],
    imageurl: json["imageurl"],
    website: json["website"],
    listenlive: json["listenlive"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "imageurl": imageurl,
    "website": website,
    "listenlive": listenlive,
  };
}
/*END OF STATIONS JSON*/

/* TO FETCH PHOTOS */
Future<Photo> fetchPhotos(http.Client client) async {
/*  final response = await client.get('https://api.drn1.com.au/station/allstations');
  // Use the compute function to run parsePhotos in a separate isolate.
*/
    try {
      final response = await client.get('https://api.drn1.com.au/station/allstations');
      return compute(parsePhotos, response.body);

    } catch (e) {
      print(e);
    }

}

// A function that converts a response body into a List<Photo>.
Photo parsePhotos(String responseBody) {
  return photoFromJson(responseBody);
}

class PhotosList extends StatelessWidget {
  final Photo photos;
  final uuid;
  FlutterRadioPlayer _flutterRadioPlayer = new FlutterRadioPlayer();

  PhotosList({Key key, this.photos, this.uuid}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
      //  childAspectRatio: MediaQuery.of(context).size.width /
      //      (MediaQuery.of(context).size.height / 4), //childAspectRatio: 200,
      ),
      scrollDirection: Axis.horizontal,
      itemCount: photos.data.length,
      itemBuilder: (context, index) {
        return  RaisedButton(
            padding: const EdgeInsets.all(0),
            textColor: Colors.white,
            color: Colors.black,
            onPressed: () async {  await _flutterRadioPlayer.setUrl(photos.data[index].listenlive+'?uuid='+uuid, "true");
            },

          child: CachedNetworkImage(
            imageUrl: photos.data[index].imageurl,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        );
        // return Image.network(photos.data[index].imageurl, width: 80.0, height: 80.0,);
      },
    );
  }
}

/*END FETCH PHOTOS*/








class Home extends StatefulWidget {
  var playerState = FlutterRadioPlayer.flutter_radio_paused;

  var volume = 0.8;

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  String _deviceId = 'Unknown';
 /* Future<Radata> _future;
  Future<Radata> getHttp() async {
    http.Response response =
    await http.get("https://api.drn1.com.au/station/allstations");
    if (response.statusCode == 200) {
      return radataFromJson(response.body);
    }
  }
*/

  bool check = true;
  int _currentIndex = 0;
  FlutterRadioPlayer _flutterRadioPlayer = new FlutterRadioPlayer();

  @override
  void initState() {
   // _future = getHttp();
    initPlatformState();
    initRadioService();
    super.initState();
  }

  Future<void> initPlatformState() async {
    String deviceId;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
    } on PlatformException {
      deviceId = 'Failed to get deviceId.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _deviceId = deviceId;
      print("deviceId->$_deviceId");
    });
  }


  Future<void> initRadioService() async {
    try {
      await _flutterRadioPlayer.init(
          "DRN1", "Live", "http://stream.radiomedia.com.au:8003/stream", "true");
    } on PlatformException {
      print("Exception occurred while trying to register the services.");
    }
    //await _flutterRadioPlayer.play();
  }

  Future<void> changestation(e) async{
    try {
      await _flutterRadioPlayer.setUrl(e, "true");
    //  await _flutterRadioPlayer.play();
    } on PlatformException {
      print("Exception occurred while trying to register the services.");
    }
  }



 /* final List<Widget> _children = [TracksWidget(),
    AboutWidget()];
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('DRN',style: TextStyle(color: Colors.white, fontSize: 40.0),),
              const Text('1', style: TextStyle(color: Colors.red, fontSize: 40.0),)
            ],
        ),
      ),
      //body: _children[_currentIndex],
      body: Column(children: [

       /*
        // Now Playing Information
        SizedBox(
          width: double.infinity,
          height:200,
          child: Container(
            color: Colors.red,
            child:
            FutureBuilder<Photo>(
              future: fetchNowPlaying(http.Client()),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);

                return snapshot.hasData
                    ? Container(child: NowPhotosList(photos: snapshot.data,uuid:_deviceId))
                    : Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),

        // END NOW PLAYING INFORMATION
        CODE TO SHOW THE NOW PLAYING INFORMATION - THIS WONT RUN
        */

        SizedBox(
          width: double.infinity,
          height:40,
          child: Container(
            color: Colors.white,
            child: Text(
              "Our Stations",
              textAlign: TextAlign.left,
              textScaleFactor: 2,
            ),
          ),
        ),


           //START STATIONS
            SizedBox(
            width: double.infinity,
            height:200,
                child: Container(
                color: Colors.red,
                child:
                    FutureBuilder<Photo>(
                        future: fetchPhotos(http.Client()),
                        builder: (context, snapshot) {
                        if (snapshot.hasError) print(snapshot.error);

                        return snapshot.hasData
                        ? Container(child: PhotosList(photos: snapshot.data,uuid:_deviceId))
                            : Center(child: CircularProgressIndicator());
                        },
                    ),
                ),
            ),
        //END STATIONS

        SizedBox(
          width: double.infinity,
          //height:40,
          child: Container(
            color: Colors.white,
            child: Text(
              "\n\nTo all our valued Android Listeners.\n\nWe are working on making our android app better for all, updates will be out over the coming months.\n\nClick on any station icon to tune into the station. If the station does not start playing at time of launching the app, please reboot the app.",
              textAlign: TextAlign.left,
              textScaleFactor: 1,
            ),
          ),
        ),


    ]),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 80.0,
        width: 80.0,
        child: FittedBox(
          child:FloatingActionButton(
                  onPressed: () => {
                    setState((){
                      if(check)
                      {
                        check = false;
                         _flutterRadioPlayer.play();
                        print("false");
                      }
                      else
                      {
                        check = true;
                         _flutterRadioPlayer.pause();
                        print("true");
                      }

                    }),
                    },
         child: Icon(check ? Icons.play_arrow: Icons.pause),
                backgroundColor: Colors.black,
                mini: true,
              ),
        ),

      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          decoration:
          new BoxDecoration(color: new Color(0xFFFF0000)),
          height: 75,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
            /*  IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(left: 28.0),
                icon: Icon(Icons.home),
                onPressed: () {
                  setState(() {

                    onTabTapped(0);
                  });
                },
              ),*/
          /*    IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(right: 28.0),
                icon: Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    onTabTapped(1);
                  });
                },
              ),
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(left: 28.0),
                icon: Icon(Icons.notifications),
                onPressed: () {
                  setState(() {
                    onTabTapped(2);
                  });
                },
              ),*/
             /* IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(right: 28.0),
                icon: Icon(Icons.info_outline),
                onPressed: () {
                  setState(() {
                    onTabTapped(1);
                  });
                },
              )*/
            ],
          ),
        ),
      ),// new

    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}