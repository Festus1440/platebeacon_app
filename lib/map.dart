//import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:flutter/services.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import 'map_request.dart';

const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 0;
const LatLng SOURCE_LOCATION = LatLng(42.747932, -71.167889); //ignore
const LatLng DEST_LOCATION = LatLng(41.878113, -87.629799);

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Color mainColor;
  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {}; // initialise a list of markers
  final Set<Polyline> polyLines = {};
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  Set<Polyline> get _polyLines => polyLines;
  List<LatLng> routeCords;
  GoogleMapPolyline googleMapPolyline =
      new GoogleMapPolyline(apiKey: "AIzaSyAp9WMYokTxIxuOlphnUT63L2HlLzv6Qck");
  String googleAPiKey = "AIzaSyAp9WMYokTxIxuOlphnUT63L2HlLzv6Qck";
  BitmapDescriptor currentLocIcon; // initialise custom markers
  BitmapDescriptor shelterIcon; // ""
  BitmapDescriptor restaurantIcon; // ""
  LocationData currentLocation; // important for setting current location
  LocationData destinationLocation; // ignore
  Location location; //idk
  String userType;
  String mainCollection;
  bool loading = true;
  String add = "";
  bool canTrack = true;
  bool listVis = true;
  static LatLng latLng;

  @override
  void initState() {
    // this function is called when the page starts
    super.initState();
    getData();
    init(); // get user location and ask for permission
  }

  getData() async {
    await FirebaseAuth.instance.currentUser().then((user) {
      if (!mounted) return;
      setState(() {
        if (user.displayName == "Shelter") {
          userType = "Shelter";
          mainColor = Colors.blue;
          mainCollection = "Restaurant";
          loading = false;
          //sleep(const Duration(seconds: 2));
        } else {
          userType = "Restaurant";
          mainColor = Colors.green;
          mainCollection = "Shelter";
          loading = false;
          //sleep(const Duration(seconds: 2));
        }
      });
    });
  }

  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
    do {
      var shift = 0;
      int result = 0;

      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
  }

  void sendRequest(lat, long) async {
    LatLng origin = LatLng(currentLocation.latitude, currentLocation.longitude);
    LatLng destination = LatLng(lat, long);
    String route =
        await _googleMapsServices.getRouteCoordinates(origin, destination);
    setPolyline(route, origin.toString());
  }

  void onCameraMove(CameraPosition position) {
    latLng = position.target;
    //print(position.target);
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

    location.onLocationChanged.listen((LocationData cLoc) {
      currentLocation = cLoc;
      if (canTrack == true) {
        updatePinOnMap();
        //_showCurrentLoc(currentLocation.latitude, currentLocation.longitude);
      }
    });
    setSourceAndDestinationIcons();
    currentLocation = await location.getLocation();
  }

  void setSourceAndDestinationIcons() async {
    currentLocIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/current_marker.png');
    shelterIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/shelter_marker.png');
    restaurantIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/rest_marker.png');
  }

  getSomePoints(lat, long) async {
    routeCords = await googleMapPolyline.getCoordinatesWithLocation(
        origin: LatLng(currentLocation.latitude, currentLocation.longitude),
        destination: LatLng(lat, long),
        mode: RouteMode.driving);
  }

  void setPolyline(String encondedPoly, String origin) async {
    polyLines.removeWhere((m) => m.polylineId.value == 'poly');
    polyLines.add(Polyline(
      polylineId: PolylineId("poly"),
      visible: true,
      points: routeCords,
      width: 5,
      startCap: Cap.squareCap,
      endCap: Cap.buttCap,
      color: mainColor,
    ));
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
    } else {
      currentLocation = destinationLocation;
      updatePinOnMap();
      //print(_permissionGranted);
    }
    return Container(
      child: Stack(
        children: <Widget>[
          GoogleMap(
            onCameraMove: onCameraMove,
            myLocationButtonEnabled: false,
            myLocationEnabled: false,
            compassEnabled: true,
            tiltGesturesEnabled: false,
            markers: _markers,
            polylines: polyLines,
            mapType: MapType.normal,
            initialCameraPosition: initialCameraPosition,
            onMapCreated: (GoogleMapController controller) {
              controller.setMapStyle(Utils.mapStyles);
              _controller.complete(controller);
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              //alignment: Alignment.centerRight,
              //color: Colors.blue,
              margin: EdgeInsets.symmetric(vertical: 20.0),
              width: MediaQuery.of(context).size.width,
              height: 190,
              child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection(mainCollection ?? "test")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData || loading == true) {
                    return Center(child: Text('Loading...'));
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.0, color: Colors.grey),
                            color: mainColor,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              //setPolyline();
                              if (!mounted) return;
                              setState(() {
                                canTrack = true;
                              });
                              _showCurrentLoc(currentLocation.latitude,
                                  currentLocation.longitude);
                            },
                            icon: Icon(
                              Icons.my_location,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Visibility(
                            visible: listVis,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: snapshot.data.documents
                                  .map((DocumentSnapshot document) {
                                if (document['lat'] != null &&
                                    document['long'] != null) {
                                  return Container(
                                    padding: EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    child: _boxes(
                                        document.documentID,
                                        document['city'] ?? "City",
                                        document['state'] ?? "State",
                                        "https://media.timeout.com/images/105239239/image.jpg",
                                        document['lat'].toDouble() ?? 41.987135,
                                        document['long'].toDouble() ??
                                            -87.731037,
                                        document['displayName'] ?? "null",
                                        document['role'] ?? "null",
                                        shelterIcon),
                                  );
                                } else {
                                  return Text("");
                                }
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
          Positioned(
            top: 30,
            right: 20,
            left: 20,
            child: Container(
              height: 40,
              child: Material(
                borderRadius: BorderRadius.circular(8),
                elevation: 8.0,
                shadowColor: Color(0x802196F3),
                child: TextField(
                  onTap: () {
                    setState(() {
                      listVis = false;
                      canTrack = false;
                    });
                  },
                  autocorrect: true,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (_) {
                    if (add == "" || add == null) {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      setState(() {
                        listVis = true;
                      });
                    } else {
                      navigate();
                      FocusScope.of(context).requestFocus(new FocusNode());
                      setState(() {
                        listVis = true;
                      });
                    }
                  },
                  onChanged: (val) {
                    if (!mounted) return;
                    setState(() {
                      add = val;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Enter an address",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15.0, top: 7.0),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  navigate() {
    Geolocator().placemarkFromAddress(add).then((results) {
      getSomePoints(
          results[0].position.latitude, results[0].position.longitude);
      _goToArea(
          "0",
          results[0].locality,
          results[0].administrativeArea,
          results[0].position.latitude,
          results[0].position.longitude,
          results[0].name ?? "Location",
          "Place",
          currentLocIcon);
      print(results[0].toJson().toString());
    }).catchError((error) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message),
        ),
      );
      //print(error.toString());
    });
  }

  Widget _boxes(String id, String city, String state, String _image, double lat,
      double long, String restaurantName, String role, BitmapDescriptor icon) {
    return Container(
      child: FittedBox(
        child: Material(
          child: InkWell(
            borderRadius: BorderRadius.circular(18.0),
            onTap: () {
              _goToArea(id, city, state, lat, long, restaurantName, role, icon);
              getSomePoints(lat, long);
              detailsBottomSheet(context, restaurantName, role, city, state, lat, long);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(18.0),
                  width: 210,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        _image,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.white,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 0.0, right: 20.0),
                  child: detailsContainer(
                      restaurantName, role, lat, long, city, state),
                ),
              ],
            ),
          ),
          borderRadius: BorderRadius.circular(18.0),
          color: mainColor,
          elevation: 7.0,
          shadowColor: Color(0x802196F3),
        ),
      ),
    );
  }

  Widget detailsContainer(String restaurantName, String role, double lat,
      double long, String city, String state) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Container(
            child: Text(
              restaurantName,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
            "" + role + " in " + city + ", " + state,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.normal),
          )),
        ),
        SizedBox(height: 10.0),
        /* //
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
                lat.toString()+", "+long.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal),
              )),
        ),
        SizedBox(height: 10.0),
        */
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Text(
                  "4.1 ",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Container(
                child: Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 20.0,
                ),
              ),
              Container(
                child: Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 20.0,
                ),
              ),
              Container(
                child: Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 20.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void showPinsOnMap() {
    var pinPosition =
        LatLng(currentLocation.latitude, currentLocation.longitude);
    _showCurrentLoc(pinPosition.latitude, pinPosition.longitude);
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
    if (!mounted) return;
    // make sure not to run if its not mounted aka available saves memory
    setState(() {
      // updated position
      var pinPosition =
          LatLng(currentLocation.latitude, currentLocation.longitude);

//      FirebaseAuth.instance.currentUser().then((user) {
//        String role2;
//        if (user.displayName == "Shelter") {
//          role2 = "Shelter";
//          Firestore.instance.collection(role2).document(user.uid).updateData({
//            'lat': pinPosition.latitude,
//            'long': pinPosition.longitude,
//          }).then((onValue) {});
//        } else {
//          role2 = "Restaurant";
//          Firestore.instance.collection(role2).document(user.uid).updateData({
//            'lat': pinPosition.latitude,
//            'long': pinPosition.longitude,
//          }).then((onValue) {});
//        }
//      });

      _markers.removeWhere((m) => m.markerId.value == 'currentLoc');
      _markers.add(Marker(
          onTap: () {
            _showCurrentLoc(pinPosition.latitude, pinPosition.longitude);
            FocusScope.of(context).requestFocus(new FocusNode());
            setState(() {
              listVis = true;
            });
          },
          markerId: MarkerId('currentLoc'),
          position: pinPosition, //
          infoWindow: InfoWindow(title: "My Location"), // updated position
          icon: currentLocIcon));
    });
  }

  void _goToArea(String id, String city, String state, double lat, double long,
      String name, String type, BitmapDescriptor icon) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (!mounted) return;
    setState(() {
      canTrack = false;
    });
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
    )));
    if (!mounted) return;
    setState(() {
      _markers.removeWhere((m) => m.markerId.value == id);
      _markers.add(Marker(
          onTap: () {
            getSomePoints(lat, long);
            //setPolyline();
            FocusScope.of(context).requestFocus(new FocusNode());
            setState(() {
              listVis = true;
            });
            detailsBottomSheet(context, name, type, city, state, lat, long);
          },
          markerId: MarkerId(id),
          position: LatLng(lat, long),
          infoWindow: InfoWindow(
              title: name, snippet: type + " in " + city + ", " + state),
          icon: icon));
    });
  }

  void _showCurrentLoc(double lat, double long) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() {
      listVis = true;
    });
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
    )));
    if (!mounted) return;
    setState(() {
      canTrack = true;
      Geolocator().placemarkFromCoordinates(lat, long).then((onValue) {
        _markers.removeWhere((m) => m.markerId.value == 'currentLoc');
        _markers.add(Marker(
            onTap: () {
              _showCurrentLoc(
                  currentLocation.latitude, currentLocation.longitude);
              FocusScope.of(context).requestFocus(new FocusNode());
              setState(() {
                listVis = true;
              });
            },
            markerId: MarkerId('currentLoc'),
            position: LatLng(lat, long), //
            infoWindow: InfoWindow(
                title: "Current Location",
                snippet: onValue[0].subThoroughfare +
                    " " +
                    onValue[0].thoroughfare), // updated position
            icon: currentLocIcon));
      }).catchError((error) {
        print(error.message);
      });
    });
  }

  void detailsBottomSheet(context, name, type, city, state, lat, long) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return Container(
//height: MediaQuery.of(context).size.height * .30,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Center(
                    child: Container(
                      width: 44,
                      height: 4,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(20)
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10, left: 15, right: 15),
//color: mainColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(type + " in " + city + ", " + state),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        child: FlatButton(
                          onPressed: () {
//sendRequest(lat, long);
                            setPolyline("", "");
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Directions",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          color: mainColor,
                        ),
                      ),
                      Container(
//width: 350,
                        height: 200,
                        margin:
                        EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(6.0)),
//border: Border.all(width: 1.0, color: mainColor),
//shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/shelter.jpg'),
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 20),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Container(
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(6.0)),
                                color: mainColor,
                              ),
                              child: FlatButton(
                                child: Icon(Icons.call),
                              ),
                            ),
                            Container(
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(6.0)),
                                color: mainColor,
                              ),
                              child: FlatButton(
                                  child: FaIcon(FontAwesomeIcons.donate)
                              ),
                            ),
                            Container(
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(6.0)),
                                color: mainColor,
                              ),
                              child: FlatButton(
                                child: Icon(Icons.favorite),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}

//custom colors for map
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
