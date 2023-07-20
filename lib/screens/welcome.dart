import 'package:auto_size_text/auto_size_text.dart';
// import 'package:covtrack_demo/services/storage_service.dart';
import '/providers/connection_check_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

//*************************First page -onboaring page visible only first time login ***********************************
// used only device provider
class WelcomePageWidget extends StatefulWidget {
  const WelcomePageWidget({Key? key}) : super(key: key);

  @override
  _WelcomePageWidgetState createState() => _WelcomePageWidgetState();
}

class _WelcomePageWidgetState extends State<WelcomePageWidget> {
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      // Deviceprovider deviceprovider =
      //     Provider.of<Deviceprovider>(context, listen: false);
      ConnectionCheckprovider conProvider =
          Provider.of<ConnectionCheckprovider>(context, listen: false);
      conProvider
          .hasNetwork(); //check internet and server when app initilaze---must be implement in start page
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Deviceprovider deviceprovider =
    //     Provider.of<Deviceprovider>(context, listen: true);
    ConnectionCheckprovider conProvider =
        Provider.of<ConnectionCheckprovider>(context, listen: true);

    if (conProvider.hasInternet == false) {
      //show on no internet
      Future.delayed(Duration.zero, () => conProvider.noNetwork(context));
    }
    if (conProvider.isServerRun == false) {
      //show on server fail
      Future.delayed(Duration.zero, () => conProvider.serverFail(context));
    }

//     if (deviceprovider.isRegisterClicked) {
//       //show on registering happening
//       Future.delayed(Duration.zero, () => deviceprovider.setLoading(context));
//     }

// // on register sucess
//     if (deviceprovider.registerComplete) {
//       //close register loading
//       Future.delayed(Duration.zero, () => deviceprovider.closeLoading(context));
//       //show on sucess registration
//       Future.delayed(
//           Duration.zero, () => deviceprovider.RegisterSucess(context));
//     }

//     //on register fail
//     if (deviceprovider.registerFail) {
//       //hide loading
//       Future.delayed(Duration.zero, () => deviceprovider.closeLoading(context));
//       //show loading
//       Future.delayed(Duration.zero, () => deviceprovider.RegisterFail(context));
//     }

//     //check again if alredy registered and isRtegisteres flag is false **button need to double tap if not
//     deviceprovider.alernativeIsRegistered();

    return Scaffold(
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
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(28, 20, 0, 0),
                  child: Image.asset(
                    'assets/welcIMG.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AutoSizeText('Let’s get started',
                              style: GoogleFonts.raleway(
                                fontSize: 24,
                                color: const Color(0xFF30EAF5),
                                fontWeight: FontWeight.w800,
                              ),
                              maxLines: 1)
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AutoSizeText(
                              'Stop the spread , Save  the lives .\nWe are in this together and we will get \n through this together.\nLet’s each do our part and beat Covid-19 together.  ',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.raleway(
                                fontSize: 14,
                                color: const Color(0xFF81818C),
                              ),
                              maxLines: 4)
                        ],
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 60, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => {
                                // deviceprovider.setbtnColor(false),
                                // Future.delayed(
                                //     const Duration(milliseconds: 2000),
                                //     () => deviceprovider.setbtnColor(true)),
                                // if (deviceprovider.isRegistered)
                                //   {
                                //     deviceprovider.setbtnColor(true),
                                Navigator.pushNamed(context, '/register'),
                                // },
                                // deviceprovider.initilazieDevice(),
                                // register device
                              },
                              child: Container(
                                width: 190,
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white),
                                child: Container(
                                  child: AutoSizeText('Register',
                                      style: GoogleFonts.raleway(
                                          fontSize: 17.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //============== login buttons =====================
                      // Padding(
                      //   padding:
                      //       const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 3),
                      //   child: Row(
                      //     mainAxisSize: MainAxisSize.max,
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Text(
                      //         'Already Registerd?',
                      //         textAlign: TextAlign.center,
                      //         style: GoogleFonts.raleway(
                      //           color: Colors.white,
                      //           fontSize: 15,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // Row(
                      //   mainAxisSize: MainAxisSize.max,
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     GestureDetector(
                      //       onTap: () => {
                      //         StrorageService().removeValues()
                      //         // Navigator.pushNamed(context, '/login')
                      //       },
                      //       child: Container(
                      //         width: 130,
                      //         height: 40,
                      //         alignment: Alignment.center,
                      //         decoration: BoxDecoration(
                      //           border: const Border(
                      //               bottom: BorderSide(
                      //                 color: Color(0xFFDBE2E7),
                      //                 width: 2,
                      //               ),
                      //               left: BorderSide(
                      //                 color: Color(0xFFDBE2E7),
                      //                 width: 2,
                      //               ),
                      //               top: BorderSide(
                      //                 color: Color(0xFFDBE2E7),
                      //                 width: 2,
                      //               ),
                      //               right: BorderSide(
                      //                 color: Color(0xFFDBE2E7),
                      //                 width: 2,
                      //               )),
                      //           borderRadius: BorderRadius.circular(12),
                      //           // color: Colors.white
                      //         ),
                      //         child: Container(
                      //           child: AutoSizeText('Login',
                      //               style: GoogleFonts.raleway(
                      //                   fontSize: 16.0,
                      //                   color: Colors.white,
                      //                   fontWeight: FontWeight.w700)),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
