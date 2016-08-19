import 'package:angular2/angular2.dart';

import '../../services/logger_service.dart';
import '../../services/character_service.dart';

import '../ability_view/ability_view.dart';
import '../../model/ability.dart';

@Component(selector: 'abilities-view',
    templateUrl: 'abilities_view.html',
    directives: const [AbilityView],
    providers: const [CharacterService]
)
class AbilitiesView {
  final LoggerService _log;
  List<Ability> abList;

  AbilitiesView(LoggerService this._log) {
    _log.info("$runtimeType()");
    abList = CharacterService.newCharacter.abilitiesList;
  }
}