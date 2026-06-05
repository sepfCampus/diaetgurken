abstract class ConversationEntity
{
  final int _id;
  final int _klientenAktenId;
  final String _datum;
  final Map<String, dynamic> _formMetaData;
  final Map<String, dynamic> _assessment;
  final Map<String, dynamic> _diagnosen;
  final Map<String, dynamic> _ziele;
  final Map<String, dynamic> _outcome;
  final String _notizen;
  final List<String> _selectedFilters;

  ConversationEntity(this._id, this._klientenAktenId, this._datum,
                     this._formMetaData, this._assessment, this._diagnosen,
                     this._ziele, this._outcome, this._notizen, this._selectedFilters);

  int get id => this._id;
  int get klientenAktenId => this._klientenAktenId;
  String get datum => this._datum;
  Map<String, dynamic> get formMetaData => this._formMetaData;
  Map<String, dynamic> get assessment => this._assessment;
  Map<String, dynamic> get diagnosen => this._diagnosen;
  Map<String, dynamic> get ziele => this._ziele;
  Map<String, dynamic> get outcome => this._outcome;
  String get notizen => this._notizen;
  List<String> get selectedFilters => this._selectedFilters;
}
