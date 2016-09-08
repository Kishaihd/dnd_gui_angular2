import 'package:angular2/angular2.dart';

import '../../services/logger_service.dart';
import '../../model/ability.dart';

@Component(selector: 'ability-view',
    templateUrl: 'ability_view.html',
    directives: const [],
    providers: const []
)
class AbilityView {
  final LoggerService _log;

  Ability ability;
  @Input() String name;
  @Input() int score;

  AbilityView(LoggerService this._log) {
    _log.info("$runtimeType()");
  }
}