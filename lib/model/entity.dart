library model.entity;

import '../services/logger_service.dart';

import 'ability.dart';
import 'alignment.dart';
import 'background.dart';
import 'character_class.dart';
import 'conditions.dart';
import 'deity.dart';
import 'equipment.dart';
import 'features.dart';
import 'modify.dart';
import 'race.dart';
import 'skill.dart';
import 'speed.dart';


class Entity {
  // Living attributes
  String _name;
  CharClass _charClass;
  Race _charRace;
  FeatureList _classFeatures;
  Background _background;
  String _type; // eg. Humanoid, Aberration, Construct etc.
  Alignment _alignment;
  String _size;
  Speed _movement;


  // Patron attributes
  Deity _deity;
  List<Deity> _deityList = []; // List of deities.
  String _patron;

  // Game attributes
  static const int BASE_AC = 10;
  int _level;
  int _hitDie;
  int _maxHitPoints;
  int _currentHitPoints;
  int _tempHitPoints;
  int _armorClass;
  bool _unarmored;
  int _proficiencyBonus;
  String _status;

  // Checklist to see if character creation is done.
  Map<String, bool> _doneExtras = {
    "hasDeity" : false,
    "hasPatron" : false
  };
  Map<String, bool> _doneEssentials = {
    "hasName" : false,
    "hasAbilities" : false,
    "hasSkills" : false,
    "hasClass" : false,
    "hasRace" : false,
    "hasBackground" : false,
    "hasFeatureList" : false,
    "hasType" : false,
    "hasAlignment" : false,
    "hasSize" : false,
    "hasMovement" : false,
    "hasLevel" : false,
    "hasHitDie" : false,
    "hasHP" : false,
    "hasAC" : false,
    "hasProficiencyBonus" : false,
    "hasStatus" : false
  };

  // Map of modified attributes
  List<Mod> _modList;
  List<Condition> _conditions;
//  Map<String, Map<String, int>> _characterMods; // Map< mod_name, Map <thing modified, mod_value>>

  // Equipment attributes
  Armor _armor;
  Weapon _weapon;
  List<Item> _itemList = [];
  List<Weapon> _weaponList = [];
  Map<String, Armor> _equippedList = {}; // Location, Armor

  Ability Strength = new Ability("Strength");
  Ability Dexterity = new Ability("Dexterity");
  Ability Constitution = new Ability("Constitution");
  Ability Intelligence = new Ability("Intelligence");
  Ability Wisdom = new Ability("Wisdom");
  Ability Charisma = new Ability("Charisma");

  List<Ability> abilities;

  // Strength skill.
  Skill Athletics;
  // Dexterity skills.
  Skill Acrobatics;
  Skill SleightOfHand;
  Skill Stealth;
  //Intelligence skills.
  Skill Arcana;
  Skill History;
  Skill Investigation;
  Skill Nature;
  Skill Religion;
  // Wisdom skills.
  Skill AnimalHandling;
  Skill Insight;
  Skill Medicine;
  Skill Perception;
  Skill Survival;
  // Charisma skills.
  Skill Deception;
  Skill Intimidation;
  Skill Performance;
  Skill Persuasion;

  // Skill Lists by corresponding Ability
  List<Skill> strSkills = [];
  List<Skill> dexSkills = [];
  List<Skill> intSkills = [];
  List<Skill> wisSkills = [];
  List<Skill> chaSkills = [];

  // Master Skill list
  List<List<Skill>> fullSkillList;

  // Does not include Constitution.
  List<int> abilitiesForSkills = [];

  Entity() {
    _status = "Normal";
    _level = 1;

    _alignment = new Alignment(); // Default. Set after creation.

    _movement = new Speed();
    abilities = [Strength, Dexterity, Constitution, Intelligence, Wisdom, Charisma];

    Athletics = new Skill.fromBlank("Athletics");
    Acrobatics = new Skill.fromBlank("Acrobatics");
    SleightOfHand = new Skill.fromBlank("SleightOfHand");
    Stealth = new Skill.fromBlank("Stealth");
    Arcana = new Skill.fromBlank("Arcana");
    History = new Skill.fromBlank("History");
    Investigation = new Skill.fromBlank("Investigation");
    Nature = new Skill.fromBlank("Nature");
    Religion = new Skill.fromBlank("Religion");
    AnimalHandling = new Skill.fromBlank("AnimalHandling");
    Insight = new Skill.fromBlank("Insight");
    Medicine = new Skill.fromBlank("Medicine");
    Perception = new Skill.fromBlank("Perception");
    Survival = new Skill.fromBlank("Survival");
    Deception = new Skill.fromBlank("Deception");
    Intimidation = new Skill.fromBlank("Intimidation");
    Performance = new Skill.fromBlank("Performance");
    Persuasion = new Skill.fromBlank("Persuasion");

    strSkills = [Athletics];
    dexSkills = [Acrobatics, SleightOfHand, Stealth];
    intSkills = [Arcana, History, Investigation, Nature, Religion];
    wisSkills = [AnimalHandling, Insight, Medicine, Perception, Survival];
    chaSkills = [Deception, Intimidation, Performance, Persuasion];

    ///todo: verify this is an okay way to do this.
    fullSkillList = [strSkills, dexSkills, intSkills, wisSkills, chaSkills];

    _armorClass = BASE_AC;
    _unarmored = true;


    /// todo: actually check done-ness. (1/2)
//    _doneEssentials["hasName"] = true;
//    _doneEssentials["hasAbilities"] = true;
//    _doneEssentials["hasSkills"] = true;
//    _doneEssentials["hasClass"] = true;
//    _doneEssentials["hasRace"] = true;
//    //  _doneEssentials["hasBackground"] = true;
//    //  _doneEssentials["hasFeatureList"] = true;
//    _doneEssentials["hasType"] = true;
//    _doneEssentials["hasAlignment"] = true;
//    _doneEssentials["hasSize"] = true;
//    _doneEssentials["hasMovement"] = true;
    _doneEssentials["hasLevel"] = true;
//    _doneEssentials["hasHitDie"] = true;
//    _doneEssentials["hasHP"] = true;
    _doneEssentials["hasAC"] = true;
//    _doneEssentials["hasProficiencyBonus"] = true;
    _doneEssentials["hasStatus"] = true;

  }


  // Parameterized constructor.
  // Name, Character's class, Race, ability scores.
//  Entity.parameterized(this._name, this._charRace, this._charClass, int strength, int dexterity, int constitution, int intelligence, int wisdom, int charisma) {
  Entity.parameterized(this._name, Race race, CharClass characterClass, int strength, int dexterity, int constitution, int intelligence, int wisdom, int charisma) {

    _status = "Normal";
    _level = 1;

    _charRace = race;
    _type = race.type;
    _size = race.size;
    _charClass = characterClass;
    _hitDie = characterClass.hitDie;
    _movement.addLandMod("Racial", race.racialLandSpeed);
    _movement.addSwimMod("Racial", race.racialSwimSpeed);
    _movement.addFlyMod("Racial", race.racialFlySpeed);
    _proficiencyBonus = characterClass.proficiencyBonus;
    _alignment = new Alignment.fromString("neutral"); // Default. Set after creation.

    // Put rolled stats into their respective abilities.
    Strength.setAbilityScore(strength);
    Dexterity.setAbilityScore(dexterity);
    Constitution.setAbilityScore(constitution);
    Intelligence.setAbilityScore(intelligence);
    Wisdom.setAbilityScore(wisdom);
    Charisma.setAbilityScore(charisma);
//    abilities = [Strength, Dexterity, Constitution, Intelligence, Wisdom, Charisma];

    // Now add Racial ability modifiers.
    addRacialAbilities(_charRace, abilities);

    // Calc HP.
    _maxHitPoints = (characterClass.hitDie + Constitution.mod);
    _currentHitPoints = _maxHitPoints;

    //
    Athletics = new Skill("Athletics", Strength);
    Acrobatics = new Skill("Acrobatics", Dexterity);
    SleightOfHand = new Skill("SleightOfHand", Dexterity);
    Stealth = new Skill("Stealth", Dexterity);
    Arcana = new Skill("Arcana", Intelligence);
    History = new Skill("History", Intelligence);
    Investigation = new Skill("Investigation", Intelligence);
    Nature = new Skill("Nature", Intelligence);
    Religion = new Skill("Religion", Intelligence);
    AnimalHandling = new Skill("AnimalHandling", Wisdom);
    Insight = new Skill("Insight", Wisdom);
    Medicine = new Skill("Medicine", Wisdom);
    Perception = new Skill("Perception", Wisdom);
    Survival = new Skill("Survival", Wisdom);
    Deception = new Skill("Deception", Charisma);
    Intimidation = new Skill("Intimidation", Charisma);
    Performance = new Skill("Performance", Charisma);
    Persuasion = new Skill("Persuasion", Charisma);

    strSkills = [Athletics];
    dexSkills = [Acrobatics, SleightOfHand, Stealth];
    intSkills = [Arcana, History, Investigation, Nature, Religion];
    wisSkills = [AnimalHandling, Insight, Medicine, Perception, Survival];
    chaSkills = [Deception, Intimidation, Performance, Persuasion];

    fullSkillList = [strSkills, dexSkills, intSkills, wisSkills, chaSkills];
    abilitiesForSkills = [Strength.mod, Dexterity.mod, Intelligence.mod, Wisdom.mod, Charisma.mod];

    skillsPlusAbilities(_charRace, _charClass);

    _armorClass = calcArmorClass();


    /// todo: actually check done-ness. (2/2)
    _doneEssentials["hasName"] = true;
    _doneEssentials["hasAbilities"] = true;
    _doneEssentials["hasSkills"] = true;
    _doneEssentials["hasClass"] = true;
    _doneEssentials["hasRace"] = true;
  //  _doneEssentials["hasBackground"] = true;
    _doneEssentials["hasFeatureList"] = true;
    _doneEssentials["hasType"] = true;
    _doneEssentials["hasAlignment"] = true;
    _doneEssentials["hasSize"] = true;
    _doneEssentials["hasMovement"] = true;
    _doneEssentials["hasLevel"] = true;
    _doneEssentials["hasHitDie"] = true;
    _doneEssentials["hasHP"] = true;
    _doneEssentials["hasAC"] = true;
    _doneEssentials["hasProficiencyBonus"] = true;
    _doneEssentials["hasStatus"] = true;

  } // End constructor.

  void _equipItem(Item item) {
    if (item != null) {
      _itemList.add(item);
    }
    else {
      // Nothing.
    }
  }

  //Map<String, Map> itemList = {};
  void _equipWeapon([Weapon weapon = null]) {
    if (weapon != null) {
      _weaponList.add(weapon);
    }
    else {
      // You haven't a weapon to equip, fool!
    }
  }

  void _equipArmor(Armor armr) {
    if (armr != null) {
      _equippedList.putIfAbsent(armr.location, () => armr);
      _unarmored = false;
      calcArmorClass();
    }
    else {
      // Nothing
    }
  }

  void equip(dynamic equipable) {
    if (equipable.runtimeType == Item) {
      _equipItem(equipable);
    }
    else if (equipable.runtimeType == Armor) {
      _equipArmor(equipable);
    }
    else if (equipable.runtimeType == Weapon) {
      _equipWeapon(equipable);
    }
  }

  void setAbilitiesForSkills() {
    abilitiesForSkills = [Strength.mod, Dexterity.mod, Intelligence.mod, Wisdom.mod, Charisma.mod];

  }

  int calcArmorClass() {
    _armorClass = 0;
    if (_equippedList.isNotEmpty) {
      _equippedList.forEach((String k, Armor armor) {
        _armorClass += armor.armorBonus;
      });
      if (_equippedList.containsKey("torso")) {
        int maxDex = _equippedList["torso"].maxDex;
        if (Dexterity.score > maxDex) {
          _armorClass += maxDex;
        }
        else {
          _armorClass += Dexterity.score;
        }
      }
    }
    else {
      _armorClass = (BASE_AC + Dexterity.mod);
    }

    if (_modList.isNotEmpty) {
      _modList.forEach((Mod mod) {
        if (mod.modType == "armor-class") {
          _armorClass += mod.value;
        }
      });
    }
    return _armorClass;
  }

  String showAcSources() {
    String armorBonuses;

    String baseArmor = "Base: $BASE_AC";
    String dex = "\nDexterity: ${Dexterity.mod}";
    String armor = "\nArmor: ";
    if (_equippedList["torso"].armorBonus == null) {
      armor += "0";
    }
    else {
      armor += "${_equippedList["torso"].name}[+${_equippedList["torso"].armorBonus}]";
    }
    String mods = "Misc: ";
    if (_modList.isNotEmpty) {
      _modList.forEach((Mod mod) {
        if (mod.modType == 'armor-class') {
          mods += "\n${mod.name} : ${mod.value}";
        }
      });
    }

    armorBonuses = baseArmor + dex + armor + mods;

    return armorBonuses;
  }

  // Add racial bonuses to Abilities.
  void addRacialAbilities(Race race, List<Ability> abilities) {
    abilities.forEach((Ability ability) {
      for (int i = 0; i < race.racialAbilities.length; i++) {
        if (ability.name == race.racialAbilities[i]) {
          ability.increaseAbility(race.racialAbilities[i]);
        } // End if
      } // End for
    }); // End .forEach
    _doneEssentials["hasRace"] = true;
  } // End addRacialAbilities()

  @override String toString() {
    StringBuffer sb = new StringBuffer();

    sb.writeln("Name: ${capitalize(_name)}   Race: ${capitalize(_charRace.name)}   Class: ${capitalize(_charClass.name)}  Level: $_level");
    sb.writeln("Alignment: ${capitalize(_alignment.calcAlignment())}   Size: ${capitalize(_size)}   Hit Die: ${_hitDie}");
    sb.writeln("HP: $_maxHitPoints   Armor Class: $_armorClass   Speed: $_movement");
    sb.writeln("Proficiency Bonus: $_proficiencyBonus   Status: ${capitalize(_status)}");
    sb.writeln(statBlock());
    sb.writeln("Deity: ${capitalize(_deity.name)} Patron: ${capitalize(_patron)}");
    sb.writeln("____________________");
    sb.writeln("Armor: ${_equippedList["torso"]}"); // {armorList["torso"].name}
    sb.writeln("____________________");
    sb.write("Weapon(s): ");
    _weaponList.forEach(sb.write);

    return sb.toString();
  }

  String statBlock() {
    StringBuffer sb = new StringBuffer();

    abilities.forEach((Ability ability) {
      sb.writeln("${ability.name}: ${ability.score}");  // Need \n ?
    });

    return sb.toString();
  }

  void chooseSkillProficiency(Skill skill) {
    skill.selectSkill(_charClass.proficiencyBonus);
  }

//  void refactor() {
//  }

  // First loops through and adds all ability modifiers to skills.
  void skillsPlusAbilities(Race race, CharClass charClass) {
    for (int idx = 0; idx < abilitiesForSkills.length; idx++) {
      fullSkillList[idx].forEach((Skill skill) {
        skill.addAbility(abilitiesForSkills[idx]);
      }); // End fullSkillList.forEach
    } // End for idx loop
  } // End skillsPlusAbilities()


//  void increaseStat(String stat, int bonus) {
//    stat = stat.toLowerCase();
//        int thisSkill;
//        bool foundSkill;
//        int skillIdx = 0;
//        do {
//          if (skillIdx >= skillList.length) {
//            break;
//          }
//          foundSkill = (skillList[skillIdx].containsKey(stat));
//          thisSkill = skillList[skillIdx][stat];
//          skillIdx++;
//        } while (foundSkill == false);
//
//        if (foundSkill == false) {
//          print("Skill not found!");
//        }
//        else {
//          skillIdx--;
//          skillList[skillIdx][stat] +=         }bonus;
//
//  }

  void takeDamage(int dmg) {
    _currentHitPoints -= dmg;
  }

  void heal(int healing) {
    if (_currentHitPoints == _maxHitPoints) {
      // Nothing
    }
    else {
      _currentHitPoints += healing;
      if (_currentHitPoints > _maxHitPoints) {
        _currentHitPoints = _maxHitPoints;
      }
    }
  }

  void changeStatus(String newStatus) {
    _status = newStatus;
    _doneEssentials["hasStatus"] = true;
    // Throw in some if (_status == _____)
    // statements to add mechanics and maybe flavor text.
  }

  int calcCurrentHP() {
    if (_currentHitPoints > 0) {
      if (_tempHitPoints > 0) {
        return _tempHitPoints + _currentHitPoints;
      }
      else {
        return _currentHitPoints;
      }
    }
    else {
      return 0;
    }
  }

  // Getters ===================================================================
  int get level => _level;
  CharClass get characterClass => _charClass;
  int get strength => Strength.score;
  int get dexterity => Dexterity.score;
  int get constitution => Constitution.score;
  int get intelligence => Intelligence.score;
  int get wisdom => Wisdom.score;
  int get charisma => Charisma.score;
  List<Ability> get abilitiesList => abilities;
  String get hitDie => "d${_charClass.hitDie}";
  int get maxHP => _maxHitPoints;
  int get currentHP => calcCurrentHP();
  int get tempHP => _tempHitPoints;
  int get AC => _armorClass;
  int get proficiencyBonus => _proficiencyBonus;
  int get landMovement => _movement.landSpeed;
  int get swimMovement => _movement.swimSpeed;
  int get flyMovement => _movement.flySpeed;
  String get name => _name;
//  String get size => _charRace.size ?? "";
  String get size => (_charRace != null) ? _charRace.size : "none";
//  String get raceName => _charRace.name ?? "";
  String get raceName => (_charRace != null) ? _charRace.name : "none";
//  String get className => _charClass.name ?? "";
  String get className => (_charClass != null) ? _charClass.name : "none";
//  List<String> get skills => _charClass?.skills;
  List<String> get skills => _charClass != null ? _charClass?.skills : [];
  ///todo: verify that this isn't as shitty as I'm feeling like it is.
  List<Skill> get allSkills {
    List<Skill> skillsList = [];
    fullSkillList.forEach((List<Skill> skList) {
      skList.forEach((Skill skill) {
          skillsList.add(skill);
      });
    });
    return skillsList;
  }
//  List<Skill> get skills {
//
//  }

//  List<String> get skills => _charClass == null ? [] : _charClass.skills; // In case the above does not work.
  //List<String> get classList => CharClass.classList;
  String get creatureType => _type ?? "humanoid";
//  String get creatureType => _type == null ? "humanoid" : _type; // eg. Humanoid, Abberation, Construct etc.
  String get alignment => _alignment.score;
  Alignment get alignmentObject => _alignment;
  List<String> get alignmentChoices => Alignment.alignments;
  String get status => _status;
  String get deity => _deity == null ? "None" : _deity.name;
  List<Deity> get deityList => _deityList == null ? [] : _deityList;
  String get patron => _patron == null ? "None" : _patron;
  /// todo: Verify isComplete() will actually work.
  int numIncomplete() {
    int doneIsZero;

    if (_charRace != null) {
      doneIsZero = 0;
    }
    else {
      doneIsZero = 1;
    }

    if (_charClass != null) {
      doneIsZero = 0;
    }
    else {
      doneIsZero += 1;
    }

    abilities.forEach((Ability ab) {
      if (ab == null) {
        doneIsZero += 1;
      }
    });

    if (_name != null) {
      doneIsZero = 0;
    }
    else {
      doneIsZero += 1;
    }

    if (_type != null) {
      doneIsZero = 0;
    }
    else {
      doneIsZero += 1;
    }

    if (_size != null) {
      doneIsZero = 0;
    }
    else {
      doneIsZero += 1;
    }

    if (_alignment != null) {
      doneIsZero = 0;
    }
    else {
      doneIsZero += 1;
    }

    if (_hitDie != null) {
      doneIsZero = 0;
    }
    else {
      doneIsZero += 1;
    }

    if (_status != null) {
      doneIsZero = 0;
    }
    else {
      doneIsZero += 1;
    }

    if (_movement != null) {
      doneIsZero = 0;
    }
    else {
      doneIsZero += 1;
    }

    return doneIsZero;
  }

  bool isCompleted() {
    bool doneCheck = false;

    abilitiesList.forEach((Ability ab) {
      if (ab != null && ab.score > 0) {
        _doneEssentials["hasAbilities"] = true;
      }
      else {
        _doneEssentials["hasAbilities"] = false;
      }
    });
    _doneEssentials.forEach((String reason, bool truth) {
      if (truth == false) {
        print("Character is incomplete. $reason: $truth");
        return false;
      }
      else {
        doneCheck = true;
      }
    });
    return doneCheck;
  }
//  // "Generic" getter that returns any single skill and value.
//  int getSkill(String skillName) {
//    skillName = skillName.toLowerCase();
//    int thisSkill;
//    bool foundSkill;
//    int skillIdx = 0;
//    do {
//      if (skillIdx >= skillList.length) {
//        break;
//      }
//      foundSkill = (skillList[skillIdx].containsKey(skillName));
//      thisSkill = skillList[skillIdx][skillName];
//      skillIdx++;
//    } while (foundSkill == false);
//
//    if (foundSkill == false) {
//      print("Skill not found!");
//      return 0;
//    }
//    else {
//      print("$skillName: $thisSkill");
//      return thisSkill;
//    }
//  }

  // Setters
//  void set strength(int str) { _strength = str;}
//  void set dexterity(int dex) {_dexterity = dex;}
//  void set constitution(int con) { _constitution = con;}
//  void set intelligence(int intl) { _intelligence = intl;}
//  void set wisdom(int wis) { _wisdom = wis;}
//  void set charisma(int cha) { _charisma = cha;}
  void set currentHP(int hp) { _currentHitPoints = hp;}
  void set size(String size) {
    _size = size;
    _doneEssentials["hasSize"] = true;
  }
  void set level(int lvl) { _level = lvl;}
  void set HD(int hd) {
    _hitDie = hd;
    _doneEssentials["hasHitDie"] = true;
  }
//  void set maxHP(int hpMax) {_maxHitPoints = hpMax;}
  //void set AC(int ac) { _armorClass = ac;} // Calculated automatically.
  //void set proficiencyBonus(int prof) { _proficiency = prof;}
  //void set movement => _movement
  void set name(String name) {
    _name = name;
    _doneEssentials["hasName"] = true;
  }
  void set characterClass(CharClass charClass) {
    if (_charClass != null) { // a charClass had previously been applied to character.
      if (charClass == _charClass) {
        /// todo: add growl. This has already been applied!
        return;
      }
      else { // Changed mind. Remove old values/ mods.
        fullSkillList.forEach((List<Skill> skList) {
          skList.forEach((Skill skill) {
            if (skill.isAClassSkill) {
              skill.isAClassSkill = false;
            }
          });
        });
      }
    }
      _charClass = charClass;
      _proficiencyBonus = charClass.proficiencyBonus;
      _hitDie = charClass.hitDie;
      charClass.skills.forEach((String classSkill) {
        fullSkillList.forEach((List<Skill> skList) {
          skList.forEach((Skill skill) {
            if (skill.name.toLowerCase() == classSkill.toLowerCase()) {
              skill.isAClassSkill = true;
            }
          });
        });
      });
      _doneEssentials["hasClass"] = true;
      _doneEssentials["hasProficiencyBonus"] = true;
      _doneEssentials["hasHitDie"] = true;
  }
  void set race(Race race) {
    if (_charRace != null) { // Race had previously been applied to character.
      if (race == _charRace) { // Just multi-clicking the same race. Being dumb.
        /// todo: Add a growl saying this race has already been chosen!:D
        return;
      }
      else { //Had race, changed mind. Remove old values/mods.
        _movement.removeLandMod("Racial");
        _movement.removeSwimMod("Racial");
        if (_charRace.canFly()) {
          _movement.removeFlyMod("Racial");
        }

        abilitiesList.forEach((Ability charAbility) {
          _charRace.racialAbilities.forEach((String oldRacialAbility, int oldValue) {
            if (oldRacialAbility.toLowerCase() == charAbility.name.toLowerCase()) {
              charAbility.decreaseAbility(oldValue);
            }
          });
        });
      }
    }
    _charRace = race;
    _movement.addLandMod("Racial", race.racialLandSpeed);
    _movement.addSwimMod("Racial", race.racialSwimSpeed);
    if (race.canFly()) {
      _movement.addFlyMod("Racial", race.racialFlySpeed);  // Somehow document whether or not char can fly.
    }
    _size = race.size;
    _type = race.type;

    abilitiesList.forEach((Ability charAbility) {
      race.racialAbilities.forEach((String racialAbility, int value) {
        if (racialAbility.toLowerCase() == charAbility.name.toLowerCase()) {
          charAbility.increaseAbility(value);
        }
      });
    });

    _doneEssentials["hasRace"] = true;
    _doneEssentials["hasMovement"] = true;
    _doneEssentials["hasType"] = true;
    _doneEssentials["hasSize"] = true;
  }


  void set alignment(String alignment) {
  _alignment.score = alignment;
//    _alignment.setByString(alignment);
  _doneEssentials["hasAlignment"] = true;
  }
  void setAbilitiesByList(List<Ability> incomingList) {
    if (incomingList[0].name == "Strength") {
      setAbilitiesByObject(incomingList[0], incomingList[1], incomingList[2], incomingList[3], incomingList[4], incomingList[5]);
    }
//    incomingList.forEach((Ability newAb) {
//        abilities.forEach((Ability ab) {
//          if (ab.name == newAb.name) {
//            ab.setAbilityScore(newAb.score);
//          }
//        });
//      });
    abilities = [Strength, Dexterity, Constitution, Intelligence, Wisdom, Charisma];
    abilitiesForSkills = [Strength.mod, Dexterity.mod, Intelligence.mod, Wisdom.mod, Charisma.mod];
    _doneEssentials["hasAbilities"] = true;
  }

  void setAbilitiesByInt(int str, int dex, int con, int intl, int wis, int cha) {
    Strength.setAbilityScore(str);
    Dexterity.setAbilityScore(dex);
    Constitution.setAbilityScore(con);
    Intelligence.setAbilityScore(intl);
    Wisdom.setAbilityScore(wis);
    Charisma.setAbilityScore(cha);
    abilities = [Strength, Dexterity, Constitution, Intelligence, Wisdom, Charisma];
    abilitiesForSkills = [Strength.mod, Dexterity.mod, Intelligence.mod, Wisdom.mod, Charisma.mod];
    _doneEssentials["hasAbilities"] = true;
  }

  void setAbilitiesByObject(Ability str, Ability dex, Ability con, Ability int, Ability wis, Ability cha) {
    Strength.setAbilityScore(str.score);
    Dexterity.setAbilityScore(dex.score);
    Constitution.setAbilityScore(con.score);
    Intelligence.setAbilityScore(int.score);
    Wisdom.setAbilityScore(wis.score);
    Charisma.setAbilityScore(cha.score);
    abilities = [Strength, Dexterity, Constitution, Intelligence, Wisdom, Charisma];
    abilitiesForSkills = [Strength.mod, Dexterity.mod, Intelligence.mod, Wisdom.mod, Charisma.mod];
    _doneEssentials["hasAbilities"] = true;
  }
//  void set type(String type) { _type = type;} // eg. Humanoid, Abberation, Construct etc.
  void set status(String status) {
    _status = status;
    _doneEssentials["hasStatus"] = true;
  }

  void set deityList(List<Deity> dL) {
    _deityList = dL ?? [];
  }

  void set deity(String deity) {
    if (_deityList != null && _deityList.isNotEmpty) {
      _deityList.firstWhere((Deity d) {
        d.name == deity;
        setDeity(d);
      });
    }
  }

  void setDeity(Deity d) {
    _deity = d;
    if (_patron == null || _patron == "") {
      _patron = d.name;
    }
    _doneEssentials["hasDeity"] = true;
  }
//  void set deity(String deity) {
//    _deity = deity;
//    _doneEssentials["hasDeity"] = true;
//  }
  void set patron(String patron) {
    _patron = patron;
    _doneEssentials["hasPatron"] = true;
  }
  void calcHpAtLevelOne() {
    if (_hitDie > 0) {
      _maxHitPoints = Constitution.mod + _hitDie;
      _doneEssentials["hasHP"] = true;
    }
    else {
      /// todo: this should use the logger!
      print("No HP at level one!");
    }
  }

  void handleMod(Mod mod) {
    _modList.add(mod);

    switch (mod.modType) {
    //////////////   HP    /////////////
      case 'hp' :
        if (mod.affects == "temprorary-hp") {
          if (_tempHitPoints > 0) {
            if (mod.value > _tempHitPoints) {
              _tempHitPoints = mod.value;
            }
            else {
              //They stay the same
            }
          }
          else {
            _tempHitPoints = mod.value;
          }
        }
        else if (mod.affects == "permanent-hp") {
          _maxHitPoints += mod.value;
        }
        break;
    ///////////   Ability   //////////////
      case 'ability' :
        if (mod.affects == "strength") {

        }
        break;
    }
  }

//  void addAbilityMod(Mod_Ability mod) {
//    Ability ab = abilities.firstWhere((Ability ability) {
//      ability.name == mod.ability;
//    });
//
//    abilities[ abilities.indexOf(ab) ].increaseTempAbility(mod.value);
//
//    _modList.add(mod);
//
//  }
//
//  void removeAbilityMod(String modName) {
//    Mod_Ability mAb = _modList.singleWhere((Mod_Ability mod) {
//      mod.name == modName;
//    });
//    Ability ab = abilities.firstWhere((Ability ability) {
//      ability.name == modName;
//    });
//
//    abilities[ abilities.indexOf(ab) ].decreaseTempAbility(mAb.value);
//    _modList.removeWhere((Mod_Ability mod) {
//      mod.name == modName;
//    });
////    _characterMods[mod.name].addAll(modMap);
//  }

  void addCondition(Condition cd) {
    _conditions.add(cd);
  }

  void removeConditionByName(String cd) {
    _conditions.removeWhere((condition) => condition.name == cd);
  }

  void removeConditionByObj(Condition cd) { // Should this be a string to look it up by name?
    _conditions.removeWhere((condition) => condition.name == cd.name);
  }

  // Mebe format this a little better?
  List<Condition> get conditions {
    return _conditions;
  }

} // End class Entity




