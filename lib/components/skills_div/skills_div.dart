import 'package:angular2/angular2.dart';

import '../../services/logger_service.dart';
import '../../model/skill.dart';

@Component(selector: 'skills-div',
    templateUrl: 'skills_div.html',
    directives: const [],
    providers: const []
)
class SkillsDiv {
  final LoggerService _log;

  @Input() Skill skill;
  @Input() int profBonus;

  SkillsDiv(LoggerService this._log) {
    _log.info("$runtimeType()");
  }

  void choose() {
    skill.selectSkill(profBonus);
  }
  void unChoose() {
    skill.deselectSkill();
  }

}