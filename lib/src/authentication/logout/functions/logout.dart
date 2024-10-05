import 'package:attendance_nmscst/src/authentication/logout/functions/remove_sharedpref.dart';
import 'package:attendance_nmscst/src/components/confirmation_dialog.dart';

Future<void> logout(context) async {
  confirmationDialog(
    context,
    "Confirm Logout ?",
    "Login again if you decide to come back",
    () => removeSharedPref(context),
  );
}
