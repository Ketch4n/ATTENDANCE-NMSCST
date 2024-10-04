import 'package:attendance_nmscst/src/authentication/auth/auth_index.dart';
import 'package:attendance_nmscst/src/data/firebase/initialize.dart';
import 'package:attendance_nmscst/src/data/provider/indexed_stack_pages.dart';
import 'package:attendance_nmscst/src/data/provider/textfield_body.dart';
import 'package:attendance_nmscst/src/data/provider/user_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await initializeFirebase();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserSessionEvent()),
        ChangeNotifierProvider(create: (_) => IndexedStackPagesEvent()),
        ChangeNotifierProvider(create: (_) => TextfieldBody())
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthIndex(),
    );
  }
}
