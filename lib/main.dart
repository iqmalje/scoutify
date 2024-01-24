// ignore_for_file: unused_local_variable

import 'package:escout/pages/activity/activitypage%20copy.dart';
import 'package:escout/pages/homepage/temppage.dart';
import 'package:escout/pages/signin/signinpage.dart';
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
    isSignedIn = true;
  }
  bool isAvailable = await NfcManager.instance.isAvailable();

  //listen for auth
  final authSubscription =
      SupabaseB().supabase.auth.onAuthStateChange.listen((data) {
    final AuthChangeEvent event = data.event;

    if (event == AuthChangeEvent.signedOut) {
      //set admin to false
      SupabaseB.isAdminToggled = false;
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
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 13, 63, 214)),
        useMaterial3: true,
      ),
      routes: {
        '/signin': (context) => const SignInPage(),
      },
      home: isSignedIn ? const TempPage() : const SignInPage(),
    );
  }
}
