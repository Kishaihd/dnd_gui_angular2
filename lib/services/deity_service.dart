import 'package:angular2/angular2.dart';
import 'dart:html';
import 'dart:convert';
import 'dart:async';
import 'logger_service.dart';

import '../model/deity.dart';

@Injectable()
class DeityService {
  final LoggerService _log;
  static const String path = "../web/data/gods.json";

  List<Deity> deityList = [];

  List<List<Map<String, String>>> masterList = [];

  DeityService (LoggerService this._log) {
    _log.info("$runtimeType()");

    HttpRequest.getString(path)
        .then((String fileContents) {
      _log.info("$runtimeType()::${fileContents.length}");
      masterList = JSON.decode(fileContents);
      masterList.forEach((List<Map<String, String>> dList) {
        dList.forEach((Map<String, String> details) {
          deityList.add(new Deity.parameterized(details["name"], details["alignment"], details["description"], details["domains"], details["symbol"]));
        });
      });
    })
        .catchError((Error error) {
      print(error.toString());
    });
  }
}

