import 'package:escout/backend/backend.dart';
import 'package:escout/pages/misc/chatpage.dart';
import 'package:flutter/material.dart';

class OfficersNearbyPage extends StatefulWidget {
  const OfficersNearbyPage({super.key});

  @override
  State<OfficersNearbyPage> createState() => _OfficersNearbyPageState();
}

class _OfficersNearbyPageState extends State<OfficersNearbyPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2E3B78),
      child: SafeArea(
        child: Scaffold(
          /*appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Container(
              //blue box container
              width: MediaQuery.sizeOf(context).width,
              height: 90,
              decoration: const BoxDecoration(color: Color(0xFF2E3B78)),
              child: const Center(
                child: Text(
                  'Officers nearby',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 24,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),*/
          body: Column(
            children: [
              _appBar(context),
              Expanded(
                child: FutureBuilder(
                    future: SupabaseB.isAdminToggled
                        ? SupabaseB().getChatsAdmin()
                        : SupabaseB().getOfficers(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: SizedBox.expand(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: List.generate(
                                snapshot.data!.length,
                                (index) => buildOfficer(
                                    snapshot.data!.elementAt(index))),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOfficer(dynamic data) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.9,
        height: 78,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          shadows: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 2,
              offset: Offset(0, 2),
              spreadRadius: 0,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(data['image_url']),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['fullname'],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        height: 0,
                      ),
                    ),
                    Text(
                      data['no_ahli'],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                    Text(
                      data['phoneno'],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChatPage(
                              otherPartyID: data['accountid'],
                              imageURL: data['image_url'],
                              otherPartyName: data['fullname'],
                            )));
                  },
                  icon: const Icon(Icons.chat))
            ],
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
          'Officers nearby',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 24,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    ),
  );
}
