import 'package:flutter/material.dart';
import 'package:scoutify/components/components.dart';

class InboxDetailPage extends StatefulWidget {
  const InboxDetailPage({super.key});

  @override
  State<InboxDetailPage> createState() => _InboxDetailPageState();
}

class _InboxDetailPageState extends State<InboxDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          ScoutifyComponents().appBarWithBackButton('Inbox Details', context),
      body: Column(
        children: [
          Container(
            height: 70,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Text(
                    'Welcome to Scoutify!',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  CircleAvatar(
                      backgroundColor: Colors.red,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          )))
                ],
              ),
            ),
          ),
          Container(
            height: 240,
            color: Colors.black.withOpacity(0.25),
          ),
          const SizedBox(
            height: 20,
          ),
          //description
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                  'Hey there, Scout!\n\nWelcome aboard Scoutify, your ultimate ticket to an epic scout adventure! 🎉 Get ready to supercharge your scouting experience with this all-in-one mobile app. Whether you\'re exploring the great outdoors or embarking on thrilling new challenges, Scoutify has got your back!\n\nStay tuned for all the latest updates, tips, and tricks to make your scouting journey unforgettable. Get ready to unleash your inner explorer and dive into the excitement!\n\nAdventure awaits - let\'s make every moment count!',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                  ))),
        ],
      ),
    );
  }
}
