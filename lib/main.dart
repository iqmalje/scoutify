// ignore_for_file: unused_local_variable

import 'package:scoutify/backend/accountDAO.dart';
import 'package:scoutify/model/currentaccount.dart';
import 'package:scoutify/pages/activation/activateaccount.dart';
import 'package:scoutify/pages/activation/confirmemail.dart';
import 'package:scoutify/pages/activation/setpasswordpage.dart';
import 'package:scoutify/pages/homepage/activitypage.dart';
import 'package:scoutify/pages/attendance/new_attendance.dart';
import 'package:scoutify/pages/forgotpassword/verifyOTP.dart';
import 'package:scoutify/pages/homepage/temppage.dart';
import 'package:scoutify/pages/signin/signinpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'backend/backend.dart';

bool isSignedIn = false;
void main() async {
  await dotenv.load(fileName: '2.env');
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_AUTH_KEY']!,
  );

  if (Supabase.instance.client.auth.currentUser == null) {
    isSignedIn = false;
  } else {
    await Supabase.instance.client.auth.signOut();
    isSignedIn = false;
  }
  bool isAvailable = await NfcManager.instance.isAvailable();

  //listen for auth
  final authSubscription =
      Supabase.instance.client.auth.onAuthStateChange.listen((data) {
    final AuthChangeEvent event = data.event;

    if (event == AuthChangeEvent.signedOut) {
      //set admin to false
      CurrentAccount.getInstance().isAdminToggled = false;
      print('since logged out, admin toggled to false');
    }
  });
  runApp(const MyApp());
}

//we are in sprint-1
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Scoutify App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 13, 63, 214)),
          useMaterial3: true,
        ),
        routes: {
          '/signin': (context) => const SignInPage(),
        },
        home: isSignedIn ? const TempPage() : const SignInPage());
  }
}
