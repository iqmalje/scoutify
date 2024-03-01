import 'package:flutter/material.dart';
import 'package:scoutify/components/components.dart';
import 'package:scoutify/pages/inbox/inboxdetail.dart';

import '../../model/inbox.dart';

class InboxMainPage extends StatefulWidget {
  const InboxMainPage({super.key});

  @override
  State<InboxMainPage> createState() => _InboxMainPageState();
}

class _InboxMainPageState extends State<InboxMainPage> {
  List<Inbox> dummyInboxes = [
    Inbox(
      inboxId: '1',
      title: 'Welcome to Scoutify',
      type: 'Welcome',
      description: 'Hey there, Scout!',
      image_url: '',
      isRead: false,
      target_group: "",
      target_id: "",
    ),
    Inbox(
      inboxId: '2',
      title: 'New Activity Has Recorded',
      type: 'Welcome',
      description: 'Congratulations',
      image_url: '',
      isRead: false,
      target_group: "",
      target_id: "",
    ),
    Inbox(
      inboxId: '3',
      title: 'Update Your Johor Scout Digital ID',
      type: 'Welcome',
      description: 'Hey there, it\'s time to update your Johor Scout Digital ID',
      image_url: '',
      isRead: false,
      target_group: "",
      target_id: "",
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScoutifyComponents().normalAppBar('Inbox', context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: const Color(0xFFF44236),
                  child: Text(
                    dummyInboxes.length.toString(),
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 20),
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0, 1),
                              blurRadius: 4,
                              color: Colors.black.withOpacity(0.25))
                        ]),
                    child: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return bottomSheet();
                              });
                        },
                        icon: const Icon(Icons.more_vert))),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 3,
              width: MediaQuery.sizeOf(context).width,
              color: const Color(0xFFD9D9D9),
            ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
              child: dummyInboxes.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/inbox_empty.png',
                          width: MediaQuery.of(context).size.width * 0.5,
                          // Replace with your image asset path
                        ),
                        const SizedBox(height: 5),
                        const Text('Your inbox is empty'),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: dummyInboxes.length,
                      itemBuilder: (context, index) {
                        return buildInboxMessage(
                            dummyInboxes.elementAt(index), index);
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildInboxMessage(Inbox inbox, int index) {
    return Dismissible(
      background: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Container(
          color: const Color.fromARGB(255, 255, 0, 0),
          child: const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 20,
                  ),
                  Text(
                    'Delete',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 14),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      dismissThresholds: const {DismissDirection.endToStart: 0.3},
      onDismissed: (direction) {
        //ask confirmation to delete, i think better for ux
        print(direction.name);
        setState(
          () {
            dummyInboxes.removeAt(index);
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const InboxDetailPage()));
            },
            child: Ink(
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 26,
                    backgroundColor: Color(0xFF2E3B78),
                    child: Icon(
                      Icons.person_outline,
                      color: Colors.white,
                      size: 34,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    inbox.title,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    inbox.description,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF9397A0),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFF2E3B78),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 1,
                          width: MediaQuery.sizeOf(context).width,
                          color: Colors.black.withOpacity(0.25),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return SizedBox(
      height: 150,
      width: MediaQuery.sizeOf(context).width,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  fixedSize: Size(MediaQuery.sizeOf(context).width, 40)),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: const Text(
                  'Delete All',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.red,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  fixedSize: Size(MediaQuery.sizeOf(context).width, 10)),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: const Text(
                  'Mark all as read',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
