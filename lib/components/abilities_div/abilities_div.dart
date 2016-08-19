import 'package:angular2/angular2.dart';

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
}