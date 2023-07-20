import '/providers/start_provider.dart';
import '../services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/home.dart';
import 'providers/connection_check_provider.dart';
import 'providers/geolist_provider.dart';
import 'providers/location_provider.dart';
import 'providers/nearby.device.history_provider.dart';
import 'providers/register_provider.dart';
import 'screens/geolist.dart';
// import 'screens/login.dart';
import 'screens/nearbydevice.dart';
import 'screens/register.dart';
import 'screens/start.dart';
import 'screens/welcome.dart';
import 'services/storage_service.dart';

late bool reg;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  reg = await StrorageService().checkRegistered();

  runApp(MultiProvider(providers: [
    // ChangeNotifierProvider.value(value: LocationService()),
    ChangeNotifierProvider.value(value: LocationProvider()),
    ChangeNotifierProvider.value(value: Geolistprovider()),
    ChangeNotifierProvider.value(value: NearByDeviceprovider()),
    ChangeNotifierProvider.value(value: Registerprovider()),
    ChangeNotifierProvider.value(value: ConnectionCheckprovider()),
    ChangeNotifierProvider.value(value: Startprovider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CovTrack',
      theme: ThemeData(brightness: Brightness.dark),
      // home: MyHomePage(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => reg
            ? const StartWidget()
            : const WelcomePageWidget(), //starting page for new user
        // '/login': (context) => LoginWidget(), not using
        '/register': (context) => RegisterWidget(),
        // '/': (context) => RegisterWidget(),
        '/starttrace': (context) => const StartWidget(), //start page for logged user
        '/main': (context) => const MyHomePage(),
        // '/': (context) => const MyHomePage(),
        '/history': (context) => GeoListWidget(),
        '/nearbyhistory': (context) => NearbydevicesWidget(),
      },
    );
  }
}
