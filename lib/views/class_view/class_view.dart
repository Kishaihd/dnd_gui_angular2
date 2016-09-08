import 'package:angular2/angular2.dart';

import '../../services/logger_service.dart';
import '../../services/class_service.dart';

//maybe?
import '../../model/entity.dart';

import '../../model/character_class.dart';
import '../../components/class_div/class_div.dart';

@Component(selector: 'class-view',
    templateUrl: 'class_view.html',
    directives: const [ClassDiv],
    providers: const [] //ClassService
)
class ClassView {
  final LoggerService _log;
  //final ClassService classService;

  @Input() List<CharClass> cList = [];
  @Input() Entity pc_in_class;
  //@Input()
  Map<String, CharClass> cMap = {};
  List<String> classStringList = [];
  // This will probably be used later in restructuring.
  //@Input() List<CharClass> classList;

  //@ViewChild('nameInput') ElementRef nameInput;

  ClassView(LoggerService this._log) { //, ClassService this.classService) {
    //classMap = classService.classMap;
    _log.info("$runtimeType()");
    //classList = classService.classList;
//    cMap.forEach((String name, CharClass charClass) {
//      if (charClass != null) {
//        classList.add(charClass);
//        classStringList.add(name);
//      }
//    });
  }



//  void select() {
//    pc_in_class.characterClass();
//  }

}