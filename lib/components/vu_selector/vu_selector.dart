import 'dart:async';
import 'package:angular2/angular2.dart';

@Component(selector: 'vu-selector',
    template: '<ng-content></ng-content>',
    directives: const [VuSelectable]
)
class VuSelector implements AfterContentInit, OnDestroy {
  int _selectedIndex;
  Map<VuSelectable, StreamSubscription> clickListeners = {};

  @ContentChildren(VuSelectable) QueryList<VuSelectable> selectables;
  @Output() EventEmitter<int> selectedIndexChange = new EventEmitter<int>();

  ngAfterContentInit() {
    print("ngAfterContentInit: ${selectables.length}");

    _setUpClickListeners();

    // if the list of selectables changes, start over
    selectables.changes.listen((_) {
      _purgeClickListeners();
      _setUpClickListeners();
      selectedIndex = null;
    });
  }

  ngOnDestroy() {
    _purgeClickListeners();
  }

  void _setSelected(VuSelectable selection) {
    // set items' active status
    for (int i = 0; i < selectables.length; i++) {
      VuSelectable cur = selectables.elementAt(i);
      cur.active = cur == selection;
      if (cur.active) {
        _selectedIndex = i;
      }
    }

    // clear [selectedIndex] if nothing is selected
    if (selection == null) {
      _selectedIndex = null;
    }

    // fire change event
    selectedIndexChange.add(_selectedIndex);
  }

  void _setUpClickListeners() {
    if (selectables != null && selectables.isNotEmpty) {
      for (VuSelectable sel in selectables) {
        clickListeners[sel] = sel.click.listen(_setSelected);
      }
    }
  }

  void _purgeClickListeners() {
    for (StreamSubscription sub in clickListeners.values) {
      sub.cancel();
    }

    clickListeners = {};
  }

  int get selectedIndex => _selectedIndex;
  @Input() set selectedIndex(int value) {
    if (selectables == null) {
      return;
    }

    if (value == null) {
      _setSelected(null);
    }
    else if (value >= 0 && value < selectables.length && value != _selectedIndex) {
      _setSelected(selectables.elementAt(value));
    }
  }
}

@Directive(selector: "[vuSelectable]",
    host: const {"[class.active]": 'active'}
)
class VuSelectable {
  final ElementRef _ref;

  @Input() bool active = false;
  @Output() EventEmitter<VuSelectable> click = new EventEmitter<VuSelectable>();

  VuSelectable(ElementRef this._ref) {
    _ref.nativeElement.onClick.listen((_) {
      click.add(this);
    });
  }
}