import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safarkarappfyp/core/myColors.dart';
import 'package:safarkarappfyp/screens/placeDeatilScreen/placeDetailScreen.dart';
import 'package:safarkarappfyp/screens/profileScreen/profile_screen.dart';
import './screens/suggestedPlannerScreen/seggestedPlannerScreen.dart';
import './providers/tripDateTimeProvider.dart';
import './database/userLocalData.dart';
import './providers/placesproviders.dart';
import './providers/trips.dart';
import './screens/splashScreen/welcomeScreen.dart';
import './screens/auth/loginScreen/loginScreen.dart';
import './screens/auth/signupScreen/signupScreen.dart';
import './screens/startingScreen/startingScreen.dart';
import './screens/homeScreen/homeScreen.dart';
import './screens/PlannerForm/plannerFormScreen.dart';
import './screens/plannerListViewScreen/plannerListViewScreen.dart';
import './screens/plannerMapScreen/plannerMapScreen.dart';
import './screens/plannerForm/aboutLocations/SearchLocation/SearchStartingPoint.dart';
import './screens/plannerForm/aboutLocations/SearchLocation/searchEndingPoint.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UserLocalData.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: TripTypeProvider()),
        ChangeNotifierProvider.value(value: PlacesProvider()),
        ChangeNotifierProvider.value(value: TripDateTimeProvider()),
      ],
      child: Consumer<TripTypeProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'SafarKar-Travel and Explore Pakistan',
            theme: ThemeData(
              primarySwatch: Colors.green,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              iconTheme: IconThemeData(color: greenShade),
            ),
            home: WelcomeScreen(),
            routes: {
              WelcomeScreen.routeName: (ctx) => WelcomeScreen(),
              LoginScreen.routeName: (ctx) => LoginScreen(),
              SignUpScreen.routeName: (ctx) => SignUpScreen(),
              StartingScreen.routeName: (ctx) => StartingScreen(),
              HomeScreen.routeName: (ctx) => HomeScreen(),
              PlannerFormScreen.routeName: (ctx) => PlannerFormScreen(),
              SuggestedPlannerScreen.routeName: (ctx) =>
                  SuggestedPlannerScreen(),
              PlaceDetailScreen.routeName: (ctx) => PlaceDetailScreen(),
              SearchStartingPoint.routeName: (ctx) => SearchStartingPoint(),
              SearchEndingPoint.routeName: (ctx) => SearchEndingPoint(),
              PlannerListViewScreen.routeName: (ctx) => PlannerListViewScreen(),
              PlannerMapScreen.routeName: (ctx) => PlannerMapScreen(),
              ProfileScreen.routeName: (ctx) => ProfileScreen(),
            },
          );
        },
      ),
    );
  }
}


// Certificate fingerprints:
//  SHA1: 35:8D:BE:C2:0A:25:C8:DB:5E:20:99:CF:45:9B:3A:E6:F7:AD:F7:A1
//  SHA256: 75:88:59:16:CF:F5:CA:00:6E:8F:75:2A:66:E0:EA:BA:F1:BB:09:E1:3D:D4:70:06:3D:85:E8:5A:1B:14:04:C2