import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConnectionCheckprovider with ChangeNotifier {
  //for internet and server working check
  bool hasInternet = true;
  bool isServerRun = true;

  hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      hasInternet = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      if (hasInternet) {
        isServerRunning();
      }
    } on SocketException catch (_) {
      hasInternet = false;
    }
    notifyListeners();
  }

  //check server
  isServerRunning() async {
    try {
      final result = await InternetAddress.lookup('194.233.69.253');
      isServerRun = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isServerRun = false;
    }
    notifyListeners();
  }

//alert on no internet
  void noNetwork(BuildContext context) {
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
                    Text("Error"),
                  ],
                ),
              ],
            ),
            content: const Text("Check your internet connection"),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text("Retry"),
                onPressed: () {
                  Navigator.of(context).pop();
                  hasNetwork();
                  if (hasInternet) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        });
  }

//alert on server fail
  void serverFail(BuildContext context) {
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
                    Text("Error"),
                  ],
                ),
              ],
            ),
            content: const Text("Server Error.Try again later"),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text("Retry"),
                onPressed: () {
                  Navigator.of(context).pop();
                  isServerRunning();
                  if (isServerRun) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        });
  }
}
