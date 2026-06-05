class Conversation
{
  final int _id;
  final String _datum;
  final String _formMetaData;
  final String _assessment;
  final String _diagnosen;
  final String _ziele;
  final String _outcome;
  final String _notizen;
  final List<String> _selectedFilters;

  Conversation(this._id, this._datum,
               this._formMetaData, this._assessment, this._diagnosen,
               this._ziele, this._outcome, this._notizen, this._selectedFilters);

  int get id => this._id;
  String get datum => this._datum;
  String get formMetaData => this._formMetaData;
  String get assessment => this._assessment;
  String get diagnosen => this._diagnosen;
  String get ziele => this._ziele;
  String get outcome => this._outcome;
  String get notizen => this._notizen;
  List<String> get selectedFilters => this._selectedFilters;
}
