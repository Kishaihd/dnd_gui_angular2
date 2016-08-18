import 'package:angular2/angular2.dart';

import '../../services/logger_service.dart';

@Component(selector: 'skills-view',
    templateUrl: 'skills_view.html',
    directives: const [],
    providers: const []
)
class SkillsView {
  final LoggerService _log;

  SkillsView(LoggerService this._log) {
    _log.info("$runtimeType()");
  }
}