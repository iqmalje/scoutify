import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('HOME PAGE'),
            ElevatedButton(
              onPressed: () {
                // Navigate to DetailsProgram when the button is clicked
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => DetailsProgram()),
                );
              },
              child: Text('Go to Details Program'),
            ),
          ],
        ),
      ),
    );
  }
}

// DetailsProgram widget goes here
class DetailsProgram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Program'),
      ),
      body: Center(
        child: Text('This is the Details Program page'),
      ),
    );
  }
}