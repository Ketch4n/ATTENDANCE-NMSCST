import 'package:attendance_nmscst/src/authentication/auth/auth_index.dart';
import 'package:attendance_nmscst/src/components/demo_mode_banner.dart';
import 'package:attendance_nmscst/src/components/demo_mode_dialog.dart';
import 'package:attendance_nmscst/src/data/firebase/initialize.dart';
import 'package:attendance_nmscst/src/data/provider/demo_mode_provider.dart';
import 'package:attendance_nmscst/src/data/provider/indexed_stack_pages.dart';
import 'package:attendance_nmscst/src/data/provider/textfield_body.dart';
import 'package:attendance_nmscst/src/data/provider/user_session.dart';
import 'package:attendance_nmscst/src/data/services/api_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserSessionEvent()),
        ChangeNotifierProvider(create: (_) => IndexedStackPagesEvent()),
        ChangeNotifierProvider(create: (_) => TextfieldBody()),
        ChangeNotifierProvider(create: (_) => DemoModeProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      home: const AppShell(),
    );
  }
}

/// AppShell sits inside MaterialApp so it has a valid Navigator and Overlay.
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  @override
  void initState() {
    super.initState();
    // Use post-frame callback so the widget tree (and Navigator) is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkApiConnectivity();
    });
  }

  Future<void> _checkApiConnectivity() async {
    if (!mounted) return;

    final demoModeProvider =
        Provider.of<DemoModeProvider>(context, listen: false);

    if (demoModeProvider.hasCheckedConnectivity) return;

    final isConnected = await ApiService.checkApiConnectivity();

    if (!mounted) return;

    if (!isConnected) {
      await DemoModeDialog.show(context);
    } else {
      demoModeProvider.setConnectivityChecked();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DemoModeProvider>(
      builder: (context, demoMode, child) {
        return Column(
          children: [
            if (demoMode.isDemoMode) const DemoModeBanner(),
            const Expanded(child: AuthIndex()),
          ],
        );
      },
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
