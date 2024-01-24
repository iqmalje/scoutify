import 'package:escout/backend/backend.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String otherPartyID;
  final String imageURL;
  final String otherPartyName;
  const ChatPage(
      {super.key,
      required this.otherPartyID,
      required this.imageURL,
      required this.otherPartyName});

  @override
  State<ChatPage> createState() =>
      _ChatPageState(otherPartyID, imageURL, otherPartyName);
}

class _ChatPageState extends State<ChatPage> {
  final String otherPartyID;
  final String imageURL;
  final String otherPartyName;
  final _stream = SupabaseB()
      .supabase
      .from('chats')
      .stream(primaryKey: ['id']).order('sent_at', ascending: false);
  final currentuserID = SupabaseB().supabase.auth.currentUser!.id;

  TextEditingController chatController = TextEditingController();
  List<dynamic> chatContent = [];
  _ChatPageState(this.otherPartyID, this.imageURL, this.otherPartyName);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2E3B78),
      child: SafeArea(
        child: Scaffold(
          body: StreamBuilder<List<dynamic>>(
              stream: _stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                //parse stream
                print(snapshot.data);

                chatContent.clear();

                for (var element in snapshot.data!) {
                  if ((element['party1'] == currentuserID ||
                          element['party2'] == currentuserID) &&
                      (element['party1'] == otherPartyID ||
                          element['party2'] == otherPartyID)) {
                    chatContent.add(element);
                  }
                }

                return Column(
                  children: [
                    _appBar(context),
                    //chat content
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: ListView.builder(
                                  itemCount: chatContent.length,
                                  shrinkWrap: true,
                                  reverse: true,
                                  itemBuilder: (context, index) {
                                    if (chatContent
                                            .elementAt(index)['sent_by'] ==
                                        currentuserID) {
                                      return buildOwnParty(chatContent
                                          .elementAt(index)['content']);
                                    } else
                                      return buildOtherParty(chatContent
                                          .elementAt(index)['content']);
                                  }),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //textfield
                    Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 220, 220, 220),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.sizeOf(context).width * 0.8,
                                minHeight: 30),
                            child: TextField(
                              controller: chatController,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                              minLines: 1,
                              maxLines: 3,
                              decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(top: 1, left: 10),
                                  hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 183, 183, 183),
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'Send a message'),
                            ),
                          ),
                          IconButton(
                              onPressed: () async {
                                await SupabaseB().addNewChat(otherPartyID,
                                    currentuserID, chatController.text);

                                setState(() {
                                  chatController.clear();
                                });
                              },
                              icon: const Icon(Icons.send))
                        ],
                      ),
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }

  Widget buildOtherParty(String content) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.red,
              backgroundImage: NetworkImage(imageURL),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              constraints: const BoxConstraints(
                minHeight: 40,
                minWidth: 0,
                maxWidth: 300,
              ),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: Color.fromARGB(255, 106, 82, 215),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  content,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOwnParty(String content) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Container(
          constraints: const BoxConstraints(
            minHeight: 40,
            minWidth: 0,
            maxWidth: 300,
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10)),
            color: Color.fromARGB(255, 210, 210, 210),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              content,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _appBar(context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 90,
      decoration: const BoxDecoration(color: Color(0xFF2E3B78)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 30,
          ),
          Container(
            width: 50,
            height: 50,
            decoration: const ShapeDecoration(
              color: Colors.white,
              shape: OvalBorder(),
            ),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios_new)),
          ),
          const SizedBox(
            width: 30,
          ),
          // ignore: prefer_const_constructors
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                otherPartyName.split(' ')[0],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Container(
              //       width: 12,
              //       height: 12,
              //       decoration: const ShapeDecoration(
              //         color: Colors.green,
              //         shape: OvalBorder(),
              //       ),
              //     ),

              //     const SizedBox(
              //       width: 10,
              //     ),
              //     const Text(
              //       'Online',
              //       style: TextStyle(
              //         color: Colors.white,
              //         fontSize: 12,
              //         fontFamily: 'Poppins',
              //         fontWeight: FontWeight.w400,
              //         height: 0,
              //       ),
              //     ),
              //   ],
              // )

              //TODO: If user offline
              /*
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: const ShapeDecoration(
                    color: Colors.red,
                    shape: OvalBorder(),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),======
                const Text(
                  'Offline',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ],
            )
            */
            ],
          ),
        ],
      ),
    );
  }
}
