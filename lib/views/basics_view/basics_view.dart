import 'package:angular2/angular2.dart';

import '../../services/logger_service.dart';
import '../../services/character_service.dart';

import '../../components/abilities_div/abilities_div.dart';
import '../../components/skills_div/skills_div.dart';
import '../../model/entity.dart';
import '../../components/vu_selector/vu_selector.dart';

@Component(selector: 'basics-view',
    templateUrl: 'basics_view.html',
    directives: const [VuSelector, VuSelectable],
    providers: const []
)
class BasicsView {
  final LoggerService _log;

  BasicsView(LoggerService this._log) {
    _log.info("$runtimeType()");
  }

  int _alignmentSelected;

  @Input() Entity character;
  //@ViewChild('myInput') ElementRef myInput;
  @ViewChild('nameInput') ElementRef nameInput;
//  @ViewChild('alignmentInput') ElementRef alignmentInput;

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


}