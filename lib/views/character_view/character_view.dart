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

  int _alignmentSelected;

  @Input() Entity character;
  //@ViewChild('myInput') ElementRef myInput;
  @ViewChild('nameInput') ElementRef nameInput;
//  @ViewChild('alignmentInput') ElementRef alignmentInput;



  CharacterView(LoggerService this._log) { //, CharacterService this.characterService) {
    _log.info("$runtimeType()");
  }

  void submit() {
    _log.info("$runtimeType()::submit()");
    //characterService.test = myInput.nativeElement.value;
  }

  void generate() {

  }


  //String get name => characterService.newCharacter.name ?? nameInput.nativeElement.value;
  String get name {
    if (character.name != null && character.name != "") {
      return character.name;
    }
    else {
      return nameInput.nativeElement.value;
    }
  }
  void set name(String nameIn) {
    _log.info("$runtimeType()::set name");
    character.name = nameIn;
  }

  int get alignmentSelected => _alignmentSelected;

  void set alignmentSelected(int al) {
    _alignmentSelected = al;
    character.alignment = character.alignmentChoices[al];
  }

//  String get alignment => character.alignmentObject.score ?? alignmentInput.nativeElement.value;
//  void set alignment(String alignmentIn) {
//    _log.info("$runtimeType()::set alignment");
//    character.alignmentObject.setByString(alignmentIn); // = alignment;
//  }

//  void setAlignment(alignmentIn) {
//    _log.info("$runtimeType()::setAlignment");
//    character.alignmentObject.setByString(alignmentIn); // = alignment;
//  }

}