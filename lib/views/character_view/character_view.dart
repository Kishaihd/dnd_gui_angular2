import 'package:angular2/angular2.dart';

import '../../services/logger_service.dart';
import '../../services/character_service.dart';

import '../../components/abilities_div/abilities_div.dart';
import '../../components/skills_div/skills_div.dart';
import '../../model/entity.dart';
import '../../components/vu_selector/vu_selector.dart';

@Component(selector: 'character-view',
    templateUrl: 'character_view.html',
    directives: const [VuSelector, VuSelectable],//AbilitiesDiv],
    providers: const [] //CharacterService
)
class CharacterView {
  final LoggerService _log;
  //final CharacterService characterService;

  @Input() Entity character;
  @ViewChild('nameInput') ElementRef nameInput;



  CharacterView(LoggerService this._log) { //, CharacterService this.characterService) {
    _log.info("$runtimeType()");
  }

  void submit() {
    _log.info("$runtimeType()::submit()");
    //characterService.test = myInput.nativeElement.value;
  }

}