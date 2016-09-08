library model.deity;

class Deity {
  String _name;
  String _description;

  String _alignment;
  //List<String> _domains;
  String _domains;

  String imageUrl; // symbol?

  Deity();

  Deity.parameterized(this._name, this._alignment, this._description, this._domains, this.imageUrl);

  String get name => _name;
  String get description => _description;
  String get alignment => _alignment;
  //List<String> get domains => _domains;
  String get domains => _domains;
  String get image => imageUrl;

}