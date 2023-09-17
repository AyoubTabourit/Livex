import 'dart:async';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:livex/reusable_widgets/reusable_widget.dart';
import 'package:livex/screen_auth/NavBar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:livex/screen_auth/sign_in.dart';
import 'package:livex/screen_auth/ramassage.dart';
import 'package:livex/screen_auth/command.dart';
import 'package:livex/screen_auth/mon_compte.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

const LatLng currentLoc = LatLng(33.60978755824398, -7.494870946024597);

void main() {
  runApp(const HomeScreen());
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, Key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  TextEditingController txtrevenuNet = TextEditingController();
  TextEditingController txtcolieLivrais = TextEditingController();
  TextEditingController txtretour = TextEditingController();
  TextEditingController txtreclamation = TextEditingController();
  final Completer<GoogleMapController> _controller = Completer();
  Map<String, Marker> _markers = {};
  static const CameraPosition _intialPosition = CameraPosition(
    target: LatLng(33.60978755824398, -7.494870946024597),
    zoom: 14,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text("Bienvenue sur LIVEX"),

      ),
      
      body: Container(
        child: Stack(
          children: [
            // Background Image 1
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/revenue_net.jpg'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            // New Image
            Positioned(
              top: 10,
              left:
                  200, // Adjust the left position to place it next to the existing image
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/Colie livrais.jpg'), // Replace with your new image path
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            //3 photo
            Positioned(
              top: 170,
              left:
                  10, // Adjust the left position to place it next to the existing image
              child: Container(
                width: 178,
                height: 180,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/reclamation.jpg'), // Replace with your new image path
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            //photo4
            Positioned(
              top: 170,
              left:
                  200, // Adjust the left position to place it next to the existing image
              child: Container(
                width: 178,
                height: 180,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/retours.jpg'), // Replace with your new image path
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            // Button
            Positioned(
              top: 118,
              left: 50,
              width: 125,
              child: ElevatedButton(
                onPressed: () {
                  //button revenu net
                  // Handle button click here
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors
                      .transparent, // Set button background color with transparency
                ),
                child: Text("Plus d'infos. ->"),
              ),
            ),
            Positioned(
              top: 119,
              left: 242,
              width: 125,
              child: ElevatedButton(
                onPressed: () {
                  //button colie livrais
                  // Handle button click here
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors
                      .transparent, // Set button background color with transparency
                ),
                child: Text("Plus d'infos. ->"),
              ),
            ),
            Positioned(
              top: 278,
              left: 50,
              width: 125,
              child: ElevatedButton(
                onPressed: () {
                  //button RECLAMATION
                  // Handle button click here
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors
                      .transparent, // Set button background color with transparency
                ),
                child: Text("Plus d'infos. ->"),
              ),
            ),
            Positioned(
              top: 285,
              left: 240,
              height: 33,
              width: 125,
              child: ElevatedButton(
                onPressed: () {
                  //button REtours
                  // Handle button click here
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors
                      .transparent, // Set button background color with transparency
                ),
                child: Text("Plus d'infos. ->"),
              ),
            ),
            //text revenu net
            Positioned(
              child: Padding(
                padding: EdgeInsets.only(
                    top: 45,
                    left: 18), // Add padding to create space for TextField
                child: Column(
                  children: [
                    txtsimple("0.00 dh", txtrevenuNet),
                  ],
                ),
              ),
            ),
            Positioned(
              //retour
              child: Padding(
                padding: EdgeInsets.only(
                    top: 205,
                    left: 213), // Add padding to create space for TextField
                child: Column(
                  children: [
                    txtsimple("0", txtretour),
                  ],
                ),
              ),
            ),
            Positioned(
              //RECLAMATION
              child: Padding(
                padding: EdgeInsets.only(
                    top: 205,
                    left: 18.5), // Add padding to create space for TextField
                child: Column(
                  children: [txtsimple("0", txtreclamation)],
                ),
              ),
            ),
            Positioned(
              child: Padding(
                //COLIE LIVRAIS
                padding: EdgeInsets.only(
                    top: 25,
                    left: 213), // Add padding to create space for TextField
                child: Column(
                  children: [
                    TextField(
                      enabled:
                          false, // Assurez-vous que ce paramètre est à true
                      readOnly: true,
                      controller: txtcolieLivrais,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.black),
                        labelText: '0',
                        border: InputBorder.none, // Remove the border (line)
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              //reclamation txt
              padding: EdgeInsets.only(
                  top: 240,
                  left: 18.5), // Add padding to create space for TextField
              child: Column(
                children: [
                  Text(
                    'Réclamation',
                    style: TextStyle(
                      fontSize: 14, // Set the font size
                      fontWeight:
                          FontWeight.bold, // Set the font weight (optional)
                      color: Colors.white, // Set the text color (optional)
                      // You can add more style attributes as needed
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 75,
                  left: 208), // Add padding to create space for TextField
              child: Column(
                children: [
                  Text(
                    'Colis livre',
                    style: TextStyle(
                      fontSize: 14, // Set the font size
                      fontWeight:
                          FontWeight.bold, // Set the font weight (optional)
                      color: Colors.white, // Set the text color (optional)
                      // You can add more style attributes as needed
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 240,
                  left: 208), // Add padding to create space for TextField
              child: Column(
                children: [
                  Text(
                    'Retours',
                    style: TextStyle(
                      fontSize: 14, // Set the font size
                      fontWeight:
                          FontWeight.bold, // Set the font weight (optional)
                      color: Colors.white, // Set the text color (optional)
                      // You can add more style attributes as needed
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 75,
                  left: 18), // Add padding to create space for TextField
              child: Column(
                children: [
                  Text(
                    'Revenu Net',
                    style: TextStyle(
                      fontSize: 14, // Set the font size
                      fontWeight:
                          FontWeight.bold, // Set the font weight (optional)
                      color: Colors.white, // Set the text color (optional)
                      // You can add more style attributes as needed
                    ),
                  )
                ],
              ),
            ),

            //position map
            //SizedBox(heRight: 20,),

            Positioned(
              left: 0,
              top: 400,
              width: 450,
              height: 200,
              child: GoogleMap(
                initialCameraPosition: _intialPosition,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  addMarker('test', currentLoc);
                },
                markers: _markers.values.toSet(),
              ),
            ),
            Positioned(
                top: 350,
                left: 10,
                child: Text(
                  'Localisation :', // Your text goes here
                  style: TextStyle(
                    fontSize: 24, // Adjust the font size as needed
                    fontWeight:
                        FontWeight.bold, // Adjust the font weight as needed
                    color: Colors.blue, // Adjust the text color as needed
                  ),
                )),
            //position text revenuenet
          ],
        ),
      ),
    );
  }

  addMarker(String id, LatLng location) async {
    var markerIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), 'assets/market.png');
    var marker = Marker(
      markerId: MarkerId(id),
      position: location,
      infoWindow:
          const InfoWindow(title: 'Livex', snippet: 'livex livraison express'),
    );
    _markers[id] = marker;
    setState(() {});
  }
}
