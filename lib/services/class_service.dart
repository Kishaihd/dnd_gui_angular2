import 'package:angular2/angular2.dart';
import 'dart:html';
import 'dart:convert';
import 'dart:async';
import 'logger_service.dart';

import '../model/character_class.dart';
import '../model/features.dart';

@Injectable()
class ClassService {
  final LoggerService _log;
  static const String path = "../web/data/class_features.json";

  //CharClass cClass = new CharClass(); // Necessary?

  //CharClass barbarian = new Barbarian();
  CharClass bard = new Bard();
  //CharClass cleric = new Cleric();
  //CharClass druid = new Druid();
  //CharClass fighter = new Fighter();
  //CharClass monk = new Monk();
  //CharClass paladin = new Paladin();
  CharClass ranger = new Ranger();
  //CharClass rogue = new Rogue();
  CharClass warlock = new Warlock();

  List<Map<String, List<List<Map<String, String>>>>> masterList;
  //List masterList;

  Map<String, CharClass> classMap = {};
  List<CharClass> classList = [];

  ClassService(LoggerService this._log) {
    _log.info("$runtimeType():: Http start");
    classMap.putIfAbsent("ranger", () => ranger);
    classMap.putIfAbsent("bard", () => bard);
    classMap.putIfAbsent("warlock", () => warlock);
    HttpRequest.getString(path)
      .then((String fileContents) {
        print(fileContents.length);
        masterList = JSON.decode(fileContents);
        masterList.forEach((Map map) {
          map.forEach((String cfName, List lst) {
            classMap.forEach((String cName, CharClass cls) {
              if (cfName == cName) {
                if (lst != null) {
                  classMap[cName].setClassFeaturesFromList(lst);
                  print(classMap[cName].name);
                }
              }
            });
          });
        });
      })
      .catchError((Error error) {
        print(error.toString());
      });

    classMap.forEach((String name, CharClass charClass) {
      if (charClass != null) {
        classList.add(charClass);
      }
    });

    _log.info("$runtimeType():: Http finish");
    //newCharacter = new Entity();
  }

  //Map get classMap => classMap;

}

