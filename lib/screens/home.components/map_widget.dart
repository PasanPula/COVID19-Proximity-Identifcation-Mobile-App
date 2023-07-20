import '../../providers/location_provider.dart';
import '/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapWidget extends StatelessWidget {
  final LatLng _initialcameraposition = const LatLng(6.934166, 79.849029);

  const MapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // LocationService locationService =
    //     Provider.of<LocationService>(context, listen: true);
    
    LocationProvider locationProvider = Provider.of<LocationProvider>(context,listen: true);

    return Container(
      margin: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
      height: MediaQuery.of(context).size.height / 5,
      width: MediaQuery.of(context).size.width / 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: GoogleMap(
        padding: const EdgeInsets.all(15.0),
        initialCameraPosition:
            CameraPosition(target: _initialcameraposition, zoom: 15),
        mapType: MapType.normal,
        markers: Set.of(
            (locationProvider.marker != null) ? [locationProvider.marker!] : []),
        onMapCreated: locationProvider.onMapCreated,
        // myLocationEnabled: true,
      ),
    );
  }
}
