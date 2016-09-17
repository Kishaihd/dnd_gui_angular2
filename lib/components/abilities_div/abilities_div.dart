import 'package:angular2/angular2.dart';
import 'dart:math' show Random;

import '../../services/logger_service.dart';
import '../../services/character_service.dart';

import '../ability_div/ability_div.dart';
import '../../model/ability.dart';


@Component(selector: 'abilities-div',
    templateUrl: 'abilities_div.html',
    directives: const [AbilityDiv]

)
class AbilitiesDiv {
  final LoggerService _log;
  @Input() List<Ability> abList;

  AbilitiesDiv(LoggerService this._log) {
    _log.info("$runtimeType()");
    //abList = CharacterService.newCharacter.abilitiesList;
  }

  /// todo: Get stats-randomizer working!
  void rollStats() {
    _log.info("$runtimeType()::rollStats()");
    abList.forEach((Ability ab) {
      int stat = 0;
      for (int rolls = 0; rolls < 3; rolls++) {
        stat += new Random().nextInt(6) + 1;
      }
      ab.setAbilityScore(stat);
    });
  }

}