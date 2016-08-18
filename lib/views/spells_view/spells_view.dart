import 'package:angular2/angular2.dart';

import '../../services/logger_service.dart';

@Component(selector: 'spells-view',
    templateUrl: 'spells_view.html',
    directives: const [],
    providers: const []
)
class SpellsView {
  final LoggerService _log;

  SpellsView(LoggerService this._log) {
    _log.info("$runtimeType()");
  }
}