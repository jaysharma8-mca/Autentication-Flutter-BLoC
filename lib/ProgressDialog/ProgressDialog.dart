import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ProgressDialogBox {
  void showProgressDialog(BuildContext context, String message) {
    ProgressDialog pr;
    pr = new ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
    );
    pr.style(message: message);
    pr.show();
  }

  void dismissProgressDialog(BuildContext context) {
    ProgressDialog pr;
    pr = new ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
    );
    pr.hide();
  }
}
