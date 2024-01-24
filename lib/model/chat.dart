/// Mock of AI chat bot system
/// Will guide the user on where to go and what to choose
class ChatSystem {
  List<String> questions = [
    "About Feeds",
    "About Activities",
    "About Facilities",
    "About Profiles"
    // {'question': "About Feeds", 'answer': 'feed'},
    // {'question': "About Activities", 'answer': 'activity'},
    // {'question': "About Facilities", 'answer': 'facility'},
    // {'question': "About Profiles", 'answer': 'profile'},
  ];

  List<Object> answers = [
    FeedGuideChat,
    // ActivityGuideChat,
    // FacilityGuideChat,
    // ProfileGuideChat
  ];

  Object getAnswer(index) {
    return answers[index];
  }

  String greet() {
    return "Hi user!, what may I help you today?";
  }
}

class FeedGuideChat extends ChatSystem {
  @override
  String greet() {
    return "What may I assist you with Feed?";
  }

  @override
  List<String> questions = [
    "What is Feeds?",
    "How do I see the details of a feed?",
  ];
  List<Object> answers = [
    "Feeds is where the activities posted by the official Scout team, where scouts can see or join!",
    "You can do so by tapping on a feed that has been posted and is visible on your homepage"
  ];
}

class ActivityGuideChat {
  String init() {
    return "What may I assist you with Activity?";
  }

  List<String> questions = [
    'What is activities?',
    'How do I see the details of a feed?',
    'How do I join an activity?',
    'How do I see the attendees?',
    'How do I add an attendees?',
  ];
  List<String> answers = [
    'Activities is a super-set of feeds, where it could be a meeting or camping events hosted by the official Scouts team',
    'You can do so by tapping on an activity that has been posted and is visible on your activity list page',
    'Simply scan your specialized ID card, or announce your Scout ID to officer in charge of the activity',
    'Only admins are allowed to do so. Click on an activity, select the date, click on open for attendances and a list showing all the attendees on that date will be shown',
    'Only admins are allowed to do so. Click on an activity, select the date, click on open for attendances and let the Scout members scan their ID card on to the IoT device to register'
  ];
}

class FacilityGuideChat {
  String init() {
    return "What may I assist you with Facility?";
  }

  List<String> questions = [
    'What is facilities?',
    'How do I access to a facility?',
    'How do I see peoples that accessed the facilities?',
  ];
  List<String> answers = [
    'Facilities are places or location that can be used by all Scout members for various purposes',
    'You can access a facility by tapping your card on the entry RFID scanner and exits the facility by tapping your card on the exit RFID scanner located at the door',
    'Only admins are allowed to do so. Click on a facility, select the date, from here you can see the overview details of access data for a facility, you can then click on "Show all people accessed" to see a list of all the people that has accessed the facility',
  ];
}

class ProfileGuideChat {
  String init() {
    return "What may I assist you with Profile?";
  }

  List<String> questions = [
    'What is profiles?',
  ];
  List<String> answers = [
    'Profiles are information regarding your scout profile, it contains your unique ID and your unique ID card designed by the official Scout team',
  ];
}
