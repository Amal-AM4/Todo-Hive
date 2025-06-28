import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:todo/main.dart';
import 'package:todo/utils/app_str.dart';

String lottieURL = 'assets/lottie/1.json';

// Empty Title or subtile textfield warning
dynamic emptyWarning(BuildContext context) {
  return FToast.toast(
    context,
    msg: AppStr.oopsMsg,
    subMsg: 'You Must fill all fields',
    corner: 20.0,
    duration: 2000,
    padding: EdgeInsets.all(20),
  );
}

// Nothing Entered when user try to edit or update the current task
dynamic updateTaskWarning(BuildContext context) {
  return FToast.toast(
    context,
    msg: AppStr.oopsMsg,
    subMsg: 'You must edit the tasks then try to update it!',
    corner: 20.0,
    duration: 3000,
    padding: EdgeInsets.all(20),
  );
}

// No task warning dialog for deleting
dynamic noTaskWarning(BuildContext context) {
  return PanaraInfoDialog.showAnimatedGrow(
    context,
    title: AppStr.oopsMsg,
    message:
        "There is no Task For Delete!\n Try adding some and then try to delete it!",
    buttonText: "Okay",
    onTapDismiss: () {
      Navigator.pop(context);
    },
    panaraDialogType: PanaraDialogType.warning, // ✅ Capitalized Enum
  );
}

// Delete All task from db dialog
dynamic deleteAllTask(BuildContext context) {
  return PanaraConfirmDialog.show(
    context,
    title: AppStr.areYouSure,
    message:
        "Do you really want to delete all tasks? You will not be able to undo this action!",
    confirmButtonText: "Yes",
    cancelButtonText: "No",
    onTapConfirm: () {
      // BaseWidget.of(context).dataStore.box.clear();
      Navigator.of(context).pop(); // ✅ Close dialog first
    },
    onTapCancel: () {
      Navigator.of(context).pop(); // ✅ Close dialog
    },
    panaraDialogType: PanaraDialogType.error,
    barrierDismissible: true, // optional
  );
}
