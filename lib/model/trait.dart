library model.trait;

class Trait {
  String _name;
  String _description;

  Trait();

  Trait.fromParam(this._name, this._description) {
//    _name = n;
//    _description = d;
  }

  String get name => _name;
  String get description => _description;
}