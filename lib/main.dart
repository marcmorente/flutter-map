import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Map'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  static LatLng myLocation = new LatLng(42.510720, 1.539041);

  @override
  void initState() {
    super.initState();
    setState(() {
      new LatLng(42.510720, 1.539041);
    });
  }

  _handleTap(LatLng point) {
    setState(() {
      myLocation = point;
      print('myLocation ----> ' + myLocation.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: new FlutterMap(
          options: new MapOptions(
            center: myLocation,
            zoom: 15.0,
            onTap: _handleTap,
          ),
          layers: [
            new TileLayerOptions(
              urlTemplate: "https://api.tiles.mapbox.com/v4/"
                  "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
              additionalOptions: {
                'accessToken':
                    'pk.eyJ1IjoiZXRobmVyb20iLCJhIjoiY2pwYTljMzB4MXRoaDNxbzNjbWJxYWF4aCJ9.ra6rQd5-vvZS7KLJ0Ip5rA',
                'id': 'mapbox.streets'
              },
            ),
            new MarkerLayerOptions(
              markers: [
                new Marker(
                  width: 80.0,
                  height: 80.0,
                  point: myLocation,
                  builder: (ctx) => new Container(
                        child: new FlutterLogo(),
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
