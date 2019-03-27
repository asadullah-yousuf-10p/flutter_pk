import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pk/global.dart';
import 'package:flutter_pk/venue/model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:url_launcher/url_launcher.dart';

class VenueDetailPage extends StatefulWidget {
  @override
  VenueDetailPageState createState() {
    return new VenueDetailPageState();
  }
}

class VenueDetailPageState extends State<VenueDetailPage> {
  GoogleMapController mapController;
  bool _isLoading = false;
  Venue _venue = new Venue();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 20),child:FloatingActionButton.extended(
          onPressed: () => _navigateToGoogleMaps(),
          icon: Icon(Icons.my_location),
          label: Text('Navigate'),)),
      appBar: new AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[_buildBody()],
      ),
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: _isLoading
          ? Center(
              child: HeartbeatProgressIndicator(
                  child: SizedBox(
                height: 40.0,
                width: 40.0,
                child: Image(
                  image: AssetImage('assets/map.png'),
                  color: Theme.of(context).primaryColor,
                ),
              )),
            )
          : Stack(
              children: <Widget>[
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  mapType: MapType.normal,
                  zoomGesturesEnabled: true,
                  compassEnabled: true,
                  rotateGesturesEnabled: true,
                  scrollGesturesEnabled: true,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(
                        _venue.location.latitude,
                        _venue.location.longitude,
                      ),
                      zoom: 15.0),
                  markers: <Marker>{
                    Marker(
                        markerId: MarkerId(_venue.title),
                        position: LatLng(_venue.location.latitude,
                            _venue.location.longitude),
                        infoWindow: InfoWindow(title: _venue.title),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueAzure))
                  },
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Card(
                            elevation: 4.0,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 64.0, right: 64.0, top: 16.0),
                                  child: Image(
                                    image: NetworkImage(
                                      _venue.imageUrl,
                                      scale: 0.5,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    _venue.address,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }

  _getData() {
    setState(() {
      _isLoading = true;
    });
    EventDetails _eventDetails = new EventDetails();
    var eventDetails = Firestore.instance
        .collection(FireStoreKeys.dateCollection)
        .snapshots()
        .first;
    eventDetails.then((onValue) {
      locationCache.setLocation(
        onValue.documents.first['venue']['location']['longitude'].toString(),
        onValue.documents.first['venue']['location']['latitude'].toString(),
      );
      _eventDetails = EventDetails(
          reference: onValue.documents.first.reference,
          venue: Venue(
              address: onValue.documents.first['venue']['address'],
              title: onValue.documents.first['venue']['title'],
              city: onValue.documents.first['venue']['city'],
              imageUrl: onValue.documents.first['venue']['imageUrl'],
              location: Location(
                latitude: onValue.documents.first['venue']['location']
                    ['latitude'],
                longitude: onValue.documents.first['venue']['location']
                    ['longitude'],
              )));
      setState(() {
        _venue = _eventDetails.venue;
        _isLoading = false;
      });
    });
  }

  void _navigateToGoogleMaps() async {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    String googleUrl = '';
    if (isIOS) {
      googleUrl =
          'comgooglemapsurl://maps.google.com/maps?f=d&daddr=${locationCache.latitude},${locationCache.longitude}&sspn=0.2,0.1';
      String appleMapsUrl =
          'https://maps.apple.com/?sll=${locationCache.latitude},${locationCache.longitude}';
      if (await canLaunch("comgooglemaps://")) {
        print('launching com googleUrl');
        await launch(googleUrl);
      } else if (await canLaunch(appleMapsUrl)) {
        print('launching apple url');
        await launch(appleMapsUrl);
      } else {
        await launch(
            'https://www.google.com/maps/search/?api=1&query=${locationCache.latitude},${locationCache.longitude}');
      }
    } else {
      googleUrl =
          'google.navigation:q=${locationCache.latitude},${locationCache.longitude}&mode=d';
      if (await canLaunch(googleUrl)) {
        await launch(googleUrl);
      } else {
        await launch(
            'https://www.google.com/maps/search/?api=1&query=${locationCache.latitude},${locationCache.longitude}');
      }
    }
  }
}
