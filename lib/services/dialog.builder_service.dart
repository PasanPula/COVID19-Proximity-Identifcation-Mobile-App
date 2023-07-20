import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//************************************** GENARATE LOADING INDICATOR DIALOG BOX FOR DISPLAY PURPOSE **************************

class DialogBuilder {
  DialogBuilder(this.context);

  final BuildContext context;

  showLoadingIndicator([String? text]) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: CupertinoAlertDialog(
              content: LoadingIndicator(text: text),
            ));
      },
    );
  }

  hideOpenDialog() {
    Navigator.of(context, rootNavigator: true).pop(context);
  }
}

//LOADING INDICATOR WIDGET
class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key, this.text = ''}) : super(key: key);

  final String? text;

  @override
  Widget build(BuildContext context) {
    var displayedText = text;

    return Container(
        padding: const EdgeInsets.all(16),
        // color: Colors.black87,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _getLoadingIndicator(),
              _getHeading(context),
              _getText(displayedText)
            ]));
  }

  Padding _getLoadingIndicator() {
    return Padding(
        child: Container(
            child: const CircularProgressIndicator(strokeWidth: 3),
            width: 32,
            height: 32),
        padding: const EdgeInsets.only(bottom: 16));
  }

  Widget _getHeading(context) {
    return const Padding(
        child: Text(
          'Please wait …',
          style: TextStyle(color: Colors.white, fontSize: 16),
          textAlign: TextAlign.center,
        ),
        padding: EdgeInsets.only(bottom: 4));
  }

  Text _getText(String? displayedText) {
    return Text(
      displayedText!,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      textAlign: TextAlign.center,
    );
  }
}
