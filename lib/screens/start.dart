import 'dart:io';
import 'dart:ui';
import '../providers/location_provider.dart';
import '../services/storage_service.dart';
import '/providers/connection_check_provider.dart';
import '/providers/start_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../services/location_service.dart';

//*************************** PAGE SHOWS START TRACING *********************
//BECAME FRONTPAGE AFTER USER SUCESSFULL REGISTER AND CREATED PROFILE
//TODO
//1. Implement contious internet check and server check
//2.need a way to stop foreground service if user click stop tracing -- now its closing app

class StartWidget extends StatefulWidget {
  const StartWidget({Key? key}) : super(key: key);

  @override
  _StartWidgetState createState() => _StartWidgetState();
}

class _StartWidgetState extends State<StartWidget> {

 @override
  initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      // Deviceprovider deviceprovider =
      //     Provider.of<Deviceprovider>(context, listen: false);
      ConnectionCheckprovider conProvider =
          Provider.of<ConnectionCheckprovider>(context, listen: false);
      conProvider
          .hasNetwork(); //check internet and server when app initilaze---must be implement in start page
    
     Startprovider startproviders =
        Provider.of<Startprovider>(context, listen: false);
      startproviders.checkStatus();

    //    LocationProvider locationProvider = Provider.of<LocationProvider>(context,listen: false);
    // locationProvider.inizialize();

      
    });
  }


  @override
  Widget build(BuildContext context) {
    // LocationService locationService =
    //     Provider.of<LocationService>(context, listen: true);

    
    Startprovider startprovider =
        Provider.of<Startprovider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.history_sharp,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/history');
            },
          )
        ],
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.coronavirus_outlined,
                      color: Colors.white,
                      size: 40,
                    ),
                    AutoSizeText(
                      'CovTrack',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      'Stop the spread',
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: GoogleFonts.raleway(
                        color: const Color(0xFFBBBCBD),
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      'lets beat Covid',
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: GoogleFonts.raleway(
                        color: const Color(0xFFBBBCBD),
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    )
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.6,
                      decoration: const BoxDecoration(
                        color: Color(0x00EEEEEE),
                      ),
                      child: Image.asset(
                        'assets/StatIMG.png',
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 1,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    startprovider.isExposed
                        ? Positioned(
                            left: 25,
                            top: MediaQuery.of(context).size.height / 9.5,
                            child: Row(
                              // mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRect(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 3,
                                      sigmaY: 3,
                                    ),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width -
                                          50,
                                      height: 200,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.red.withOpacity(0.4),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            width: 1.2,
                                            color:
                                                Colors.white.withOpacity(0.3),
                                          )),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 8, 8, 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: const [
                                                    Icon(
                                                      Icons.notifications_on,
                                                      color: Colors.white,
                                                      size: 40,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    IconButton(
                                                      icon: const Icon(
                                                        Icons.close,
                                                        color: Colors.white,
                                                        size: 30,
                                                      ),
                                                      onPressed: () {
                                                        startprovider
                                                            .setIsExposed(
                                                                false);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                5, 0, 5, 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                AutoSizeText(
                                                    'You had a contact with  COVID-19 \n positive person',
                                                    textAlign: TextAlign.center,
                                                    // maxLines: 2,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 15.0,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w800)),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                AutoSizeText(
                                                    'Qurentine: \n ${startprovider.remainingTime} Days Remain',
                                                    textAlign: TextAlign.center,
                                                    maxLines: 2,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 18.0,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w800))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        : const SizedBox(
                            child: Text(""),
                          ),
                    Positioned(
                      left: (MediaQuery.of(context).size.width - 290) / 2,
                      top: MediaQuery.of(context).size.height / 2.4,
                      child: Row(
                        // mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 3,
                                sigmaY: 3,
                              ),
                              child: Container(
                                width: 290,
                                height: 115,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      width: 1.2,
                                      color: Colors.white.withOpacity(0.3),
                                    )),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          AutoSizeText(
                                              'Have you tested postive \n for COVID-19 ?',
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w800))
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 6, 0, 4),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              startprovider.pcrPOP(context);
                                            },
                                            child: Container(
                                              width: 130,
                                              height: 38,
                                              decoration: BoxDecoration(
                                                color: Colors.amber,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .warning_amber_rounded,
                                                      // color: Colors.white,
                                                      size: 20,
                                                    ),
                                                    AutoSizeText('Report',
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 14.0,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Row(
                    // mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => {
                                  Navigator.pushNamed(context, '/main')
                                },
                        child: Container(
                          width: 230,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          child: Container(
                                  child:AutoSizeText('Continue',
                                          style: GoogleFonts.raleway(
                                              fontSize: 18.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700))
                                ),
                        ),
                        // child: Container(
                        //   width: 230,
                        //   height: 50,
                        //   alignment: Alignment.center,
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(15),
                        //       color: locationService.clicks
                        //           ? Colors.red[500]
                        //           : Colors.white),
                        //   child: locationService.loader
                        //       ? const CircularProgressIndicator()
                        //       : Container(
                        //           child: locationService.clicks
                        //               ? AutoSizeText('Stop Tracing',
                        //                   style: GoogleFonts.raleway(
                        //                       fontSize: 18.0,
                        //                       color: Colors.white,
                        //                       fontWeight: FontWeight.w700))
                        //               : Text('Start Tracing',
                        //                   style: GoogleFonts.raleway(
                        //                       fontSize: 18.0,
                        //                       color: Colors.black,
                        //                       fontWeight: FontWeight.w700)),
                        //         ),
                        // ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
