import'package:angular2/angular2.dart';
import 'package:ng_bootstrap/ng_bootstrap.dart';
import 'package:ng_bootstrap/components/collapse/collapse.dart';

import '../../services/logger_service.dart';
//import '../../services/character_service.dart';

import '../../model/character_class.dart';
import '../../model/entity.dart';

@Component(selector: 'class-div',
  templateUrl: 'class_div.html',
  directives: const [Collapse, NG_BOOTSTRAP_DIRECTIVES] //BsCollapseDirective
)
class ClassDiv {
  final LoggerService _log;
  bool isCollapsed = true;

  @Input() CharClass charClass;
  @Input() Entity character;

  ClassDiv(LoggerService this._log) {
    _log.info("$runtimeType()");
  }

//  String get cName => charClass.name;
//  void set cClass(CharClass cc) {
////    if (cc == CharClass) {
//      // (cc.runtimeType == CharClass) {
//      charClass = cc;
////    }
////    else {
//      // idk, cry a bit?
////    }
//  }

  void select() {
    _log.info("$runtimeType()::select()   ");
    if (charClass != null) {
      if (character != null) {
        character.characterClass = charClass;
      }
      //character.characterClass(charClass);
    }
  }
}