import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart'; 

import 'src/configs/configs.dart';
import 'src/presentation/presentation.dart';
import 'src/utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  await AppPrefs.initListener();
  await notificationInitialed();
  runApp(OverlaySupport(child: RestartWidget(child: App())));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeSwitcherWidget(initialThemeData: normalTheme(context), child: MyApp());
  }
}

class MyApp extends StatefulWidget {
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    AppDeviceInfo.init();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("ChangeAppLifecycleState: $state");
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: APP_NAME,
      theme: ThemeSwitcher.of(context).themeData,
      navigatorObservers: <NavigatorObserver>[MyApp.observer],
      locale: const Locale('vi', 'VN'),
      translationsKeys: AppTranslation.translations,
      home: SplashScreen(),
      onGenerateRoute: Routers.generateRoute,
    );
  }
}
