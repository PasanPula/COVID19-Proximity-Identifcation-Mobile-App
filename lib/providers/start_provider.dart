import 'dart:convert';
import 'package:intl/intl.dart';

import '/models/Expose.Models/expose.payload_model.dart';
import 'package:flutter/cupertino.dart';
import '/services/dialog.builder_service.dart';
import '/services/api%20services/device_api_services.dart';
import '/services/api%20services/user_api_services.dart';
import '/models/Expose.Models/expose_model.dart';
import '/services/storage_service.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Startprovider with ChangeNotifier {
  bool isExposed = false;
  String _date = DateTime.now().toIso8601String();
  late int _deviceId;
  late BuildContext _context;
  int remainingTime = 0;

  setIsExposed(bool val) {
    isExposed = val;
    notifyListeners();
  }

  setRemainingTime(int val) {
    remainingTime = val;
    notifyListeners();
  }

  setDate(String val) {
    _date = val;
    notifyListeners();
  }

  Future<int> getDeviceId() async {
    int deviceId = 0;
    if (await StrorageService().checkID()) {
      deviceId = await StrorageService().getID();
      return deviceId;
    }
    return deviceId;
  }

  late ExposedPayloadModel exposedpayload;


//report positivity
  reportPositive(BuildContext context) async {
    try {
      showloadingIndicate(_context);
      _deviceId = await getDeviceId();
      ExposedModel exposeModel =
          ExposedModel(deviceId: _deviceId, pCRDate: _date);
      var response = await UserApiServices().markAffected(exposeModel);

      hideloadingIndicate(_context);
      if (response.statusCode == 200) {
        reportSucessDialog(_context);
        var _jsonResponse = json.decode(response.body);
        exposedpayload = ExposedPayloadModel.fromJsonExpose(_jsonResponse);
        if (exposedpayload.exposedModelList.isNotEmpty) {
          //get last date in affected date
          var date = exposedpayload
              .exposedModelList[exposedpayload.exposedModelList.length - 1]
              .pCRDate;
          //add 14 days to affecetd date
          date = DateFormat("yyyy-MM-dd")
              .format(DateTime.parse(date!).add(const Duration(days: 14)));
          // print("after add 14 days : ${date}");
          //save on local storage
          StrorageService().setQurentineEndDate(date);
          //set exposed
          StrorageService().setIsExposed(true);

          // print("after date difference : ${DateTime.parse(date).difference(DateTime.now()).inDays}");

          //count remain days and update UI
          // setRemainingTime(
          //     DateTime.now().difference(DateTime.parse(date)).inDays); //bakcup CHANGE BEACUSE OF NEAGTIVE NUMBER
        
        setRemainingTime(
              DateTime.parse(date).difference(DateTime.now()).inDays);

          //show alert banner
          setIsExposed(true);
        }
      } else {
        reportFailDialog(_context);
      }
    } catch (e) {
      hideloadingIndicate(_context);
      throw Exception(e);
    }
  }

  late ExposedPayloadModel exposedpayloadStatus;

//Bug

  checkStatus() async {
    try {
      var checkIsExposed = await StrorageService().checkIsExposed();

      if (checkIsExposed) {
        var affectedDate = await StrorageService().getQurentineEndDate();
        setIsExposed(true);
        setRemainingTime(
            DateTime.parse(affectedDate).difference(DateTime.now()).inDays);
      } else {
        var response = await DeviceApiService().checkStatus();
        var _jsonResponse = json.decode(response.body);
        exposedpayloadStatus =
            ExposedPayloadModel.fromJsonStatus(_jsonResponse);
        if (exposedpayloadStatus.exposedModelList.isNotEmpty &&
            exposedpayloadStatus
                .exposedModelList[
                    exposedpayloadStatus.exposedModelList.length - 1]
                .affectedDates!
                .isNotEmpty) {
        
         //get last date in affected date
        var date = exposedpayloadStatus
              .exposedModelList[
                  exposedpayloadStatus.exposedModelList.length - 1]
              .affectedDates![0];

         //add 14 days to affecetd date
          date = DateFormat("yyyy-MM-dd")
              .format(DateTime.parse(date).add(const Duration(days: 14)));
          
          StrorageService().setQurentineEndDate(date);
          //set exposed
          StrorageService().setIsExposed(true);
          //count remain days and update UI
          setRemainingTime(
              DateTime.now().difference(DateTime.parse(date)).inDays);
          //show alert banner
          setIsExposed(true);
        
        }
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  void showloadingIndicate(BuildContext context) {
    DialogBuilder(context).showLoadingIndicator("Reporting Exposed details");
  }

  void hideloadingIndicate(BuildContext context) {
    DialogBuilder(context).hideOpenDialog();
  }

  //sucess popup
  void reportSucessDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.done_rounded,
                      color: Colors.green,
                    ),
                    Text("Sucess"),
                  ],
                ),
              ],
            ),
            content: const Text(
                "Sucessfully Reported.Thank you for doing your part."),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text("Done"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  //s=fail popup
  void reportFailDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.error_outline,
                      color: Colors.red,
                    ),
                    Text("Failed"),
                  ],
                ),
              ],
            ),
            content: const Text("Report failed"),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text("Done"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

//pcr date select popup
  void pcrPOP(BuildContext context) {
    _context = context;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              "Select PCR report Date",
              style: GoogleFonts.raleway(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w800),
            ),
            content: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: DatePicker(
                      DateTime.now().subtract(const Duration(days: 21)),
                      initialSelectedDate: DateTime.now(),
                      daysCount: 22,
                      selectionColor: Colors.red,
                      selectedTextColor: Colors.white,
                      onDateChange: (date) {
                        setDate(date.toIso8601String());
                      },
                    ),
                  ),
                  const Icon(Icons.arrow_right_rounded,
                      color: Colors.black87, size: 30),
                ],
              ),
            ),
            actions: <Widget>[
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => {
                        Navigator.of(context).pop(),
                        reportPositive(context)
                      },
                      child: Container(
                        width: 140,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.warning_amber_rounded,
                              // color: Colors.white,
                              size: 20,
                            ),
                            Text('Report',
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800)),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => {Navigator.of(context).pop()},
                      child: Container(
                        width: 120,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Cancel',
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
