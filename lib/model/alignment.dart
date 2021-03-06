library model.alignment;


class Alignment {
  // If the limit is the same, why have different names?
  static const int LIMIT = 20;
//  static const int LAWFUL_LIMIT = 20;
//  static const int GOOD_LIMIT = 20;
//  static const int CHAOTIC_LIMIT = -20;
//  static const int EVIL_LIMIT = -20;

  static const List<String> alignments = const [
    "Lawful Good",
    "Neutral Good",
    "Chaotic Good",
    "Lawful Neutral",
    "Neutral",
    "Chaotic Neutral",
    "Lawful Evil",
    "Neutral Evil",
    "Chaotic Evil"
  ];

  String _alignment;

  //  Both have 3  'ranges' , (-100, -21), (-20, 20), (21, 100)
  int _lawfulness; // Lawful, neutral, chaotic
  int _morality; // Good, neutral, evil

  Alignment() {
    _alignment = "unaligned";
  }

  Alignment.fromValue(int lawfulness, int morality) {
    _lawfulness = lawfulness;
    _morality = morality;
    calcAlignment();
  }

  Alignment.fromString(String al) {
    setByString(al);
  }

/*------ This seemed to load up a function too much, but maybe it simplifies things on the usage end. ------*/
//  // This will affect a character's lawful and morality alignments. Setting the lawMoralFlag will determine which axis is affected. lawfulness = 0, morality = 1.
//  // Acts can be positive (Lawful/Good) or negative (Chaotic/Evil)
//  void axisChange([int magnitude = 1], int lawMoralFlag) {
//    if (lawMoralFlag == 0) { // Shift in lawfulness.
//      _lawChaosAct(magnitude);
//    }
//    else { // Shift in morality.
//      _goodEvilAct(magnitude);
//    }
//  }

  // This will affect a character's lawful alignment. Acts can be lawful (positive), or chaotic (negative).
  void lawChaosAct([int magnitude = 1]) {
    if (magnitude > 0) { // It's a lawful act.
      if (_lawfulness < _MAX_LAWFULNESS) { // Ensure they aren't already at max lawfulness.
        _modLawfulness(magnitude);
      }
    }
    else { // It's a chaotic act. 
      if (_lawfulness > _MIN_LAWFULNESS) { // Ensure not already max chaotic.
        _modLawfulness(magnitude);
      }
    }
  }

  // This will affect a character's morality alignment. Acts can be good (positive), or evil (negative). 
  void goodEvilAct([int magnitude = 1]) {
    if (magnitude > 0) { // It's a good act.
      if (_morality < _MAX_MORALITY) { // Ensure they aren't already a saint.
        _modMorality(magnitude);
      }
    }
    else { // It's a chaotic act.
      if (_morality > _MIN_MORALITY) { // Ensure they aren't already a devil.
        _modMorality(magnitude);
      }
    }
  }

  // This will affect a character's morality alignment if they have remained neutral in a test of morality.
  void neutralMoralityAct([int magnitude = 1]) {
    if (_morality > 0) { // If they're more good than true neutral...
      if (magnitude > 0) { 
        magnitude = 0 - magnitude; // Make it negative, since it's bringing you closer to neutral.
      }
    }
    else if (_morality < 0) { // If they're more evil than true neutral...
      if (magnitude < 0 ) {
        magnitude = 0 - magnitude; // Make it positive, since it's bringing you closer to neutral.
      }
    }
    _modMorality(magnitude);
  }

  // This will affect a character's lawful alignment if they have remained neutral in a test of lawfulness.
  void neutralLawAct([int magnitude = 1]) { 
    if (_lawfulness > 0) { // If they're already more lawful than neutral...
      if (magnitude > 0) {
        magnitude = 0 - magnitude; // Make it negative.
      }
    }
    else if (_lawfulness < 0) { // If they're already more chaotic than neutral...
      if (magnitude < 0) {
        magnitude = 0 - magnitude; // Make it positive.
      }
    }
    _modLawfulness(magnitude);
  }

  String calcAlignment() {
    if (_lawfulness < -20) { // Chaotic
      if (_morality < -20) { // Evil
        return "Chaotic Evil";
      }
      else if (_morality > 20) { // Good
        return "Chaotic Good";
      }
      else { // Neutral
        return "Chaotic Neutral";
      }
    } // End Chaotic

    else if (_lawfulness > 20) { // Lawful
      if (_morality < -24) { // Evil
        return "Lawful Evil";
      }
      else if (_morality > 24) { // Good
        return "Lawful Good";
      }
      else { // Neutral
        return "Lawful Neutral";
      }
    }

    else { // Neutral
      if (_morality < -24) { // Evil
        return "Neutral Evil";
      }
      else if (_morality > 24) { // Good
        return "Neutral Good";
      }
      else { // Neutral
        return "Neutral Neutral";
      }
    }
  }

  void setByString(String al) {
    switch(al.toLowerCase()) {
      case 'lawful good' :
        _lawfulness = 60;
        _morality = 60;
        calcAlignment();
        break;
      case 'lawful neutral' :
        _lawfulness = 60;
        _morality = 0;
        calcAlignment();
        break;
      case 'lawful evil' :
        _lawfulness = 60;
        _morality = -60;
        calcAlignment();
        break;
      case 'neutral good' :
        _lawfulness = 0;
        _morality = 63;
        calcAlignment();
        break;
      case 'neutral neutral' :
        _lawfulness = 0;
        _morality = 0;
        calcAlignment();
        break;
      case 'neutral' :
        _lawfulness = 0;
        _morality = 0;
        calcAlignment();
        break;
      case 'neutral evil' :
        _lawfulness = 0;
        _morality = -63;
        calcAlignment();
        break;
      case 'chaotic good' :
        _lawfulness = -63;
        _morality = 63;
        calcAlignment();
        break;
      case 'chaotic neutral' :
        _lawfulness = -63;
        _morality = 0;
        calcAlignment();
        break;
      case 'chaotic evil' :
        _lawfulness = -63;
        _morality = -63;
        calcAlignment();
        break;
    }
  }

  void _modLawfulness(int value) {
    _lawfulness += value;
    calcAlignment();
  }

  void _modMorality(int value) {
    _morality += value;
    calcAlignment();
  }

  /// todo: get alignment working!
  String get score => _alignment;
  void set score(String al) {
    _alignment = al;
    setByString(al);
  }

  static List<String> get choices => alignments;
}
