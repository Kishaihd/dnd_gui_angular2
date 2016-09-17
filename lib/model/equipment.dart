library model.equipment;

import 'dart:convert';
import 'dice.dart';
import 'modify.dart';

class Item {
  String _objType; //item / weapon / armor?
  String _name;
  String _type;
  String _size;
  int _value;
  int _weight;
  //final bool _equipable;
  bool _equipable;
  bool _isEquipped;
  String _description;
  bool _enchanted;
  int _magicBonusValue;
  String _location;

//  int _hardness;
//  int _hitPoints;

  Item([this._equipable]);

//  Item(this._name, this._type, this._size, this._value, this._weight, this._description, [this._equipable, this._enchanted = false, this._magicBonusValue = 0, this._location = ""]) {
//    _objType = "item";
//    _isEquipped = false;
//  }

  Item.fromMap(Map jsm): _equipable = jsm['equipable'] {
    //Map jsm = JSON.decode(js);
    _objType = "item";

    _name = jsm["name"];
    _type = jsm["type"];
    _size = jsm["size"];
    _value = jsm["value"];
    _weight = jsm["weight"];
    _description = jsm["description"];
    _enchanted = jsm["enchanted"];
    _magicBonusValue = jsm["magicBonusValue"];
    _location = jsm["location"];
    _isEquipped = false; // When first created.
  }



//  String capitalize(String word) {
//    String firstLetter = word[0].toUpperCase();
//
//    if (word.length > 1) {
//      return "${firstLetter}${word.substring(1)}";
//    }
//    return "${firstLetter}";
//  }

  void enchant(int bonusValue) {
    _enchanted = true;
    _description = _description == null ? "Enchanted $_name" : "Enchanted " + _description;
    _magicBonusValue = bonusValue;
  }

  String get objType => _objType;
  String get name => _name;
  String get type => _type;
  String get size => _size;
  int get value => _value;
  int get weight => _weight;
  bool get equipable => _equipable;
  bool get isEquipped => _equipable == true ? _isEquipped : false;
  int get magicBonus => _magicBonusValue;
  String get description {
    if (_description == null) {
      if (_enchanted) {
        return "Enchanted $_name";
      }
      else {
        return "$_name.";
      }
    } // End description == null
    else {
      if (_enchanted) {
        return "Enchanted $_description";
      }
      else {
        return "$_description.";
      }
    }
  }

  bool get isEnchanted => _enchanted;
  void set location(String loc) { _location = loc; }
  void set description(String describeMe) {
    if (_enchanted == true) {
      _description = "Enchanted" + describeMe;
    }
    else {
      _description = describeMe;
    }
  } // End set description.

  void set isEquipped(bool equip) {
    if (_equipable == true) {
      _isEquipped = equip;
    }
    else {
      _isEquipped = false;
    }
  }


} // End class Item.


class Armor extends Item {
  int _armorBonus;
  int _maxDex;
  int _movementPenalty;

  Armor(String name, String type, String size, int value, int weight, bool equipable, String location, int bonus, int maxDex, int movePenalty, [String description = "", bool enchanted = false, int magicBonusValue = 0]) {
    _objType = "armor";
    _location = location.toLowerCase();
    _armorBonus = bonus;
    _maxDex = maxDex;
    _movementPenalty = movePenalty;
  }

//  Item(this._name, this._type, this._size, this._value, this._weight, this._equipable, this._description, [this._enchanted = false, this._magicBonusValue = 0, this._location = ""]) {
//    _objType = "item";
//    if (_equipable == false) {
//      _isEquipped = false;
//    }
//  }


  Armor.fromMap(Map map) {
    if (map['objType'] == "armor") {
      _objType = "armor";
      _name = map['name'];
      _type = map['type'];
      _size = map['size'];
      _value = map['value'];
      _weight = map['weight'];
      _equipable = true;
      _location = map['location'];
      _armorBonus = map['bonus'];
      _maxDex = map['maxDex'];
      _movementPenalty = map['movementPenalty'];
      _description = map['description'];
      _enchanted = map['enchanted'];
      _magicBonusValue = map['magicBonusValue'];
//      _hitPoints = map['hitPoints'];
//      _hardness = map['hardness'];
    }

  }

  int get armorBonus => _enchanted == true ? (_magicBonusValue + _armorBonus) : _armorBonus;

//  @override toString() => "${capitalize(name)} \n   Location: ${capitalize(_location)} \n   AC bonus: $_armorBonus \n   Max Dexterity: $maxDex \n   Movement Penalty: $_movementPenalty";
  @override toString() => "${capitalize(name)} Location: ${capitalize(_location)} AC bonus: $_armorBonus Max Dexterity: $maxDex Movement Penalty: $_movementPenalty";

  //int get armorBonus => _armorBonus;
  int get movePenalty => _movementPenalty;
  String get location => capitalize(_location);
  int get maxDex => _maxDex == null ? 5 : _maxDex;

} // End class Armor.



class Weapon extends Item {
  int _damageDie;
  int _numDice;
  String _dmgType;
  int _magicDmgDie;
  int _numMagicDice;
  String _magicDmgType;
  DamageDice _dieRoll;
  DamageDice _magDieRoll;
//  List<String> _properties;


  Map<String, dynamic> _weaponProperties = {
    "Ammunition" : "Must have ammunition to attack with this weapon; Can recover half ammo at end of battle if one minute is spent; Can use ammo as an improvised weapon.",
    "Finesse" : "Can use Strength OR Dexterity for attacks and damage. Must use same ability for both"

  };

  Weapon(String name, String type, String size, int value, int weight, bool isEquipable, int dmgDie, int numDice, String dmgType, [String description, bool enchanted = false, int magicBonusValue = 0, int mgcDmgDieType = 0 /*d6*/, int numMgcDice = 0]) {
    _objType = "weapon";
    _damageDie = dmgDie;
    _numDice = numDice;
    _dmgType = dmgType;
    _magicDmgDie = mgcDmgDieType;
    _numMagicDice = numMgcDice;
    _dieRoll = new DamageDice(numDice, dmgDie);
    //_properties = properties;
    //_properties = [];
    if (enchanted) {
      _magDieRoll = new DamageDice(numMgcDice, mgcDmgDieType);
    }
  }

  Weapon.fromMap(Map map) {
    if (map['objType'] == "weapon") {
      _objType = "weapon";
      _name = map['name'];
      _type = map['type'];
      _size = map['size'];
      _value = map['value'];
      _weight = map['weight'];
      _equipable = true;
      _location = map['location'];
      _damageDie = map['damageDieType'];
      _numDice = map['numDice'];
      _dmgType = map['damageType'];
      _enchanted = map['enchanted'];
      _magicDmgDie = map['magicDamageDie'];
      _numMagicDice = map['numMagicDice'];
      _magicDmgType = map['magicDamageType'];
      _dieRoll = map['damageDieType'];
      _magDieRoll = map['damageDieType'];
      _description = map['description'];
      _magicBonusValue = map['magicBonusValue'];
//      _hitPoints = map['hitPoints'];
//      _hardness = map['hardness'];
      _dieRoll = new DamageDice(_numDice, _damageDie);
      //_properties = properties;
      //_properties = [];
      if (_enchanted) {
        _magDieRoll = new DamageDice(_numMagicDice, _magicDmgDie);
      }
    }

  }


  int rollDamage(){
    int damage = 0;
    if (_enchanted) {
      damage += _magDieRoll.rollDamage();
    }
    damage += _dieRoll.rollDamage();

    return damage;
  }


  @override toString() => "${capitalize(name)} ${_numDice}d${_damageDie} ${capitalize(dmgType)} damage.";

  void set location(String loc) { _location = loc ;}
  int get damageDie => _damageDie;
  int get numDice => _numDice;
  String get dmgType => _dmgType;
  int get magicDmg => _magicDmgDie == null ? 0 : _magicDmgDie;
  String get magicDmgType => _magicDmgType == null ? 0 : _magicDmgType;
  String get properties {
    String props = "";
    _weaponProperties.forEach((String pro, dynamic val) => props += pro + "\n");
    return props;
  }

}
//
//// Should I have a list somewhere of all the weapons? Mebe?
//class Scimitar implements Weapon {
//
//  Scimitar("Scimitar", "Melee", "Medium", 25, 3, 6, 1, "Slashing", "", ) : super("Scimitar", "Melee", "Medium", 25, 3, true, 6, 1, "Slashing") {
//    /*_name = "Scimitar";
//    _type = "Melee";
//    _size = "Medium";
//    _value = 25;
//    _weight = 3;
//    _damageDie = 6;
//    _numDice = 1;
//    _dmgType = "Slashing";
//    _description = "";
//    _weaponProperties.add("Light");
//    _weaponProperties.add("Finesse");*/
//  }
//}


// C'est necessaire?
class Inventory { // Basically just a custom Map class.
  Item _containerType;
  int _weight_containerType;
  int _weight_contents;
  int _value_containerType;
  int _value_contents;
  //var _item;
  List<dynamic> _inventory = [];

  Inventory([Item container]) {
    if (container != null) {
      _weight_containerType = container.weight;
      _value_containerType = container.value;
    }
    else {
      _weight_containerType = 0;
      _value_containerType = 0;
    }

    _weight_contents = 0;
    _value_contents = 0;
  }

  Inventory.fromMap() {

  }

  String get containerType => (_containerType != null) ? _containerType.name : "stationary storage" ;

  void addItem(dynamic item) {
    switch(item.objType) {
      case 'item' :
      case 'weapon' :
      case 'armor' :
        _inventory.add(item);
        break;
      default:
        break;
    }
  }

  void sortByWeight() {

  }

  void sortByValue() {

  }



//  void addItem(dynamic item) {
//    switch(item.objType) {
//      case 'item' :
//        break;
//      case 'weapon' :
//        break;
//      case 'armor' :
//        break;
//      default:
//        break;
//    }
//  }

}



