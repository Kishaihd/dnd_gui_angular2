// Am I even going to use this? Should this be implemented in character view? Buh...

import 'package:angular2/angular2.dart';
import 'package:ng_bootstrap/ng_bootstrap.dart';

import '../../services/logger_service.dart';

import '../../model/entity.dart';
import '../../components/skills_div/skills_div.dart';
import '../../model/skill.dart';

@Component(selector: 'skills-view',
    templateUrl: 'skills_view.html',
    directives: const [SkillsDiv, NG_BOOTSTRAP_DIRECTIVES],
    providers: const []
)
class SkillsView {
  final LoggerService _log;

//  Map checkModel = {"left": false, "middle": false, "right": false};
  Map<String, bool> checkModel = {};

//  @Input() List<Skill> fullSkillList; // All the skills
//  List<Skill> classSkills;
//  @Input() int maxChoices;
  @Input() Entity character;
//  List<Skill> classSkills = [];


  int chosen = 0;

  SkillsView(LoggerService this._log) {
    _log.info("$runtimeType()");

    character?.allSkills?.forEach((Skill skill) {
      checkModel.putIfAbsent(skill?.name, () => false);
    });
//    character?.fullSkillList?.forEach((List<Skill> skList) {
//      skList?.forEach((Skill skill) {
//        checkModel.putIfAbsent(skill?.name, () => false);
//      });
//    });
//    if (character.characterClass != null && character.characterClass != "none") {
//      character.skills.forEach((String skill) {
//        checkModel.ad
//      });
//    }
  }

  void select(dynamic event) {
//    event.target.
  }

  void choose() {
    // stuff, and things! And then..
    chosen += 1;
  }

  void unChoose() {
    chosen -= 1;
  }

}