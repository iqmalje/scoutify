import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
                              _onDismissed();
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
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  DateFormat('d MMMM yyyy, hh:mm a').format(inbox.time),
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xFF9397A0),
                      fontSize: 11),
                ),
              ),
            ),
            Builder(builder: (context) {
              if (inbox.type == 'update') {
                return Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ), //removed spacer to avoid overflow
                    ScoutifyComponents().filledButton(
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
                                  builder: (context) => const ScoutIDPage()));
                        },
                        color: const Color(0xFF2E3B78)),
                  ],
                );
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

  void _onDismissed() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            "Delete Message?",
            style: TextStyle(fontFamily: 'Poppins'),
          ),
          content: const Text(
              "Once you delete this message, you won't be able to undo it.",
              style: TextStyle(fontFamily: 'Poppins')),
          actions: <Widget>[
            ScoutifyComponents().filledNormalButton(context, 'Cancel',
                width: 100, color: Colors.grey, onTap: () {
              Navigator.of(context).pop();
            }),
            ScoutifyComponents().filledNormalButton(context, 'Confirm',
                width: 100, onTap: () async {
              try {
                await InboxDAO().deleteInbox(inbox.id);
                Navigator.pop(context);
                Navigator.pop(context);
              } catch (e) {
                print(e);
              }
            }),
          ],
        );
      },
    );
  }
}
