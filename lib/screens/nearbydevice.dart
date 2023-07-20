import 'package:auto_size_text/auto_size_text.dart';
import '/models/Nearby.device.Models/nearby.device_model.dart';
import '../providers/nearby.device.history_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_range_picker/time_range_picker.dart';

//***************************** SCREEEN SHOWS USER CLICKS ON LOCATION HISTORY ITEM ---NEARBY DEVICE HISTORY ******************
//used nearby device provider

class NearbydevicesWidget extends StatefulWidget {
  const NearbydevicesWidget({Key? key}) : super(key: key);

  @override
  _NearbydevicesWidgetState createState() => _NearbydevicesWidgetState();
}

class _NearbydevicesWidgetState extends State<NearbydevicesWidget> {
  @override
  Widget build(BuildContext context) {
    NearByDeviceprovider nearbyprovider =
        Provider.of<NearByDeviceprovider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_sharp,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: AutoSizeText(
          'Nearby devices',
          style: GoogleFonts.raleway(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold
            
          ),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                      'Filter Nearby Devices history',
                                      style: GoogleFonts.raleway(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    // color:Colors.lightGreen,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 2),
                                          child: Row(
                                            children: [
                                              AutoSizeText(
                                                'Date:',
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            AutoSizeText(
                                              '${nearbyprovider.ReadeableDate()}',
                                              style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                        // IconButton(
                                        //   icon: const Icon(
                                        //     Icons.tune_rounded,
                                        //     color: Colors.black,
                                        //     size: 30,
                                        //   ),
                                        //   onPressed: () {
                                        //     nearbyprovider.datePop(context);
                                        //   },
                                        // ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0, 5, 0, 0),
                                      child: Row(
                                        children: [
                                          AutoSizeText(
                                            'Time Range:',
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            AutoSizeText(
                                              '${nearbyprovider.startTime}',
                                              style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            AutoSizeText(
                                              '  to  ',
                                              style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            AutoSizeText(
                                              ' ${nearbyprovider.endTime}',
                                              style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                        // IconButton(
                                        //   icon: const Icon(
                                        //     Icons.tune_rounded,
                                        //     color: Colors.black,
                                        //     size: 30,
                                        //   ),
                                        //   onPressed: () async {
                                        //     TimeRange result =
                                        //         await showTimeRangePicker(
                                        //       selectedColor: Colors.white,
                                        //       labels: [
                                        //         "12 AM",
                                        //         "3 AM",
                                        //         "6 AM",
                                        //         "9 AM",
                                        //         "12 PM",
                                        //         "3 PM",
                                        //         "6 PM",
                                        //         "9 PM",
                                        //       ].asMap().entries.map((e) {
                                        //         return ClockLabel.fromIndex(
                                        //             idx: e.key,
                                        //             length: 8,
                                        //             text: e.value);
                                        //       }).toList(),
                                        //       backgroundColor: Colors.white,
                                        //       handlerColor: Colors.white,
                                        //       strokeWidth: 10,
                                        //       ticks: 24,
                                        //       ticksWidth: 2,
                                        //       ticksOffset: -7,
                                        //       ticksLength: 15,
                                        //       ticksColor: Colors.white,
                                        //       labelOffset: 25,
                                        //       clockRotation: 180,
                                        //       use24HourFormat: true,
                                        //       context: context,
                                        //     );
                                        //     nearbyprovider.setStartTime(
                                        //         result.startTime.format(context));
                                        //     nearbyprovider.setEndTime(
                                        //         result.endTime.format(context));
                                        //   },
                                        // ),
                                      ],
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsetsDirectional.fromSTEB(
                                    //       0, 5, 0, 0),
                                    //   child: Row(
                                    //     children: [
                                    //       AutoSizeText(
                                    //         'Distance:',
                                    //         style: GoogleFonts.poppins(
                                    //             color: Colors.black,
                                    //             fontSize: 14,
                                    //             fontWeight: FontWeight.w500),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceEvenly,
                                    //   children: [
                                    //     Row(
                                    //       children: [
                                    //         AutoSizeText(
                                    //           '${nearbyprovider.distanceLabel}',
                                    //           style: GoogleFonts.poppins(
                                    //               color: Colors.black,
                                    //               fontSize: 16,
                                    //               fontWeight: FontWeight.w700),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //     // Row(
                                    //     //   children: [
                                    //     //     IconButton(
                                    //     //       icon: const Icon(
                                    //     //         Icons.tune_rounded,
                                    //     //         color: Colors.black,
                                    //     //         size: 30,
                                    //     //       ),
                                    //     //       onPressed: () async {
                                    //     //         nearbyprovider.DistancePop(context);
                                    //     //       },
                                    //     //     ),
                                    //     //   ],
                                    //     // )
                                    //   ],
                                    // )
                                      ],
                                    ),
                                  ),
                                Column(
                                 children: [
                                   Column(
                                     children: [
                                       Padding(
                                         padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                         child: Row(
                                           children: [
                                             IconButton(
                                                  icon: const Icon(
                                                    Icons.tune_rounded,
                                                    color: Colors.black,
                                                    size: 30,
                                                  ),
                                                  onPressed: () {
                                                    nearbyprovider.datePop(context);
                                                  },
                                                ),
                                           ],
                                         ),
                                       ),
                                     ],
                                   ),
                                   Column(
                                     children: [
                                       Padding(
                                         padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                         child: Row(
                                           children: [
                                             IconButton(
                                                  icon: const Icon(
                                                    Icons.tune_rounded,
                                                    color: Colors.black,
                                                    size: 30,
                                                  ),
                                                  onPressed: () async {
                                                    TimeRange result =
                                                        await showTimeRangePicker(
                                                      start: TimeOfDay(hour:int.parse(nearbyprovider.startTime.split(":")[0]),minute: int.parse(nearbyprovider.startTime.split(":")[1])) ,
                                                      end: TimeOfDay(hour:int.parse(nearbyprovider.endTime.split(":")[0]),minute: int.parse(nearbyprovider.endTime.split(":")[1])) ,
                                                      selectedColor: Colors.white,
                                                      labels: [
                                                        "12 AM",
                                                        "3 AM",
                                                        "6 AM",
                                                        "9 AM",
                                                        "12 PM",
                                                        "3 PM",
                                                        "6 PM",
                                                        "9 PM",
                                                      ].asMap().entries.map((e) {
                                                        return ClockLabel.fromIndex(
                                                            idx: e.key,
                                                            length: 8,
                                                            text: e.value);
                                                      }).toList(),
                                                      strokeColor: Colors.white,
                                                      backgroundColor: Colors.black,
                                                      handlerColor: Colors.white,
                                                      strokeWidth: 10,
                                                      ticks: 24,
                                                      ticksWidth: 2,
                                                      ticksOffset: -7,
                                                      ticksLength: 15,
                                                      ticksColor: Colors.white,
                                                      labelOffset: 25,
                                                      clockRotation: 180,
                                                      use24HourFormat: true,
                                                      context: context,
                                                    );
                                                    nearbyprovider.setStartTime(
                                                        result.startTime.format(context));
                                                    nearbyprovider.setEndTime(
                                                        result.endTime.format(context));
                                                  },
                                                ),
                                           ],
                                         ),
                                       ),
                                     ],
                                   ),
                                    //  Column(
                                    //    children: [
                                    //      Padding(
                                    //        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    //        child: Row(
                                    //          children: [
                                    //            IconButton(
                                    //                   icon: const Icon(
                                    //                     Icons.tune_rounded,
                                    //                     color: Colors.black,
                                    //                     size: 30,
                                    //                   ),
                                    //                   onPressed: () async {
                                    //                     nearbyprovider.DistancePop(context);
                                    //                   },
                                    //                 ),
                                    //          ],
                                    //        ),
                                    //      ),
                                    //    ],
                                    //  ),
                                 ],
                               ),
                                ],
                              ),
                               

                              
                              
                              
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              FutureBuilder<List<NearbyDeviceModel>>(
                  future: nearbyprovider.fetchNearbyDeivces(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.length == 0) {
                        return Expanded(
                          child: Container(
                            alignment: AlignmentDirectional.center,
                            child: AutoSizeText("No nearby devices recorded",
                                style: GoogleFonts.raleway(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18.0),
                                textAlign: TextAlign.start
                                // maxLines: 2,
                                ),
                          ),
                        );
                      }
                      return Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 1,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            // mainAxisExtent: 50,
                                            crossAxisCount: 2,
                                            childAspectRatio: 3 / 2,
                                            crossAxisSpacing: 20,
                                            mainAxisSpacing: 20),
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (BuildContext ctx, index) {
                                      return Container(
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AutoSizeText((snapshot.data![index].device
                                                .deviceName),
                                                 textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w800)
                                                ),
                                            AutoSizeText(("on ${nearbyprovider.formatReadeableDate(snapshot
                                                .data![index].trackingTime) }"),
                                                 style:GoogleFonts.poppins(
                                                      fontSize: 12.0,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.normal)
                                                ),
                                            AutoSizeText(("at ${nearbyprovider.formatReadeableTime(snapshot
                                                .data![index].trackingTime)}"),
                                                 style:GoogleFonts.poppins(
                                                      fontSize: 12.0,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.normal)
                                            ),
                                                
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.white60,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                      );
                                    }),
                              ),
                            )
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Expanded(
                        child: Container(
                          alignment: AlignmentDirectional.center,
                          child: AutoSizeText("${snapshot.error}",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18.0),
                              textAlign: TextAlign.start
                              // maxLines: 2,
                              ),
                        ),
                      );
                    }
                    return Expanded(
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        child: const CircularProgressIndicator(),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}


// Column(
//               children: [
//                 Expanded(
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         width: MediaQuery.of(context).size.width,
//                         height: MediaQuery.of(context).size.height * 1,
//                         // decoration: BoxDecoration(
//                         //   color: Color(0xFF4E4E4E),
//                         // ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: GridView.builder(
//                               gridDelegate:
//                                   const SliverGridDelegateWithFixedCrossAxisCount(
//                                       mainAxisExtent: 200,
//                                       crossAxisCount: 2,
//                                       childAspectRatio: 3 /
//                                           2, //MediaQuery.of(context).size.width (MediaQuery.of(context).size.height / 4)
//                                       crossAxisSpacing: 20,
//                                       mainAxisSpacing: 20),
//                               itemCount: myProducts.length,
//                               itemBuilder: (BuildContext ctx, index) {
//                                 return Container(
//                                   alignment: Alignment.center,
//                                   child: Text(myProducts[index]["name"]),
//                                   decoration: BoxDecoration(
//                                       color: Colors.amber,
//                                       borderRadius: BorderRadius.circular(15)),
//                                 );
//                               }),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             )



//  Row(
//                           children: [
//                             AutoSizeText(
//                               'Filter Device',
//                               textAlign: TextAlign.center,
//                               style: GoogleFonts.raleway(
//                                 color: Colors.white,
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             )
//                           ],
//                         ),