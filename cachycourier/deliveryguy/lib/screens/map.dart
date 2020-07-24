import 'dart:async';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:deliveryguy/screens/secrets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart'; 
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math' show cos, sqrt, asin;
 
class MappPage extends StatefulWidget {
  final String id;
  final String email;  
  MappPage(this.id,this.email);
  @override
  _MapViewState createState() => _MapViewState(id,email);
}

class _MapViewState extends State<MappPage> {
  final String id;
  final String email;
  _MapViewState(this.id,this.email);
  CameraPosition _initialLocation = CameraPosition(target: LatLng(0.0, 0.0));
  GoogleMapController mapController;
  StreamSubscription _locationSubscription;
  Location locationTraker = Location();
  final Geolocator _geolocator = Geolocator();
  Timer timer;
  LocationData _currentPosition;
  String _currentAddress;

  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();

  String _startAddress = '';
  String _destinationAddress = 'guntur';
  String _placeDistance;
  double zoomLevel = 9.0;
  LatLng centerBounds;
  Set<Marker> markers = {};

  PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
 
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _textField({
    TextEditingController controller,
    String label,
    String hint,
    double width,
    Icon prefixIcon,
    Widget suffixIcon,
    Function(String) locationCallback,
  }) {
    return Container(
      width: width * 0.8,
      child: TextField(
        onChanged: (value) {
          locationCallback(value);
        },
        controller: controller,
        decoration: new InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.grey[400],
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.blue[300],
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.all(15),
          hintText: hint,
        ),
      ),
    );
  }

  // Method for retrieving the current location
  _getCurrentLocation() async {
    var data = await start_dest(id, email); 
    print(data);
    print("location");
    var location = await locationTraker.getLocation();
    setState(() {
      print("get location");
      markers = {};
      polylines = {};
      polylineCoordinates = [];
      GoogleMap(
        markers: markers != null ? Set<Marker>.from(markers) : null,
        initialCameraPosition: _initialLocation,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        mapType: MapType.normal,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
      );
      _currentPosition = location;
     //_destinationAddress = data;
    });
    await _getAddress();
    await _calculateDistance(zoomLevel,_currentPosition.latitude,_currentPosition.longitude);
    zoomLevel = await mapController.getZoomLevel();
    final LatLngBounds screenBounds = await mapController.getVisibleRegion();
    centerBounds = LatLng(
        (screenBounds.northeast.latitude + screenBounds.southwest.latitude)/2,
        (screenBounds.northeast.longitude + screenBounds.southwest.longitude)/2
      );
  }

  // Method for retrieving the address
  _getAddress() async {
    try {
      List<Placemark> p = await _geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
        startAddressController.text = _currentAddress;
        _startAddress = _currentAddress;
      });
      print(_currentAddress);
    } catch (e) {
      print(e);
    }
  }

  // Method for calculating the distance between two places
  Future<bool> _calculateDistance(double zoomlevel,double lat,double long) async {
    print("calculatedistance");
    // await  _getCurrentLocation();
    print(_startAddress);
    print(_destinationAddress);
    try {
      // Retrieving placemarks from addresses
      List<Placemark> startPlacemark =
          await _geolocator.placemarkFromAddress(_startAddress);
      List<Placemark> destinationPlacemark =
          await _geolocator.placemarkFromAddress(_destinationAddress);

      if (startPlacemark != null && destinationPlacemark != null) {
        // Use the retrieved coordinates of the current position,
        // instead of the address if the start position is user's
        // current position, as it results in better accuracy.
        Position startCoordinates = _startAddress == _currentAddress
            ? Position(
                latitude: _currentPosition.latitude,
                longitude: _currentPosition.longitude)
            : startPlacemark[0].position;
        Position destinationCoordinates = destinationPlacemark[0].position;

        // Start Location Marker
        // Marker startMarker = Marker(
        //   markerId: MarkerId('$startCoordinates'),
        //   position: LatLng(
        //     startCoordinates.latitude,
        //     startCoordinates.longitude,
        //   ),
        //   infoWindow: InfoWindow(
        //     title: 'Start',
        //     snippet: _startAddress,
        //   ),
        //   icon: BitmapDescriptor.defaultMarker,
        // );

        // Destination Location Marker
        Marker destinationMarker = Marker(
          markerId: MarkerId('$destinationCoordinates'),
          position: LatLng(
            destinationCoordinates.latitude,
            destinationCoordinates.longitude,
          ),
          infoWindow: InfoWindow(
            title: 'Destination',
            snippet: _destinationAddress,
          ),
          icon: BitmapDescriptor.defaultMarker,
        );

        // Adding the markers to the list
        // markers.add(startMarker);
        markers.add(destinationMarker);

        print('START COORDINATES: $startCoordinates');
        print('DESTINATION COORDINATES: $destinationCoordinates');

      // setting map position to centre to start with
      mapController.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
        // target: centerBounds,
        target: LatLng(lat,long), 
        zoom: zoomlevel,
      )));

        // await _createPolylines(startCoordinates, destinationCoordinates);

        double totalDistance = 0.0;
        totalDistance = _coordinateDistance(startCoordinates.latitude,startCoordinates.longitude, destinationCoordinates.latitude, destinationCoordinates.longitude);

        setState(() {
          _placeDistance = totalDistance.toStringAsFixed(7);
          print('DISTANCE: $_placeDistance km'); 
        });

        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  // Formula for calculating distance between two coordinates
  // https://stackoverflow.com/a/54138876/11910277

  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  } 
  Future<String> start_dest(String id,String email) async {
    print(DotEnv().env['ipadress']);
    var url="http://"+DotEnv().env['ipadress']+":"+DotEnv().env['port']+"/addorder/map2";
    print(url);
    http.Response resp = await http.post(url,body: {'id':id,'email':email});  // 10.0.2.2 for emulator
    if (resp.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(resp.body);
      print('$jsonResponse');
      print("success");
      String dest = jsonResponse['msg'];
    return dest; 
    }
      } 

  // Create the polylines for showing the route between two places
  // _createPolylines(Position start, Position destination) async {
  //   // polylinePoints = PolylinePoints();
  //   // PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //   //   Secrets.API_KEY, // Google Maps API Key 
  //   //   PointLatLng(start.latitude, start.longitude),
  //   //   PointLatLng(destination.latitude, destination.longitude),
  //   //   travelMode: TravelMode.transit,
  //   // );
  //   // print(Secrets.API_KEY);
  //   // print(PointLatLng(start.latitude, start.longitude));
  //   // print(PointLatLng(destination.latitude, destination.longitude));
  //   // print(result.points);
  //   // await getRouteCoordinates(start, destination);
  //   String url ="https://maps.googleapis.com/maps/api/directions/json?origin=${start.latitude},${start.longitude}&destination=${destination.latitude},${destination.longitude}&key=${Secrets.API_KEY}";
  //   http.Response response = await http.get(url);
  //   Map values = convert.jsonDecode(response.body);
  //   print(values["routes"][0]["overview_polyline"]["points"]);
  //   PolylineId id = PolylineId('poly');
  //   Polyline polyline = Polyline(
  //     polylineId: id,
  //     color: Colors.red,
  //     points: convertToLatLng(decodePoly(values["routes"][0]["overview_polyline"]["points"])),
  //     width: 3,
  //   );
  //   polylines[id] = polyline;
  // }
  // !DECODE POLY
  // static List decodePoly(String poly) { 
  //   var list = poly.codeUnits;
  //   var lList = new List();
  //   int index = 0;
  //   int len = poly.length;
  //   int c = 0;
  //   // repeating until all attributes are decoded
  //   do {
  //     var shift = 0;
  //     int result = 0;

  //     // for decoding value of one attribute
  //     do {
  //       c = list[index] - 63;
  //       result |= (c & 0x1F) << (shift * 5);
  //       index++;
  //       shift++;
  //     } while (c >= 32);
  //     /* if value is negative then bitwise not the value */
  //     if (result & 1 == 1) {
  //       result = ~result;
  //     }
  //     var result1 = (result >> 1) * 0.00001;
  //     lList.add(result1);
  //   } while (index < len);

  //   /*adding to previous value as done in encoding */
  //   for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

  //   print(lList.toString());

  //   return lList;
  // }
  // static List<LatLng> convertToLatLng(List points) {
  //   List<LatLng> result = <LatLng>[];
  //   for (int i = 0; i < points.length; i++) {
  //     if (i % 2 != 0) {
  //       result.add(LatLng(points[i - 1], points[i]));
  //     }
  //   }
  //   return result;
  // }
  @override
  Future<void> initState(){
    super.initState(); 
    //  _calculateDistance();
    _getCurrentLocation();
    timer = Timer.periodic(Duration(seconds: 15), (Timer t) => _getCurrentLocation());
  } 
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      child: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            // Map View
            GoogleMap(
              markers: markers != null ? Set<Marker>.from(markers) : null,
              initialCameraPosition: _initialLocation,
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              polylines: Set<Polyline>.of(polylines.values),
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
            ),
            // Show zoom buttons
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipOval(
                      child: Material(
                        color: Colors.blue[100], // button color
                        child: InkWell(
                          splashColor: Colors.blue, // inkwell color
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(Icons.add),
                          ),
                          onTap: () {
                            mapController.animateCamera(
                              CameraUpdate.zoomIn(),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ClipOval(
                      child: Material(
                        color: Colors.blue[100], // button color
                        child: InkWell(
                          splashColor: Colors.blue, // inkwell color
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(Icons.remove),
                          ),
                          onTap: () {
                            mapController.animateCamera(
                              CameraUpdate.zoomOut(),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            SafeArea(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                  child: ClipOval(
                    child: Material(
                      color: Colors.orange[100], // button color
                      child: InkWell(
                        splashColor: Colors.orange, // inkwell color
                        child: SizedBox(
                          width: 56,
                          height: 56,
                          child: Icon(Icons.my_location),
                        ),
                        onTap: () {
                          mapController.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: LatLng(
                                  _currentPosition.latitude,
                                  _currentPosition.longitude,
                                ),
                                zoom: 18.0,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
