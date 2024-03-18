import 'package:flutter/material.dart';
import 'package:scoutify/components/components.dart';
import 'package:scoutify/model/inbox.dart';

class InboxDetailPage extends StatefulWidget {
  final Inbox inbox;
  const InboxDetailPage({super.key, required this.inbox});

  @override
  State<InboxDetailPage> createState() => _InboxDetailPageState(inbox);
}

class _InboxDetailPageState extends State<InboxDetailPage> {
  Inbox inbox;
  _InboxDetailPageState(this.inbox);
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
                  Text(
                    inbox.title,
                    style: const TextStyle(
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
          Builder(builder: (context) {
            if (inbox.imageURL == null) {
              return Container();
            }
            return Container(
              height: 240,
              color: Colors.black.withOpacity(0.25),
            );
          }),
          const SizedBox(
            height: 20,
          ),
          //description
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(inbox.description,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                    )),
              )),
          const Spacer(),
          Builder(builder: (context) {
            if (inbox.type == 'update') {
              return ScoutifyComponents().filledButton(
                  height: 60,
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  text: 'Update Profile',
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  onTap: () {},
                  color: Color(0xFF2E3B78));
            } else {
              return Container();
            }
          }),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}
