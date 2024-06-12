import 'package:core/presentation/ui/dialogs/error_alert_dialog.dart';
import 'package:core/presentation/ui/dialogs/warning_alert_dialog.dart';
import 'package:flutter/material.dart';

class DialogService {
  static void showErrorDialog(BuildContext context, String errMsg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ErrorAlertDialog(message: errMsg);
      },
    );
  }

  static void showErrorDialogWarning(BuildContext context, String errMsg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WarningAlertDialog(message: errMsg);
      },
    );
  }
}
