import 'package:angular2/angular2.dart';

import '../../services/logger_service.dart';

@Component(selector: 'abilities-view',
    templateUrl: 'abilities_view.html',
    directives: const [],
    providers: const []
)
class AbilitiesView {
  final LoggerService _log;

  AbilitiesView(LoggerService this._log) {
    _log.info("$runtimeType()");
  }
}