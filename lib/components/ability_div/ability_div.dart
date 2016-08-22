import 'package:angular2/angular2.dart';

import '../../services/logger_service.dart';
import '../../services/character_service.dart';
import '../../model/ability.dart';

@Component(selector: 'ability-div',
    templateUrl: 'ability_div.html',
    directives: const [],
    providers: const [CharacterService]
)
class AbilityDiv {
  final LoggerService _log;

  @Input() Ability ability;
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
    ability.score = int.parse(value, onError: (_) => 0);
  }

  String get abMod => ability.modAsString();
}