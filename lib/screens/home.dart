// ignore_for_file: prefer_const_constructors
import 'dart:isolate';
// import '../providers/geolist_provider.dart';
import '/providers/location_provider.dart';

import '../providers/nearby.device.history_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'home.components/map_widget.dart';
import 'home.components/nearby.realtime.dart';

//**************************************** SCREEEN SHOWS TRACING AND MAPS TO USER *****************************
//no provider class.directly used location service as provider
//TODO
//1. implement realtime nearby device
//2. create provider
//3. make device card scrollable and using grid

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {

  late ReceivePort port;

   @override
  initState() {
    super.initState();

    port = ReceivePort();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {

       LocationProvider locationProvider = Provider.of<LocationProvider>(context,listen: false);
    locationProvider.inizialize(port);
    locationProvider.initcheck(port);

    });
  }



  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // LocationService locationService =
    //     Provider.of<LocationService>(context, listen: true);

    
    LocationProvider locationProvider = Provider.of<LocationProvider>(context,listen: true);
    // Geolistprovider geolistprovider =
    //     Provider.of<Geolistprovider>(context, listen: true);
    NearByDeviceprovider nearbyprovider =
        Provider.of<NearByDeviceprovider>(context, listen: true);




    // nearByHistory(String date) {
    //   nearbyprovider.setselectedDate(geolistprovider.formatDate(date));
    //   nearbyprovider.setStartTime(geolistprovider.formatStartTime(date));
    //   nearbyprovider.setEndTime(geolistprovider.formatEndTime(date));
    //   nearbyprovider.setDistance(locationService.distance);
    // }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF070707),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left_sharp,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/starttrace');
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.coronavirus_outlined,
                color: Colors.white,
                size: 25,
              ),
              AutoSizeText('CovTrack R-20',
                  style: GoogleFonts.raleway(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.history_sharp,
                color: Color(0xFFEFEEEE),
                size: 30,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/history');
              },
            )
          ],
          centerTitle: true,
          elevation: 1,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
              child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              SizedBox(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.38,
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                    child: Column(
                      children: [
                        MapWidget(), //maps widget --on home components
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 0.9,
                          child: Card(
                              margin: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                              elevation: 0,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(25),
                                    bottomRight: Radius.circular(25)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Container(
                                    height: 100,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        locationProvider.address == "No data"
                                            ? ListTile(
                                                horizontalTitleGap: -40,
                                                // tileColor: Colors.amber,
                                                title: AutoSizeText('No data',
                                                    textAlign: TextAlign.center,
                                                    maxLines: 1,
                                                    style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 15.0,
                                                        color:
                                                            Colors.red.shade400)),
                                                leading: Icon(
                                                  Icons.location_disabled_rounded,
                                                  color: Colors.black,
                                                  size: 35.0,
                                                ),
                                              )
                                            : ListTile(
                                                subtitle: AutoSizeText(
                                                    '${locationProvider.address} \n on ${locationProvider.formatReadeableDate(locationProvider.date)} at ${locationProvider.formatReadeableTime(locationProvider.date)}', // ${locationService.formatReadeableDate(locationService.date)} at ${locationService.address} \n on
                                                    maxLines: 2,
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14.0,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                                horizontalTitleGap: -50,
                                                leading: Icon(
                                                  Icons.location_on_outlined,
                                                  color: Colors.black,
                                                  size: 38.0,
                                                ),
                                                title: AutoSizeText(
                                                    ' Checked in at: ',
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 16.0,
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.w800)),
                                              ),
                                      ],
                                    )),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.rectangle,
                  ),
                  child: Column(
                    children: [
                      // Row(
                      //   mainAxisSize: MainAxisSize.max,
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Text('Nearby devices',
                      //         style: GoogleFonts.poppins(
                      //             fontSize: 16.0, fontWeight: FontWeight.w600))
                      //   ],
                      // ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15, 15, 15, 15),
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    // height: 200,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15)),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              20, 20, 20, 10),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                // Text('Distance:',
                                                //     style: GoogleFonts.poppins(
                                                //         color: Colors.black,
                                                //         fontSize: 14.0,
                                                //         fontWeight:
                                                //             FontWeight.w600))
                                                Text('Nearby devices',
                                                    style: GoogleFonts.poppins(
                                                      color: Colors.black,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w600))
                                              ]),
                                        ),
                                        // Padding(
                                        //   padding:  EdgeInsetsDirectional.fromSTEB(
                                        //       0, 5, 0, 0),
                                        //   child: Row(
                                        //     mainAxisAlignment:
                                        //         MainAxisAlignment.center,
                                        //     children: [
                                        //       Container(
                                        //         alignment: Alignment.center,
                                        //         width: MediaQuery.of(context)
                                        //                 .size
                                        //                 .width -
                                        //             30,
                                        //         child: ToggleSwitch(
                                        //           initialLabelIndex:
                                        //               locationService.toggleindex,
                                        //           totalSwitches: 4,
                                        //           labels: const [
                                        //             '5m',
                                        //             '10m',
                                        //             '20m',
                                        //             '30m'
                                        //           ],
                                        //           activeBgColor: const [
                                        //             Colors.grey
                                        //           ],
                                        //           activeFgColor: Colors.white,
                                        //           inactiveBgColor:
                                        //               Colors.grey.shade200,
                                        //           inactiveFgColor: Colors.grey[900],
                                        //           onToggle: (index) {
                                        //             print(index);
                                        //             locationService
                                        //                 .updateDistance(index);
                                        //             nearByHistory(DateTime.now()
                                        //                 .toIso8601String());
                                        //             // nearbyprovider
                                        //             //     .fetchNearbyDeivces();
                                        //           },
                                        //         ),
                                        //         // SliderTheme(
                                        //         //   data: SliderTheme.of(context)
                                        //         //       .copyWith(
                                        //         //     trackHeight: 15.0,
                                        //         //     trackShape:
                                        //         //         RoundedRectSliderTrackShape(),
                                        //         //     activeTrackColor:
                                        //         //         Colors.blue.shade800,
                                        //         //     inactiveTrackColor:
                                        //         //         Colors.blue.shade200,
                                        //         //     thumbShape:
                                        //         //         RoundSliderThumbShape(
                                        //         //       enabledThumbRadius: 12.0,
                                        //         //       pressedElevation: 3.0,
                                        //         //     ),
                                        //         //     thumbColor: Colors.blue,
                                        //         //     overlayColor: Colors.pink
                                        //         //         .withOpacity(0.2),
                                        //         //     overlayShape:
                                        //         //         RoundSliderOverlayShape(
                                        //         //             overlayRadius: 18.0),
                                        //         //     tickMarkShape:
                                        //         //         RoundSliderTickMarkShape(),
                                        //         //     activeTickMarkColor:
                                        //         //         Colors.pinkAccent,
                                        //         //     inactiveTickMarkColor:
                                        //         //         Colors.white,
                                        //         //     valueIndicatorShape:
                                        //         //         PaddleSliderValueIndicatorShape(),
                                        //         //     valueIndicatorColor:
                                        //         //         Colors.black,
                                        //         //     valueIndicatorTextStyle:
                                        //         //         TextStyle(
                                        //         //       color: Colors.white,
                                        //         //       fontSize: 20.0,
                                        //         //     ),
                                        //         //   ),
                                        //         //   child: Slider(
                                        //         //     min: 5.0,
                                        //         //     max: 20.0,
                                        //         //     value: sliderValue.toDouble(),
                                        //         //     divisions: 3,
                                        //         //     label:
                                        //         //         '${sliderValue.round()}m',
                                        //         //     onChanged: (value) {
                                        //         //       setState(() {
                                        //         //         sliderValue =
                                        //         //             value.round();
                                        //         //       });
                                        //         //     },
                                        //         //   ),
                                        //         // )
                                        //       )
                                        //     ],
                                        //   ),
                                        // ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              15, 0, 15, 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 8, 0),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                        width:
                                                            MediaQuery.of(context)
                                                                    .size
                                                                    .width /
                                                                4,
                                                        height: 150,
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          shape: BoxShape.circle,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.2),
                                                              spreadRadius: 5,
                                                              blurRadius: 7,
                                                              offset: Offset(0,
                                                                  2), // changes position of shadow
                                                            ),
                                                          ],
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                                '${locationProvider.deviceCount}',
                                                                style: GoogleFonts.poppins(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        18.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                            Text('Devices',
                                                                style: GoogleFonts.poppins(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        12.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                            Text('in 10m radius',
                                                                style: GoogleFonts.poppins(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        10.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600))
                                                          ],
                                                        ))
                                                  ],
                                                ),
                                              ),
                                              RealTimeNearbyDevice()
                                            ],
                                          ),
                                        ),
                                      ],
                                    ))),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: locationProvider.clicks
                                ? () => {locationProvider.stopTrace()}
                                : () => {locationProvider.startTrace(port)
                                },
                            child: Container(
                              width: 230,
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: locationProvider.clicks
                                    ? Colors.red[500]
                                    : Colors.green.shade400,
                              ),
                              child: locationProvider.loader
                                  ? CircularProgressIndicator()
                                  : Container(
                                      child: locationProvider.clicks
                                          ? Text('Stop Tracing',
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700))
                                          : Text('Start Tracing',
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700)),
                                    ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ]),
          )),
        ));
  }
}
