# VuSelector
Use this component to manage selection on a group of children automatically. Currently only supports single select.

## Setup

    import 'path/to/vu_selector.dart';

    directives: const [VuSelector, VuSelectable]
    
## Use

CSS classes taken from Bootstrap 4. Only children with the `vuSelectable` attribute will be eligible for selection.

    <vu-selector class="list-group" style="width: 50%;" [(selectedIndex)]="selected">
      <button *ngFor="let item of stuff" vuSelectable class="list-group-item list-group-item-action">
        <h5 class="list-group-item-heading">{{item['title']}}</h5>
        <p class="list-group-item-text">{{item['text']}}</p>
      </button>
    </vu-selector>

## Selection
The selected item will have the `active` class added to it. Selection occurs in response to items being clicked or setting the `selectedIndex` property of `<vu-selector>`. You can listen for selection changes with the `selectedIndexChange` event.