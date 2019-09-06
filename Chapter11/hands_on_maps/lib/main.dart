import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Map demo',
      home: MapPage(),
    );
  }
}

class MapPage extends StatefulWidget {
  MapPage({Key key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng _cameraCenter;
  GoogleMapController _mapController;
  static final _stonehengePosition = LatLng(51.178883, -1.826215);
  static final _collosseumPosition = LatLng(41.890209, 12.492231);
  static final _grandCanyonPosition = LatLng(36.106964, -112.112999);

  final _markers = {
    Marker(
        position: _stonehengePosition,
        markerId: MarkerId('1'),
        infoWindow: InfoWindow(title: 'Stonehenge'),
        icon: BitmapDescriptor.defaultMarker),
    Marker(
        position: _collosseumPosition,
        markerId: MarkerId('2'),
        infoWindow: InfoWindow(title: 'Colosseum'),
        icon: BitmapDescriptor.defaultMarker),
    Marker(
        position: _grandCanyonPosition,
        markerId: MarkerId('3'),
        infoWindow: InfoWindow(title: 'Grand Canyon'),
        icon: BitmapDescriptor.defaultMarker),
  };

  GoogleMapsPlaces _googleMapsPlaces;

  @override
  void initState() {
    super.initState();

    _googleMapsPlaces = GoogleMapsPlaces(
      apiKey: 'YOUR_PLACES_API_KEY',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(51.178883, -1.826215),
              zoom: 10.0,
            ),
            markers: _markers,
            compassEnabled: true,
            onCameraMove: _cameraMove,
            onMapCreated: (controller) {
              _mapController = controller;
            },
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton(
                    child: Text("Stonehenge"),
                    onPressed: () {
                      _animateMapCameraTo(_stonehengePosition);
                    },
                  ),
                  RaisedButton(
                    child: Text("Colosseum"),
                    onPressed: () {
                      _animateMapCameraTo(_collosseumPosition);
                    },
                  ),
                  RaisedButton(
                    child: Text("Grand Canyon"),
                    onPressed: () {
                      _animateMapCameraTo(_grandCanyonPosition);
                    },
                  ),
                ],
              ),
              padding: EdgeInsets.all(30.0),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addMarkerOnCameraCenter,
        icon: Icon(Icons.add_location),
        label: Text("Place marker"),
      ),
    );
  }

  void _cameraMove(CameraPosition position) {
    _cameraCenter = position.target;
  }

  void _addMarkerOnCameraCenter() async {
    final places = await _queryLatLngNearbyPlaces(_cameraCenter);
    final firstMatchName =
        places.results.length > 0 ? places.results.first.name : "";

    setState(() {
      _markers.add(Marker(
        markerId: MarkerId("${_markers.length + 1}"),
        infoWindow: InfoWindow(
          title: "Added marker - $firstMatchName"
        ),
        icon: BitmapDescriptor.defaultMarker,
        position: _cameraCenter,
      ));
    });
  }

  void _animateMapCameraTo(LatLng position) {
    _mapController.animateCamera(CameraUpdate.newLatLng(position));
  }

  Future<PlacesSearchResponse> _queryLatLngNearbyPlaces(LatLng position) async {
    return await _googleMapsPlaces.searchNearbyWithRadius(
      Location(position.latitude, position.longitude),
      1000,
    );
  }
}
