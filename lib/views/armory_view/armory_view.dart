import 'package:angular2/angular2.dart';

import '../../services/logger_service.dart';

@Component(selector: 'armory-view',
    templateUrl: 'armory_view.html',
    directives: const [],
    providers: const []
)
class ArmoryView {
  final LoggerService _log;

  ArmoryView(LoggerService this._log) {
    _log.info("$runtimeType()");
  }
}