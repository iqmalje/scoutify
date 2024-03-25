import 'package:flutter/material.dart';
import 'package:scoutify/backend/inboxDAO.dart';
import 'package:scoutify/components/components.dart';
import 'package:scoutify/model/inbox.dart';
import 'package:scoutify/pages/account/scoutid.dart';

class InboxDetailPage extends StatefulWidget {
  final Inbox inbox;
  const InboxDetailPage({super.key, required this.inbox});

  @override
  State<InboxDetailPage> createState() => _InboxDetailPageState(inbox);
}

class _InboxDetailPageState extends State<InboxDetailPage> {
  Inbox inbox;
  _InboxDetailPageState(this.inbox);

  // mark it as seen
  @override
  void initState() {
    InboxDAO().markSeen(inbox.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          ScoutifyComponents().appBarWithBackButton('Inbox Details', context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        inbox.title,
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    CircleAvatar(
                        backgroundColor: Colors.red,
                        child: IconButton(
                            onPressed: () async {
                              await InboxDAO().deleteInbox(inbox.id);
                              Navigator.of(context).pop();
                            },
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
                width: MediaQuery.sizeOf(context).width,
                color: Colors.black.withOpacity(0.25),
                padding: EdgeInsets.zero,
                child: Image.network(
                  inbox.imageURL!,
                  fit: BoxFit.fill,
                  width: MediaQuery.sizeOf(context).width,
                ),
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
            const SizedBox(
              height: 100,
            ), //removed spacer to avoid overflow
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
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScoutIDPage()));
                    },
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
      ),
    );
  }
}
