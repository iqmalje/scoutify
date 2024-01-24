import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:escout/model/chat.dart';
import 'package:flutter/material.dart';

class ChatAIPage extends StatefulWidget {
  const ChatAIPage({super.key});

  @override
  State<ChatAIPage> createState() => _ChatAIPageState();
}

class _chatContent {
  String title;
  List<String> questions;
  List<void Function()> onPresseds;
  String? answer;
  bool isBotSend;
  bool isDoneAnimated = false;
  _chatContent(
      {required this.title,
      required this.questions,
      required this.onPresseds,
      required this.isBotSend,
      this.answer});
}

class _ChatAIPageState extends State<ChatAIPage> {
  TextEditingController chatController = TextEditingController();
  List<_chatContent> chatContent = [];
  ChatSystem cs = ChatSystem();
  List<String> answers = [];
  @override
  void initState() {
    super.initState();

    initChatBot();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2E3B78),
      child: SafeArea(
        child: Scaffold(
            body: Column(
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
                            return Builder(builder: (context) {
                              _chatContent cc = chatContent.elementAt(index);
                              return Builder(builder: (context) {
                                if (cc.questions.isEmpty &&
                                    cc.isBotSend == true) {
                                  print("DAH LA");
                                  return buildAnswer(cc.answer!, cc);
                                } // only for answers {
                                if (cc.isBotSend == false) {
                                  return buildOwnParty(cc.title);
                                }
                                return buildQuestions(
                                    cc.title, cc.questions, cc.onPresseds, cc);
                              });
                            });
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
          ],
        )),
      ),
    );
  }

  Widget buildQuestions(String title, List<String> questions,
      List<void Function()> onPresseds, _chatContent cc) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
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
                  bottomRight: Radius.circular(10)),
              color: Color.fromARGB(255, 106, 82, 215),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  AnimatedTextKit(
                      key: ValueKey(DateTime.now().microsecondsSinceEpoch),
                      onFinished: () {
                        cc.isDoneAnimated = true;
                      },
                      isRepeatingAnimation: false,
                      animatedTexts: [
                        TypewriterAnimatedText(
                          title,
                          speed: cc.isDoneAnimated
                              ? Duration.zero
                              : Duration(milliseconds: 50),
                          cursor: "|",
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        )
                      ]),
                  ListView.builder(
                      itemCount: questions.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                side: const BorderSide(
                                    color: Colors.white, width: 1.5)),
                            onPressed: () {
                              cc.isDoneAnimated = true;
                              onPresseds[index]();
                            },
                            child: Text(
                              questions.elementAt(index),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ));
                      })
                ],
              ),
            )),
      ),
    );
  }

  Widget buildAnswer(String content, _chatContent cc) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
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
                bottomRight: Radius.circular(10)),
            color: Color.fromARGB(255, 106, 82, 215),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                AnimatedTextKit(
                    key: ValueKey(DateTime.now().microsecondsSinceEpoch),
                    onFinished: () => cc.isDoneAnimated = true,
                    isRepeatingAnimation: false,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        content,
                        speed: cc.isDoneAnimated
                            ? Duration.zero
                            : Duration(milliseconds: 50),
                        cursor: "|",
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      )
                    ]),

                const SizedBox(
                  height: 5,
                ),
                //add button here
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side:
                            const BorderSide(color: Colors.white, width: 1.5)),
                    onPressed: () {
                      cc.isDoneAnimated = true;
                      setState(() {
                        initChatBot();
                      });
                    },
                    child: Text(
                      'Ask another question',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void initChatBot() {
    setState(() {
      chatContent.insert(
          0,
          _chatContent(
              title: cs.greet(),
              questions: cs.questions,
              onPresseds: [
                () {
                  setState(() {
                    chatContent.insert(
                        0,
                        _chatContent(
                            title: "About Feeds",
                            questions: [],
                            onPresseds: [],
                            isBotSend: false));
                    chatContent.insert(
                        0,
                        _chatContent(
                            title: FeedGuideChat().greet(),
                            questions: FeedGuideChat().questions,
                            onPresseds: [
                              () {
                                setState(() {
                                  chatContent.insert(
                                      0,
                                      _chatContent(
                                          title: "What is Feeds?",
                                          questions: [],
                                          onPresseds: [],
                                          isBotSend: false));
                                  chatContent.insert(
                                      0,
                                      _chatContent(
                                          title: 'This might help,',
                                          questions: [],
                                          onPresseds: [],
                                          answer:
                                              "Feeds is where the activities posted by the official Scout team, where scouts can see or join!",
                                          isBotSend: true));
                                });
                              },
                              () {
                                setState(() {
                                  chatContent.insert(
                                      0,
                                      _chatContent(
                                          title:
                                              "How do I see the details of a feed?",
                                          questions: [],
                                          onPresseds: [],
                                          isBotSend: false));
                                  chatContent.insert(
                                      0,
                                      _chatContent(
                                          title: 'This might help,',
                                          questions: [],
                                          onPresseds: [],
                                          answer:
                                              "You can do so by tapping on a feed that has been posted and is visible on your homepage",
                                          isBotSend: true));
                                });
                              },
                            ],
                            isBotSend: true));
                  });
                },
                () {
                  setState(() {
                    chatContent.insert(
                        0,
                        _chatContent(
                            title: "About Activities",
                            questions: [],
                            onPresseds: [],
                            isBotSend: false));
                    chatContent.insert(
                        0,
                        _chatContent(
                            title: ActivityGuideChat().init(),
                            questions: ActivityGuideChat().questions,
                            onPresseds: List.generate(
                                ActivityGuideChat().answers.length, (index) {
                              return () => setState(() {
                                    chatContent.insert(
                                        0,
                                        _chatContent(
                                            title: ActivityGuideChat()
                                                .questions[index],
                                            questions: [],
                                            onPresseds: [],
                                            isBotSend: false));
                                    chatContent.insert(
                                        0,
                                        _chatContent(
                                            title: 'a',
                                            questions: [],
                                            onPresseds: [],
                                            answer: ActivityGuideChat()
                                                .answers[index],
                                            isBotSend: true));
                                  });
                            }),
                            isBotSend: true));
                  });
                },
                () {
                  setState(() {
                    chatContent.insert(
                        0,
                        _chatContent(
                            title: "About Facilities",
                            questions: [],
                            onPresseds: [],
                            isBotSend: false));
                    chatContent.insert(
                        0,
                        _chatContent(
                            title: FacilityGuideChat().init(),
                            questions: FacilityGuideChat().questions,
                            onPresseds: List.generate(
                                FacilityGuideChat().answers.length, (index) {
                              return () => setState(() {
                                    chatContent.insert(
                                        0,
                                        _chatContent(
                                            title: FacilityGuideChat()
                                                .questions[index],
                                            questions: [],
                                            onPresseds: [],
                                            isBotSend: false));
                                    chatContent.insert(
                                        0,
                                        _chatContent(
                                            title: 'a',
                                            questions: [],
                                            onPresseds: [],
                                            answer: FacilityGuideChat()
                                                .answers[index],
                                            isBotSend: true));
                                  });
                            }),
                            isBotSend: true));
                  });
                },
                () {
                  setState(() {
                    chatContent.insert(
                        0,
                        _chatContent(
                            title: "About Profiles",
                            questions: [],
                            onPresseds: [],
                            isBotSend: false));
                    chatContent.insert(
                        0,
                        _chatContent(
                            title: ProfileGuideChat().init(),
                            questions: ProfileGuideChat().questions,
                            onPresseds: List.generate(
                                ProfileGuideChat().answers.length, (index) {
                              return () => setState(() {
                                    chatContent.insert(
                                        0,
                                        _chatContent(
                                            title: ProfileGuideChat()
                                                .questions[index],
                                            questions: [],
                                            onPresseds: [],
                                            isBotSend: false));
                                    chatContent.insert(
                                        0,
                                        _chatContent(
                                            title: 'a',
                                            questions: [],
                                            onPresseds: [],
                                            answer: ProfileGuideChat()
                                                .answers[index],
                                            isBotSend: true));
                                  });
                            }),
                            isBotSend: true));
                  });
                },
              ],
              isBotSend: true));
    });
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
        const Text(
          "Let's Ask AI",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
      ],
    ),
  );
}
