import 'package:angular2/angular2.dart';

import '../../services/logger_service.dart';

@Component(selector: 'geo-view',
    templateUrl: 'geo_view.html',
    directives: const [],
    providers: const []
)
class GeoView {
  final LoggerService _log;

  GeoView(LoggerService this._log) {
    _log.info("$runtimeType()");
  }
}