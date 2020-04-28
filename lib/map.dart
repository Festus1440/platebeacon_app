import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'components/map_pin_pill.dart';
import 'models/pin_pill_info.dart';

const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 0;
const LatLng SOURCE_LOCATION = LatLng(42.747932, -71.167889);
const LatLng DEST_LOCATION = LatLng(41.878113, -87.629799);

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}
getUser() {
  FutureOr Function(FirebaseUser value) user;
  FirebaseAuth.instance.currentUser().then(user);
  print(user);
}
class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set<Marker>();

// for my drawn routes on the map
  Set<Polyline> _polyline = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints;
  String googleAPIKey = 'AIzaSyAp9WMYokTxIxuOlphnUT63L2HlLzv6Qck';

  GoogleMapPolyline googleMapPolyline =
      GoogleMapPolyline(apiKey: 'AIzaSyAp9WMYokTxIxuOlphnUT63L2HlLzv6Qck');

  BitmapDescriptor currentLocIcon;
  BitmapDescriptor shelterIcon;
  BitmapDescriptor restaurantIcon;
  // the user's initial location and current location
  // as it moves
  LocationData currentLocation;
  // a reference to the destination location
  LocationData destinationLocation;
  // wrapper around the location API
  Location location;

  @override
  void initState() {
    super.initState();
    init();
    //getUser();
  }

  init() async {
    PermissionStatus _permissionGranted;
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    destinationLocation = LocationData.fromMap({
      "latitude": DEST_LOCATION.latitude,
      "longitude": DEST_LOCATION.longitude
    });
    // create an instance of Location
    location = Location();
    polylinePoints = PolylinePoints();

    // subscribe to changes in the user's location
    // by "listening" to the location's onLocationChanged event
    location.onLocationChanged.listen((LocationData cLoc) {
      // cLoc contains the lat and long of the
      // current user's position in real time,
      // so we're holding on to it
      currentLocation = cLoc;
      //print(cLoc.speed);
      //print(currentLocation);
      updatePinOnMap();
    });
    // set custom marker pins
    setSourceAndDestinationIcons();
    // set the initial location
    setInitialLocation();
  }

  void setSourceAndDestinationIcons() async {
    currentLocIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/current_marker.png');

    shelterIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/shelter_marker.png');

    restaurantIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/rest_marker.png');
  }

  void setInitialLocation() async {
    // set the initial location by pulling the user's
    // current location from the location's getLocation()
    currentLocation = await location.getLocation();

    // hard-coded destination for this example
    destinationLocation = LocationData.fromMap({
      "latitude": DEST_LOCATION.latitude,
      "longitude": DEST_LOCATION.longitude
    });
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(41.878113, -87.629799),
    );
    if (currentLocation != null) {
      currentLocation = currentLocation;
      initialCameraPosition = CameraPosition(
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
      );
    }
    else {
      currentLocation = destinationLocation;
      updatePinOnMap();
      //print(_permissionGranted);
    }
    destinationLocation = LocationData.fromMap({
      "latitude": DEST_LOCATION.latitude,
      "longitude": DEST_LOCATION.longitude
    });
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
              myLocationButtonEnabled: true,
              myLocationEnabled: false,
              compassEnabled: true,
              tiltGesturesEnabled: false,
              markers: _markers,
              polylines: _polyline,
              mapType: MapType.normal,
              initialCameraPosition: initialCameraPosition,
              onMapCreated: (GoogleMapController controller) {
                controller.setMapStyle(Utils.mapStyles);
                _controller.complete(controller);
                destinationLocation = LocationData.fromMap({
                  "latitude": DEST_LOCATION.latitude,
                  "longitude": DEST_LOCATION.longitude
                });
                showPinsOnMap();
              }),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              //color: Colors.blue,
              margin: EdgeInsets.symmetric(vertical: 20.0),
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  SizedBox(width: 10.0),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: _boxes(
                        "https://media.timeout.com/images/105239239/image.jpg",
                        37.329889, -122.034798,
                        "Caring Hands", "Shelter", shelterIcon),
                  ),
                  SizedBox(width: 10.0),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: _boxes(
                        "https://media.timeout.com/images/105239239/image.jpg",
                        37.329817, -122.029888,
                        "We Homeless Bro", "Shelter", shelterIcon),
                  ),
                  SizedBox(width: 10.0),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: _boxes(
                        "https://media.timeout.com/images/105239239/image.jpg",
                        37.329779, -122.027155,
                        "McDonalds", "Restaurant", restaurantIcon),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.grey),
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: (){
                    //show current location
                    _showCurrentLoc(currentLocation.latitude, currentLocation.longitude);
                  },
                  icon: Icon(Icons.my_location),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _boxes(String _image, double lat, double long, String restaurantName, String type, BitmapDescriptor icon) {
    return GestureDetector(
      onTap: () {
        _goToArea(lat, long, restaurantName, type, icon);
      },
      child: Container(
        child: FittedBox(
          child: Material(
            color: Colors.white,
            elevation: 7.0,
            borderRadius: BorderRadius.circular(18.0),
            shadowColor: Color(0x802196F3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(18.0),
                  width: 210,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(_image),
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  //color: Colors.green,
                  padding: EdgeInsets.only(top: 0.0, right: 20.0),
                  //color: Colors.blue,
                  child: myDetailsContainer(restaurantName, type),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget myDetailsContainer(String restaurantName, String type) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Container(
            child: Text(
              restaurantName,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
                ""+type+ " in Chicago, IL",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal),
              )),
        ),
        SizedBox(height: 10.0),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Text(
                  "4.1 ",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18.0,
                  ),
                ),
              ),
              Container(
                child: Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void showPinsOnMap() {
    // get a LatLng for the source location
    // from the LocationData currentLocation object
    var pinPosition =
        LatLng(currentLocation.latitude, currentLocation.longitude);
    // get a LatLng out of the LocationData object
    var destPosition =
        LatLng(destinationLocation.latitude, destinationLocation.longitude);
    // add the initial source location pin
    print(pinPosition);
    _markers.add(Marker(
        markerId: MarkerId('currentLoc'),
        position: pinPosition,
        infoWindow: InfoWindow(title: "My Location"),
        icon: currentLocIcon));
    // destination pin

    // set the route lines on the map from source to destination
    // for more info follow this tutorial
    //setPolyline();
  }

  void setPolyline() async {
    _polyline.add(Polyline(
      polylineId: PolylineId('route1'),
      visible: true,
      width: 4,
      color: Colors.blue,
      points: await googleMapPolyline.getCoordinatesWithLocation(
          origin: LatLng(37.331658, -122.030276),
          destination: LatLng(37.329889, -122.034798),
          mode: RouteMode.driving),
      startCap: Cap.squareCap,
      endCap: Cap.roundCap,
    ));
  }

  void updatePinOnMap() async {
    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation
    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    // do this inside the setState() so Flutter gets notified
    // that a widget update is due
    setState(() {
      // updated position
      var pinPosition =
          LatLng(currentLocation.latitude, currentLocation.longitude);

      // the trick is to remove the marker (by id)
      // and add it again at the updated location
      _markers.removeWhere((m) => m.markerId.value == 'currentLoc');
      _markers.add(Marker(
          markerId: MarkerId('currentLoc'),
          position: pinPosition, //
          infoWindow: InfoWindow(title: "My Location"),// updated position
          icon: currentLocIcon));
    });
  }

  void _goToArea(double lat, double long, String name, String type, BitmapDescriptor icon) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
    )));
    setState(() {
      _markers.removeWhere((m) => m.markerId.value == type);
      _markers.add(Marker(
          markerId: MarkerId(type),
          position: LatLng(lat, long),
          infoWindow: InfoWindow(title: name, snippet: type),
          icon: icon));
    });
  }

  void _showCurrentLoc(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
    )));
    setState(() {
      _markers.removeWhere((m) => m.markerId.value == 'currentLoc');
      _markers.add(Marker(
          markerId: MarkerId('currentLoc'),
          position: LatLng(lat, long),
          icon: currentLocIcon));
    });
  }
}

class Utils {
  static String mapStyles = '''[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]''';
}