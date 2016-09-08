import 'package:angular2/angular2.dart';

import '../../services/logger_service.dart';
import '../../model/entity.dart';

import '../../model/race.dart';
import '../../components/race_div/race_div.dart';

@Component(selector: 'race-view',
    templateUrl: 'race_view.html',
    directives: const [RaceDiv],
    providers: const []
)
class RaceView {
  final LoggerService _log;

  @Input() List<Race> rList = [];
  @Input() Entity pc_in_race;

  RaceView(LoggerService this._log) {
    _log.info("$runtimeType()");
  }
}