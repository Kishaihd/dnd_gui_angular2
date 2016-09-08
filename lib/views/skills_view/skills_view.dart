// Am I even going to use this? Should this be implemented in character view? Buh...

import 'package:angular2/angular2.dart';

import '../../services/logger_service.dart';

import '../../components/skills_div/skills_div.dart';
import '../../model/skill.dart';

@Component(selector: 'skills-view',
    templateUrl: 'skills_view.html',
    directives: const [SkillsDiv],
    providers: const []
)
class SkillsView {
  final LoggerService _log;

  @Input() int maxChoices;
  @Input() List<Skill> skillList;

  int chosen = 0;

  SkillsView(LoggerService this._log) {
    _log.info("$runtimeType()");
  }

  void choose() {
    // stuff, and things! And then..
    chosen += 1;
  }

  void unChoose() {
    chosen -= 1;
  }

}