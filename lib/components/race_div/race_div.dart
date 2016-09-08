import 'package:angular2/angular2.dart';
import 'package:ng_bootstrap/components/collapse/collapse.dart';
import 'package:ng_bootstrap/ng_bootstrap.dart';

import '../../services/logger_service.dart';

import '../../model/race.dart';
import '../../model/entity.dart';

@Component(selector: 'race-div',
  templateUrl: 'race_div.html',
  directives: const [Collapse]
)
class RaceDiv {
  final LoggerService _log;
  @Output() bool isCollapsed = true;

  @Input() Race race;
  @Input() Entity character;

  //List<String> visionList = [];

  RaceDiv(LoggerService this._log) {
    _log.info("$runtimeType()");

    //visionList = race.getVisionList();
//    if (race.vision.isNotEmpty) {
//      _log.info("$runtimeType()::add racial vision");
//      race.vision.forEach((String sight, int unused) {
//        visionList.add(sight);
//      });
//    }

  }

  void select() {
    _log.info("$runtimeType()::select()");
    if (race != null) {
      if (character != null) {
        character.race = race;
      }
    }
  }
}

