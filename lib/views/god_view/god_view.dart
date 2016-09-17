import 'package:angular2/angular2.dart';

import '../../services/logger_service.dart';

import '../../components/god_div/god_div.dart';
import '../../model/deity.dart';

import '../../model/entity.dart';

@Component(selector: 'god-view',
    templateUrl: 'god_view.html',
    directives: const [GodDiv],
    providers: const []
)
class GodView {
  final LoggerService _log;

  @Input() Entity character;
  @Input() List<Deity> dList = [];

  //List<Deity> shownList =[];

  GodView(LoggerService this._log) {
    _log.info("$runtimeType()");

//    character.deityList = dList;
//    if (character.alignment != "unaligned") {
//      if (dList.isNotEmpty) {
//        dList.forEach((Deity d) {
//          if (d.alignment == character.alignment) {
//            shownList.add(d);
//          }
//        });
//      }
//    }
  }
}