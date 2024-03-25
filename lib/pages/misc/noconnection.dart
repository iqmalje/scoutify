import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:scoutify/components/components.dart';
import 'package:scoutify/main.dart';

class NoConnection extends StatefulWidget {
  const NoConnection({super.key});
  @override
  State<NoConnection> createState() => _NoConnectionState();
}

class _NoConnectionState extends State<NoConnection> {
  bool _checkingConnection = false;

  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF2C225B), Color(0xFF2E3B78)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width * 0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'No connection detected',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  SizedBox(height: 20),
                  const Text(
                    'Please check your device connectivity, and click refresh after you connect to a network',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal,
                      height: 0,
                    ),
                  ),
                  SizedBox(height: 40),
                  Center(
                    child: Image.asset("assets/images/no-connection.png"),
                  ),
                  SizedBox(height: 120),
                  _checkingConnection
                      ? CircularProgressIndicator() // Show a loading indicator while checking connection
                      : ScoutifyComponents().outlinedButton(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.8,
                          text: "Refresh",
                          onTap: _refreshConnection,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                          ),
                        ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _refreshConnection() async {
  
    setState(() {
      _checkingConnection = true;
    });

    bool isConnected = await InternetConnectionCheckerPlus().hasConnection;

    setState(() {
      _checkingConnection = false;
    });

    if (isConnected) {
      main();
      await Future.delayed(Duration(seconds: 1));
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => MyApp()));
    } else {
      // Show a snackbar or any UI indication that the connection is still not available
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Still no connection detected')));
    }
  }
}
