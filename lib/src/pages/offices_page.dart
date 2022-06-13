import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:proyecto_dam/src/constants/constant.dart';
import 'package:proyecto_dam/src/services/office_service.dart';
import 'package:proyecto_dam/src/widgets/widgets.dart';

import 'package:proyecto_dam/src/models/office_model.dart';

class OfficesPage extends StatefulWidget {
  const OfficesPage({Key? key}) : super(key: key);

  @override
  State<OfficesPage> createState() => _OfficesPageState();
}

class _OfficesPageState extends State<OfficesPage> {
  final Map<String, Marker> _markers = {};
  final _initialPosition = const LatLng(38, -1.13);

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  void _checkPermission() async {
    if (await Permission.locationWhenInUse.request().isGranted == false) {
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _onMapCreated(GoogleMapController controller) async {
      final List<Office> officesList = await OfficeService().loadDB();

      setState(
        () {
          // _markers.clear();
          for (final office in officesList) {
            final marker = Marker(
              markerId: MarkerId(office.id!),
              position: LatLng(
                office.coord.lat,
                office.coord.lng,
              ),
              infoWindow: InfoWindow(
                title: office.id,
                snippet: office.address,
                onTap: () {
                  final _phoneNumber = office.phone;
                  final _lat = office.coord.lat;
                  final _lng = office.coord.lng;
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        contentPadding: const EdgeInsets.all(1),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              minLeadingWidth: 12,
                              title: text('Llámanos ($_phoneNumber)'),
                              leading: const Icon(
                                Icons.phone,
                                color: redButtons1,
                              ),
                              onTap: () {
                                launchUrl(
                                    Uri(scheme: 'tel', path: '$_phoneNumber'));
                              },
                            ),
                            ListTile(
                              minLeadingWidth: 12,
                              title: text('Ven a vernos'),
                              leading: const Icon(
                                Icons.location_pin,
                                color: redButtons1,
                              ),
                              onTap: () {
                                launchUrl(Uri(
                                  scheme: 'google.navigation',
                                  path: 'q=$_lat,$_lng',
                                ));
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            );
            _markers[office.id!] = marker;
          }
        },
      );
    }

    Future _mapFuture =
        Future.delayed(const Duration(milliseconds: 200), () => true);

    return Scaffold(
      appBar: appBar(context: context, title: 'Oficinas'),
      body: FutureBuilder(
        future: _mapFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 8,
            ),
            onMapCreated: _onMapCreated,
            onTap: (position) {},
            markers: _markers.values.toSet(),
          );
        },
      ),
    );
  }
}
