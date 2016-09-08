import 'package:angular2/angular2.dart';

import '../../services/logger_service.dart';
import '../../services/character_service.dart';
import '../../model/ability.dart';
import '../../model/entity.dart';

@Component(selector: 'ability-div',
    templateUrl: 'ability_div.html',
    directives: const [],
    providers: const [] //CharacterService
)
class AbilityDiv {
  final LoggerService _log;

  @Input() Ability ability;
  @Input() Entity character;
//  String name;
//  int score;

  AbilityDiv(LoggerService this._log) {
    _log.info("$runtimeType()");
//    name = ability.name;
//    if (ability.score != null && ability.score > 0) {
//      score = ability.score;
//    }
//    else {
//      score = 8;
//      ability.setAbilityScore(score);
//    }
  }

  String get score => ability.score.toString();
  void set score(String value) {
    int score = int.parse(value, onError: (_) => 0);
    character.abilitiesList.firstWhere((Ability ab) {
      ab.name == ability.name;
    }).setAbilityScore(score);
    //ability.setAbilityScore(score);
  }

  String get abMod => ability.modAsString();
}