import 'package:angular2/angular2.dart';

import '../../services/logger_service.dart';
import '../../model/skill.dart';
import '../skill_div/skill_div.dart';

@Component(selector: 'skills-div',
    templateUrl: 'skills_div.html',
    directives: const [SkillDiv],
    providers: const []
)
class SkillsDiv {
  final LoggerService _log;

  @Input() List<Skill> racialSkills;
  @Input() Skill miscSkills;
  @Input() int profBonus;

  SkillsDiv(LoggerService this._log) {
    _log.info("$runtimeType()");
  }

  void choose() {
    //racialSkill.selectSkill(profBonus);
  }
  void unChoose() {
    //skill.deselectSkill();
  }

}