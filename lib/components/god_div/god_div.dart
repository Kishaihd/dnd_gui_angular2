import 'package:angular2/angular2.dart';
import 'package:ng_bootstrap/components/modal/modal.dart';
import 'package:ng_bootstrap/components/button/toggle.dart';
import '../../services/logger_service.dart';

import '../../model/deity.dart';
import '../../model/entity.dart';

@Component(selector: 'god-div',
    templateUrl: 'god_div.html',
    directives: const [BsModalComponent, BsToggleButtonDirective],
    providers: const []
)
class GodDiv {
  final LoggerService _log;


  @Input() Entity pc_in_deity;
  //@Input() String deity;
  @Input() Deity deity;

  ModalAction modalAction;

  GodDiv(LoggerService this._log) {
    _log.info("$runtimeType()");
  }

  onModalClose(ModalAction _modalAction) {
    modalAction = _modalAction;
  }

}