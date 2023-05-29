import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class GMap extends StatefulWidget {
  const GMap({super.key});

  @override
  _GMapState createState() => _GMapState();
}

class _GMapState extends State<GMap> {
  Set<Marker> _markers = HashSet<Marker>();
  Set<Polygon> _polygons = HashSet<Polygon>();
  Set<Polyline> _polylines = HashSet<Polyline>();
  Set<Circle> _circles = HashSet<Circle>();

  late GoogleMapController _mapController;
  late BitmapDescriptor _markerIcon;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setMarkerIcon();
    _setPolygons();
    _setPolylines();
    _setCircles();
  }

  void _setMarkerIcon() async {
    _markerIcon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/noodle_icon.png');
  }

  //void _setMapStyle(GoogleMapController controller) async {
  //  String style = await DefaultAssetBundle.of(context).loadString('assets/map_style.json');
  //  _mapController.setMapStyle(style);
  //} 

  void _setPolygons() {
    List<LatLng> polygonLatLongs = <LatLng>[];
    polygonLatLongs.add(LatLng(3.8208, 103.2970));
    polygonLatLongs.add(LatLng(3.8215, 103.3173));
    polygonLatLongs.add(LatLng(3.8250, 103.3209));
    polygonLatLongs.add(LatLng(3.8301, 103.3300));

    _polygons.add(
      Polygon(
        polygonId: PolygonId("0"),
        points: polygonLatLongs,
        fillColor: Colors.white,
        strokeWidth: 1,
      ),
    );
  }

  void _setPolylines() {
    List<LatLng> polylineLatLongs = <LatLng>[];
     //polylineLatLongs.add(LatLng(3.8302, 103.3066)); 
     polylineLatLongs.add(LatLng(3.8123, 103.3126)); 
     polylineLatLongs.add(LatLng(3.8234, 103.3266)); 
     polylineLatLongs.add(LatLng(3.8467, 103.3306)); 
     polylineLatLongs.add(LatLng(3.8302, 103.3066));
    

    _polylines.add(
      Polyline(
        polylineId: PolylineId("0"),
        points: polylineLatLongs,
        color: Colors.purple,
        width: 1,
      ),
    );
  }


  void _setCircles(){
    _circles.add(
      Circle(
        circleId: CircleId("0"),
        center: LatLng(3.8302, 103.3066),
        radius: 600,
        strokeWidth: 2,
        fillColor: Color.fromARGB(160, 20, 122, 153)
      )
    );
  }

  

  void _onMapCreated(GoogleMapController controller){
    _mapController = controller;

    setState(() {
      _markers.add(Marker(markerId: MarkerId("0"),
      position: LatLng(3.8168, 103.3317),
      infoWindow: InfoWindow(
        title: "Kuantan Pahang",
        snippet: "An Interesting City"
      ),
      icon: _markerIcon,
      ),
      );
    });
    // _setMapStyle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: Stack(children: <Widget>[
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(3.8168, 103.3317),
            zoom: 12,
          ),
          markers: _markers,
          polygons: _polygons,
          polylines: _polylines,
          circles: _circles,
          myLocationButtonEnabled: true,
        ),
        Container(alignment: Alignment.bottomCenter,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 32),
        child: Text("Coding with Putri"),
        )
        ],
      )
    );
  }
}