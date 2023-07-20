import 'package:auto_size_text/auto_size_text.dart';
import '../../providers/location_provider.dart';
import '/services/location_service.dart';
import '/models/Nearby.device.Models/nearby.device_model.dart';
import '/providers/nearby.device.history_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';

class RealTimeNearbyDevice extends StatelessWidget {
  const RealTimeNearbyDevice({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // NearByDeviceprovider nearbyprovider =
    //     Provider.of<NearByDeviceprovider>(context, listen: true);

    // LocationService locationService =
    //     Provider.of<LocationService>(context, listen: true);

    LocationProvider locationProvider =
        Provider.of<LocationProvider>(context, listen: true);

    if (locationProvider.clicks) {
      Future.delayed(
          const Duration(seconds: 30),
          () => {
                locationProvider.setDeviceCount2(locationProvider.deviceCount),
              });
    }
    return FutureBuilder<List<NearbyDeviceModel>>(
        future: locationProvider.fetchRealtimeNearbyDeivces(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              if (snapshot.data!.length != locationProvider.deviceCount) {
                locationProvider.setDeviceCount2((snapshot.data!.length));
              }
            }); //sets device count
            if (snapshot.data!.length == 0) {
              return Expanded(
                child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 25, 0, 20),
                    child: Container(
                      height: (MediaQuery.of(context).size.height - 20) / 6,
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: AutoSizeText("No nearby devices",
                          style: GoogleFonts.raleway(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 15.0),
                          textAlign: TextAlign.start
                          // maxLines: 2,
                          ),
                    )),
              );
            }
            return Expanded(
              child: Container(
                  height: MediaQuery.of(context).size.height / 5.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                    child: Column(
                      children: [
                        Expanded(
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 5,
                                      crossAxisSpacing: 0,
                                      mainAxisSpacing: 5),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.phone_android_sharp,
                                      color: Colors.black,
                                      size: 10,
                                    ),
                                    Flexible(
                                      child: Marquee(
                                        text: snapshot
                                            .data![index].device.deviceName,
                                        style: GoogleFonts.poppins(
                                            fontSize: 12, color: Colors.black),
                                        scrollAxis: Axis.horizontal,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        blankSpace: 20.0,
                                        velocity: 30.0,
                                        pauseAfterRound:
                                            const Duration(seconds: 2),
                                        startPadding: 10.0,
                                        accelerationDuration:
                                            const Duration(milliseconds: 500),
                                        accelerationCurve: Curves.linear,
                                        decelerationDuration:
                                            const Duration(milliseconds: 500),
                                        decelerationCurve: Curves.easeOut,
                                      ),
                                      // AutoSizeText("Samsung A350sssss",
                                      //     style: GoogleFonts.raleway(
                                      //         color: Colors.black),
                                      //     textAlign: TextAlign.center),
                                    ),
                                  ],
                                );
                              }),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [

                        //   ],
                        // )
                      ],
                    ),
                  )),
            );
          } else if (snapshot.hasError) {
            return Expanded(
              child: Container(
                  alignment: AlignmentDirectional.center,
                  height: MediaQuery.of(context).size.height / 5.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Text(
                    "${snapshot.error}",
                    style: GoogleFonts.raleway(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 12.0),
                  )),
            );
          }
          return Expanded(
            child: Container(
                height: MediaQuery.of(context).size.height / 5.5,
                alignment: AlignmentDirectional.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: const CircularProgressIndicator()),
          );
        });
  }
}
