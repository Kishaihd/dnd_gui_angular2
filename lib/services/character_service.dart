import 'package:angular2/angular2.dart';
import 'logger_service.dart';
import '../model/entity.dart';

@Injectable()
class CharacterService {
  final LoggerService _log;

  Entity newCharacter = new Entity();

  String test = "boner";

  CharacterService(LoggerService this._log) {
    _log.info("$runtimeType()");
  }
}
