import 'package:angular2/angular2.dart';

import '../../services/logger_service.dart';
import '../../services/character_service.dart';

@Component(selector: 'character-view',
    templateUrl: 'character_view.html',
    directives: const [],
    providers: const []
)
class CharacterView {
  final LoggerService _log;
  final CharacterService characterService;

  @ViewChild('myInput') ElementRef myInput;

  CharacterView(LoggerService this._log, CharacterService this.characterService) {
    _log.info("$runtimeType()");
  }

  void submit() {
    _log.info("$runtimeType()::submit()");

    characterService.test = myInput.nativeElement.value;
  }
}