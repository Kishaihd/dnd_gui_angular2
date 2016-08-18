class Stats
{
  int hitPoints = 0;

  Map<String, int> abilities = {
    "strength": 0,
    "dexterity": 0,
    "constitution": 0,
    "intelligence": 0,
    "wisdom": 0,
    "charisma": 0
  };

  Map ailments = {};

  Stats() {
    abilities.forEach((k, v) {
      v = 10;
    });
  }

  int getAbility(String ab) {
    int score;
    abilities.forEach((k, v) {
      if (k == ab) {
        score = v;
      }
      else {
        score = -1;
      }
    });
    return score;
  }

}