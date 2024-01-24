import 'package:escout/backend/backend.dart';
import 'package:flutter/material.dart';

class AttendanceTest extends StatefulWidget {
  const AttendanceTest({super.key});

  @override
  State<AttendanceTest> createState() => _AttendanceTestState();
}

class _AttendanceTestState extends State<AttendanceTest> {
  TextEditingController card = TextEditingController();
  late FocusNode fn;
  final String activityid = '8d97e8fc-e99b-4be5-a967-25cbf3770492';
  List<dynamic> attendance = [];

  @override
  void initState() {
    super.initState();
    fn = FocusNode();

    //subscribe to event
    SupabaseB()
        .supabase
        .from('attendance')
        .stream(primaryKey: ['attendanceid']).listen((event) async {
      if (mounted) {
        setState(() {
          attendance = event;
          
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: double.infinity),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              autofocus: true,
              focusNode: fn,
              controller: card,
              onSubmitted: (value) async {
                

                //lets check db
                SupabaseB().addAttendance(activityid, value);
                card.clear();
                fn.requestFocus();
              },
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.5,
              child: ListView.builder(
                  itemCount: attendance.length,
                  itemBuilder: (context, index) {
                    return Text(attendance[index]['fullname']);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
