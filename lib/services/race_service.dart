import 'package:angular2/angular2.dart';
import 'dart:html';
import 'dart:convert';
import 'dart:async';
import 'logger_service.dart';

import '../model/race.dart';
import '../model/features.dart';

@Injectable()
class RaceService {
  final LoggerService _log;
//  static const String path = "../web/data/class_features.json";

  Race tiefling = new Tiefling();
  Race human = new Human();
  Race elf = new Elf();

  List<Race> raceList = [];

  RaceService(LoggerService this._log) {
    _log.info("$runtimeType()");

    raceList.add(tiefling);
    raceList.add(human);
    raceList.add(elf);
  }

//Map get classMap => classMap;

}

