import 'package:angular2/angular2.dart';

import '../../services/logger_service.dart';
import '../../services/character_service.dart';

import '../../components/abilities_div/abilities_div.dart';

@Component(selector: 'character-view',
    templateUrl: 'character_view.html',
    directives: const [AbilitiesDiv],
    providers: const [CharacterService]
)
class CharacterView {
  final LoggerService _log;
  final CharacterService characterService;

  //@ViewChild('myInput') ElementRef myInput;
  @ViewChild('nameInput') ElementRef nameInput;
  @ViewChild('alignmentInput') ElementRef alignmentInput;

  CharacterView(LoggerService this._log, CharacterService this.characterService) {
    _log.info("$runtimeType()");
  }

  void submit() {
    _log.info("$runtimeType()::submit()");

    //characterService.test = myInput.nativeElement.value;
  }

  void generate() {

  }

  String get name => characterService.newCharacter.name ?? nameInput.nativeElement.value;
  void set name(String nameIn) {
    characterService.newCharacter.name = nameIn;
  }

  String get alignment => characterService.newCharacter.alignment ?? alignmentInput.nativeElement.value;
  void set alignment(String alignmentIn) {
    characterService.newCharacter.alignment = alignment;
  }
}