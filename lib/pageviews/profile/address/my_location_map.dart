// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_final_fields, unused_field, sized_box_for_whitespace, avoid_print, unused_element

import 'dart:async';

import 'package:cloud_kitchen/core/utils/UI_helpers.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyLocationAddressMap extends StatefulWidget {
  const MyLocationAddressMap({Key? key}) : super(key: key);

  @override
  _MyLocationAddressMapState createState() => _MyLocationAddressMapState();
}

class _MyLocationAddressMapState extends State<MyLocationAddressMap> {
  TextEditingController addressController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(43.22777040504407, 76.90411616116762),
    zoom: 16,
  );

  Future<void> _goToPosition1() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              color: appDarkBgColor,
              height: MediaQuery.of(context).size.height * 0.375,
              child: Column(
                children: [
                  mapLocation(),
                  addAddressByText(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget mapLocation() {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 1.6,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
          ),
        ),
        Positioned(
          left: 5.0,
          bottom: 10.0,
          child: CircleAvatar(
            backgroundColor: appWhiteColor,
            child: IconButton(
                onPressed: _goToPosition1,
                icon: Image.asset('assets/logo/location_one.png')),
          ),
        )
      ],
    );
  }

  Widget addAddressByText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Адрес',
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xff888888)),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            color: Color(0xff404040),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: TextFormField(
            controller: addressController,
            style: TextStyle(color: appWhiteColor, fontSize: 16),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
                hintText: 'Ваш адрес',
                hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffa8a8a8))),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Комментарий',
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xff888888)),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            color: Color(0xff404040),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: TextFormField(
            controller: commentController,
            style: TextStyle(color: appWhiteColor, fontSize: 16),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
                hintText: 'Подъезд, домофон, предпочтения...',
                hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffa8a8a8))),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        InkWell(
          onTap: () async {
            var item = addressController.text;
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('address', item);
            Navigator.pop(context);
          },
          child: Container(
              decoration: BoxDecoration(
                color: Color(0xff43aa98),
                borderRadius: BorderRadius.circular(28.0),
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Везти сюда',
                  style: TextStyle(
                      color: appWhiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              )),
        ),
      ],
    );
  }
}
