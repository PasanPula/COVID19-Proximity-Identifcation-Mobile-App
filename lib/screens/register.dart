import 'package:auto_size_text/auto_size_text.dart';
import '/providers/connection_check_provider.dart';
import '/providers/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

//***************************************SCREEEN USE FOR USER REGISTRSTION ************************
//TODO
//1.NEED TO IMPLEMENT PROVIDER

class _RegisterWidgetState extends State<RegisterWidget> {
  @override
  void initState() {
    super.initState();
    // mobilenumberController = TextEditingController();
    // firstNameController = TextEditingController();
    // nICNumberController = TextEditingController();
    // lastnameController = TextEditingController();
    // // passwordController = TextEditingController();
    // // passwordConfirmController = TextEditingController();
    // // passwordVisibility = false;
    // // passwordConfirmVisibility = false;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      ConnectionCheckprovider conProvider =
          Provider.of<ConnectionCheckprovider>(context, listen: false);
      conProvider
          .hasNetwork(); //check internet and server when app initilaze---must be implement in start page
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Registerprovider registerprovider =
          Provider.of<Registerprovider>(context, listen: false);
      registerprovider.firstNameController.dispose();
      registerprovider.nicNumberController.dispose();
      registerprovider.lastnameController.dispose();
      registerprovider.mobilenumberController.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ConnectionCheckprovider conProvider =
        Provider.of<ConnectionCheckprovider>(context, listen: true);
    Registerprovider registerprovider =
        Provider.of<Registerprovider>(context, listen: true);

    if (conProvider.hasInternet == false) {
      //show on no internet
      Future.delayed(Duration.zero, () => conProvider.noNetwork(context));
    }
    if (conProvider.isServerRun == false) {
      //show on server fail
      Future.delayed(Duration.zero, () => conProvider.serverFail(context));
    }

    return Form(
      key: registerprovider.formkey,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            'Welcome to Covtrack!',
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: GoogleFonts.raleway(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 3, 0, 30),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            'Let’s get you registered ',
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            style: GoogleFonts.raleway(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextFormField(
                              autofocus: false,
                              maxLength: 12,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              cursorColor: Colors.white,
                              controller: registerprovider.nicNumberController,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'NIC Number',
                                labelStyle: GoogleFonts.lexendDeca(
                                  color: const Color(0xFF95A1AC),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                hintText: '9XXXXXXXXV / XXXXXXXXXXXX',
                                hintStyle: GoogleFonts.lexendDeca(
                                  color: const Color(0xFF95A1AC),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: const Color(0x2355297C),
                                contentPadding:
                                    const EdgeInsetsDirectional.fromSTEB(
                                        16, 24, 0, 24),
                              ),
                              style: GoogleFonts.lexendDeca(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Field is required';
                                }

                                if ((registerprovider.isNumeric(val) &&
                                    val.length == 12)) {
                                  return null;
                                }

                                if ((val.length == 10 &&
                                    registerprovider
                                        .isNumeric(val.substring(0, 9)) &&
                                    ['v'].contains(
                                        val.substring(9).toLowerCase()))) {
                                  return null;
                                }

                                return 'Invalid NIC';
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextFormField(
                              autofocus: false,
                              maxLength: 12,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              cursorColor: Colors.white,
                              controller: registerprovider.firstNameController,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Firstname',
                                labelStyle: GoogleFonts.lexendDeca(
                                  color: const Color(0xFF95A1AC),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                hintText: 'Enter your Firstname here...',
                                hintStyle: GoogleFonts.lexendDeca(
                                  color: const Color(0xFF95A1AC),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFFDBE2E7),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFFDBE2E7),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: const Color(0x2355297C),
                                contentPadding:
                                    const EdgeInsetsDirectional.fromSTEB(
                                        16, 24, 0, 24),
                              ),
                              style: GoogleFonts.lexendDeca(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Field is required';
                                }

                                if (!registerprovider.isAplph(val)) {
                                  return 'Reqiured only Letters';
                                }

                                return null;
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: TextFormField(
                              autofocus: false,
                              maxLength: 12,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: registerprovider.lastnameController,
                              obscureText: false,
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                labelText: 'Lastname',
                                labelStyle: GoogleFonts.lexendDeca(
                                  color: const Color(0xFF95A1AC),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                hintText: 'Enter your Lastname here...',
                                hintStyle: GoogleFonts.lexendDeca(
                                  color: const Color(0xFF95A1AC),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFFDBE2E7),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFFDBE2E7),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: const Color(0x2355297C),
                                contentPadding:
                                    const EdgeInsetsDirectional.fromSTEB(
                                        16, 24, 0, 24),
                              ),
                              style: GoogleFonts.lexendDeca(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Field is required';
                                }

                                if (!registerprovider.isAplph(val)) {
                                  return 'Reqiured only Letters';
                                }
                                return null;
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Container(
                          // margin:
                          //     const EdgeInsetsDirectional.fromSTEB(0, 0, 00, 0),
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                  color: Color(0xFFDBE2E7),
                                  width: 2,
                                ),
                                left: BorderSide(
                                  color: Color(0xFFDBE2E7),
                                  width: 2,
                                ),
                                top: BorderSide(
                                  color: Color(0xFFDBE2E7),
                                  width: 2,
                                ),
                                right: BorderSide(
                                  color: Color(0xFFDBE2E7),
                                  width: 2,
                                )),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            shape: BoxShape.rectangle,
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                20, 10, 20, 10),
                            child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                              value: registerprovider.dropDownValue,
                              icon: const Icon(Icons.arrow_drop_down_circle),
                              items:
                                  registerprovider.TypeList.map((String items) {
                                return DropdownMenuItem(
                                    value: items,
                                    child: AutoSizeText('${items.toString()}',
                                        style: GoogleFonts.lexendDeca(
                                            fontSize: 14.0)));
                              }).toList(),
                              onChanged: (String? newValue) {
                                registerprovider.setDropDownValue(newValue!);
                              },
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              style: GoogleFonts.lexendDeca(fontSize: 14.0),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              hint: AutoSizeText(
                                "Please choose a Type",
                                style: GoogleFonts.lexendDeca(
                                    color: const Color(0xFF95A1AC),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              isExpanded: true,
                            )),
                          )),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: TextFormField(
                              autofocus: false,
                              maxLength: 10,
                              cursorColor: Colors.white,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller:
                                  registerprovider.mobilenumberController,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Mobile Number',
                                labelStyle: GoogleFonts.lexendDeca(
                                  color: const Color(0xFF95A1AC),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                hintText: '07XXXXXXX',
                                hintStyle: GoogleFonts.lexendDeca(
                                  color: const Color(0xFF95A1AC),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFFDBE2E7),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFFDBE2E7),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: const Color(0x2355297C),
                                contentPadding:
                                    const EdgeInsetsDirectional.fromSTEB(
                                        16, 24, 0, 24),
                              ),
                              style: GoogleFonts.lexendDeca(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                              keyboardType: TextInputType.phone,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Field is required';
                                }

                                if (val.length >= 2) {
                                  if (!(val.substring(0, 2) == '07')) {
                                    return 'Enter Valid MobileNumber';
                                  }
                                }

                                if (val.length != 10) {
                                  return 'Enter Valid MobileNumber';
                                }

                                return null;
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    //*********************************** Passsowrd Fields *************************************************
                    // Padding(
                    //   padding:
                    //       const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    //   child: Row(
                    //     mainAxisSize: MainAxisSize.max,
                    //     children: [
                    //       Expanded(
                    //         child: TextFormField(
                    //           autovalidateMode:
                    //               AutovalidateMode.onUserInteraction,
                    //           controller: passwordController,
                    //           obscureText: !passwordVisibility,
                    //           decoration: InputDecoration(
                    //             labelText: 'Password',
                    //             labelStyle: GoogleFonts.lexendDeca(
                    //               color: const Color(0xFF95A1AC),
                    //               fontSize: 14,
                    //               fontWeight: FontWeight.normal,
                    //             ),
                    //             hintText: 'Create password here...',
                    //             hintStyle: GoogleFonts.lexendDeca(
                    //               color: const Color(0xFF95A1AC),
                    //               fontSize: 14,
                    //               fontWeight: FontWeight.normal,
                    //             ),
                    //             errorBorder: OutlineInputBorder(
                    //               borderSide: const BorderSide(
                    //                 color: Colors.red,
                    //                 width: 2,
                    //               ),
                    //               borderRadius: BorderRadius.circular(8),
                    //             ),
                    //             enabledBorder: OutlineInputBorder(
                    //               borderSide: const BorderSide(
                    //                 color: Color(0xFFDBE2E7),
                    //                 width: 2,
                    //               ),
                    //               borderRadius: BorderRadius.circular(8),
                    //             ),
                    //             focusedBorder: OutlineInputBorder(
                    //               borderSide: const BorderSide(
                    //                 color: Color(0xFFDBE2E7),
                    //                 width: 2,
                    //               ),
                    //               borderRadius: BorderRadius.circular(8),
                    //             ),
                    //             focusedErrorBorder: OutlineInputBorder(
                    //               borderSide: const BorderSide(
                    //                 color: Colors.red,
                    //                 width: 2,
                    //               ),
                    //               borderRadius: BorderRadius.circular(8),
                    //             ),
                    //             filled: true,
                    //             fillColor: const Color(0x2355297C),
                    //             contentPadding:
                    //                 const EdgeInsetsDirectional.fromSTEB(
                    //                     16, 24, 0, 24),
                    //             suffixIcon: InkWell(
                    //               onTap: () => setState(
                    //                 () => passwordVisibility =
                    //                     !passwordVisibility,
                    //               ),
                    //               child: Icon(
                    //                 passwordVisibility
                    //                     ? Icons.visibility_outlined
                    //                     : Icons.visibility_off_outlined,
                    //                 color: Color(0xFFDBE2E7),
                    //                 size: 22,
                    //               ),
                    //             ),
                    //           ),
                    //           style: GoogleFonts.lexendDeca(
                    //             color: Colors.white,
                    //             fontSize: 14,
                    //             fontWeight: FontWeight.normal,
                    //           ),
                    //           validator: (val) {
                    //             if (val!.isEmpty) {
                    //               return 'Field is required';
                    //             }

                    //             return null;
                    //           },
                    //           onChanged: (val) {
                    //             setState(() {
                    //               password = val;
                    //             });
                    //           },
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // Padding(
                    //   padding:
                    //       const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    //   child: Row(
                    //     mainAxisSize: MainAxisSize.max,
                    //     children: [
                    //       Expanded(
                    //         child: TextFormField(
                    //           autovalidateMode:
                    //               AutovalidateMode.onUserInteraction,
                    //           controller: passwordConfirmController,
                    //           obscureText: !passwordConfirmVisibility,
                    //           decoration: InputDecoration(
                    //             labelText: 'Confirm Password',
                    //             labelStyle: GoogleFonts.lexendDeca(
                    //               color: const Color(0xFF95A1AC),
                    //               fontSize: 14,
                    //               fontWeight: FontWeight.normal,
                    //             ),
                    //             hintText: 'Confirm your password here...',
                    //             hintStyle: GoogleFonts.lexendDeca(
                    //               color: const Color(0xFF95A1AC),
                    //               fontSize: 14,
                    //               fontWeight: FontWeight.normal,
                    //             ),
                    //             errorBorder: OutlineInputBorder(
                    //               borderSide: const BorderSide(
                    //                 color: Colors.red,
                    //                 width: 2,
                    //               ),
                    //               borderRadius: BorderRadius.circular(8),
                    //             ),
                    //             enabledBorder: OutlineInputBorder(
                    //               borderSide: const BorderSide(
                    //                 color: Color(0xFFDBE2E7),
                    //                 width: 2,
                    //               ),
                    //               borderRadius: BorderRadius.circular(8),
                    //             ),
                    //             focusedBorder: OutlineInputBorder(
                    //               borderSide: const BorderSide(
                    //                 color: Color(0xFFDBE2E7),
                    //                 width: 2,
                    //               ),
                    //               borderRadius: BorderRadius.circular(8),
                    //             ),
                    //             focusedErrorBorder: OutlineInputBorder(
                    //               borderSide: const BorderSide(
                    //                 color: Colors.red,
                    //                 width: 2,
                    //               ),
                    //               borderRadius: BorderRadius.circular(8),
                    //             ),
                    //             filled: true,
                    //             fillColor: const Color(0x2355297C),
                    //             contentPadding:
                    //                 const EdgeInsetsDirectional.fromSTEB(
                    //                     16, 24, 0, 24),
                    //             suffixIcon: InkWell(
                    //               onTap: () => setState(
                    //                 () => passwordConfirmVisibility =
                    //                     !passwordConfirmVisibility,
                    //               ),
                    //               child: Icon(
                    //                 passwordConfirmVisibility
                    //                     ? Icons.visibility_outlined
                    //                     : Icons.visibility_off_outlined,
                    //                 color: Color(0xFFDBE2E7),
                    //                 size: 22,
                    //               ),
                    //             ),
                    //           ),
                    //           style: GoogleFonts.lexendDeca(
                    //             color: Colors.white,
                    //             fontSize: 14,
                    //             fontWeight: FontWeight.normal,
                    //           ),
                    //           validator: (val) {
                    //             if (val!.isEmpty) {
                    //               return 'Field is required';
                    //             }
                    //             if (val != password) {
                    //               return 'Password must be match ';
                    //             }

                    //             return null;
                    //           },
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () => {
                                  registerprovider.onSubmit(context),
                                  FocusScope.of(context).unfocus(),
                                },
                                child: Container(
                                  width: 170,
                                  height: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white),
                                  child: Container(
                                    child: AutoSizeText('Submit',
                                        style: GoogleFonts.raleway(
                                            fontSize: 15.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700)),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
