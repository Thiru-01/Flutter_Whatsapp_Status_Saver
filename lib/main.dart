import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:whatsapp_saver/constant.dart';
import 'package:whatsapp_saver/provider/bottombarprovider.dart';
import 'package:whatsapp_saver/provider/instaprovider.dart';
import 'package:whatsapp_saver/provider/themeprovider.dart';
import 'screens/homepage.dart';
import 'screens/permission_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<BottomBarProvider>(
              create: (_) => BottomBarProvider()),
          ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
          ChangeNotifierProvider<InstaProvider>(create: (_) => InstaProvider()),
        ],
        child: Consumer<ThemeProvider>(builder: (context, snapshot, _) {
          return MaterialApp(
              title: 'ST Saver',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                fontFamily: GoogleFonts.montserrat().fontFamily,
                primarySwatch: primaryswatch,
              ),
              home: const PermissionState());
        }),
      );
    });
  }
}

class PermissionState extends StatefulWidget {
  const PermissionState({Key? key}) : super(key: key);

  @override
  _PermissionStateState createState() => _PermissionStateState();
}

class _PermissionStateState extends State<PermissionState> {
  Future<PermissionStatus> getPermission() async {
    PermissionStatus status = await Permission.manageExternalStorage.status;
    if (status == PermissionStatus.denied) {
      PermissionStatus currentStatus =
          await Permission.manageExternalStorage.request();
      if (currentStatus == PermissionStatus.granted) {
        setState(() {});
        return PermissionStatus.granted;
      } else {
        return PermissionStatus.denied;
      }
    }
    setState(() {});
    return PermissionStatus.granted;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPermission(),
        builder: (context, AsyncSnapshot<PermissionStatus> snapshot) {
          if (snapshot.data == PermissionStatus.granted) {
            return const HomePage();
          }
          return PerimissionPage(
            askPermission: getPermission,
          );
        });
  }
}
