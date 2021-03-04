import 'package:flutter/material.dart';
import 'package:time_store/plugin/locator.dart';
import 'package:time_store/plugin/navigator.dart';

enum DialogType { NONE, YES_NO, CONFIRM_CANCEL, CANCEL }

final currentContext = locator<NavigationService>().navigatorKey.currentState.overlay.context;

abstract class DialogBuilder {
  static void buildLoadingDialog() {
    showDialog(
        context: currentContext,
        barrierDismissible: false,
        barrierColor: Theme.of(currentContext).disabledColor.withOpacity(0.3),
        builder: (_) {
          return WillPopScope(
              child: Center(
                child: SizedBox(
                  height: 32,
                  width: 32,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    backgroundColor: Theme.of(currentContext).scaffoldBackgroundColor.withOpacity(0.03),
                  ),
                ),
              ),
              onWillPop: () async => false);
        });
  }

  static Future<bool> buildConfirmDialog({BuildContext context, String message}) async {
    Widget cancelButton = TextButton(
      child: Text(
        'Cancel',
        style: TextStyle(color: Colors.black, fontSize: 40),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop(false);
      },
    );

    Widget okButton = TextButton(
      child: Text(
        'Confirm',
        style: TextStyle(color: Colors.black, fontSize: 40),
      ),
      onPressed: () async {
        Navigator.of(context, rootNavigator: true).pop(true);
      },
    );

    Widget _content = Container(
      padding: const EdgeInsets.only(top: 40, bottom: 20, left: 60, right: 60),
      child: Column(
        children: [
          Text(
            message ?? '',
            style: TextStyle(color: Colors.black, fontSize: 40),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );

    AlertDialog alert = AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      actionsPadding: const EdgeInsets.all(0),
      content: Container(
        width: MediaQuery.of(context).size.width,
        constraints: BoxConstraints(minHeight: 200),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _content,
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFFDDDEDF),
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: okButton,
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFDDDEDF), width: 0.5),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                        )),
                    child: cancelButton,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );

    bool result = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => alert,
    );
    return result;
  }
}
