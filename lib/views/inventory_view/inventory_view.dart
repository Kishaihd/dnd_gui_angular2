import 'package:angular2/angular2.dart';

import '../../services/logger_service.dart';

@Component(selector: 'inventory-view',
    templateUrl: 'inventory_view.html',
    directives: const [],
    providers: const []
)
class InventoryView {
  final LoggerService _log;

  InventoryView(LoggerService this._log) {
    _log.info("$runtimeType()");
  }
}