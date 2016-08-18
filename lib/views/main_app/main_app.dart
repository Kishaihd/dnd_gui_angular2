import 'package:angular2/angular2.dart';

import '../../services/logger_service.dart';
import '../../services/character_service.dart';
import '../character_view/character_view.dart';

@Component(selector: 'main-app',
    templateUrl: 'main_app.html',
    directives: const [CharacterView],
    providers: const [CharacterService]
)
class MainApp {
  final LoggerService _log;

  MainApp(LoggerService this._log) {
    _log.info("$runtimeType()");
  }
}