import 'package:angular2/angular2.dart';

import '../../services/logger_service.dart';

@Component(selector: 'skill-div',
    templateUrl: 'skill_div.html',
    directives: const [],
    providers: const []
)
class SkillDiv {
  final LoggerService _log;

  SkillDiv(LoggerService this._log) {
    _log.info("$runtimeType()");
  }
}