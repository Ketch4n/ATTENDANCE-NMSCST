import 'package:attendance_nmscst/src/authentication/login/functions/login.dart';
import 'package:attendance_nmscst/src/components/snackbar.dart';
import 'package:attendance_nmscst/src/data/constant/constant_text_controller.dart';

void onSubmit(context) async {
  final email = controller.email.text.trim();
  final password = controller.pass.text.trim();
  if (email.isEmpty || password.isEmpty) {
    customSnackBar(context, 1, "Username or Password Empty!");
    return;
  } else {
    login(context, email, password);
  }
}
