import 'package:angular2/angular2.dart';
import 'package:ng_bootstrap/ng_bootstrap.dart';
import 'package:ng_bootstrap/components/tabs/tabs.dart';

import 'dart:math' show Random;

import '../../services/logger_service.dart';
import '../../services/character_service.dart';
import '../../services/class_service.dart';
import '../../services/race_service.dart';
import '../../services/deity_service.dart';

import '../basics_view/basics_view.dart';
import '../character_view/character_view.dart';
import '../../components/abilities_div/abilities_div.dart';
import '../../model/ability.dart';
import '../class_view/class_view.dart';
import '../../components/skills_div/skills_div.dart';
import '../../views/skills_view/skills_view.dart';
import '../../views/race_view/race_view.dart';
import '../../views/god_view/god_view.dart';

@Component(selector: 'main-app',
    templateUrl: 'main_app.html',
    directives: const [NG_BOOTSTRAP_DIRECTIVES, NG_BOOTSTRAP_TABS_DIRECTIVES, BasicsView, CharacterView, AbilitiesDiv, ClassView, SkillsDiv, RaceView, GodView, SkillsView],
    providers: const [CharacterService, ClassService, RaceService, DeityService]
)
class MainApp {
  final LoggerService _log;
  final CharacterService characterService;
  final ClassService classService;
  final RaceService raceService;
  final DeityService deityService;

  MainApp(LoggerService this._log, CharacterService this.characterService, ClassService this.classService, RaceService this.raceService, DeityService this.deityService) {
    _log.info("$runtimeType()");
    characterService.pc.deityList = deityService.deityList;
  }

  void printCharacter() {
    _log.info("$runtimeType()::printCharacter()");
    _log.info("${characterService.pc.name}");
    _log.info("${characterService.pc.className}");
    _log.info("${characterService.pc.raceName}");
    _log.info("${characterService.pc.proficiencyBonus}");
    _log.info("${characterService.pc.alignmentObject.score}");
    _log.info("${characterService.pc.alignment}");
    _log.info("${characterService.pc.isCompleted()}");
    _log.info("${characterService.pc.numIncomplete()}");

  }

  void rollStats() {
    _log.info("$runtimeType()::rollStats()");
    characterService.pc.abilitiesList.forEach((Ability ab) {
      int stat = 0;
      for (int rolls = 0; rolls < 3; rolls++) {
        stat += new Random().nextInt(6) + 1;
      }
      ab.setAbilityScore(stat);
    });
  }

}