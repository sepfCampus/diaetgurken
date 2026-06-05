import 'package:app/vo/assessment/assessment.dart';
import 'package:app/vo/diagnosis/diagnosis.dart';
import 'package:app/vo/form/form_meta_data.dart';
import 'package:app/vo/goal/goals.dart';
import 'package:app/vo/outcome/outcome.dart';

class Conversation
{
  final int _id;
  String _datum;
  FormMetaData _formMetaData;
  Assessment _assessment;
  Diagnosis _diagnosen;
  Goals _ziele;
  Outcome _outcome;
  String _notizen;
  List<String> _selectedFilters;

  Conversation(this._id, this._datum,
               this._formMetaData, this._assessment, this._diagnosen,
               this._ziele, this._outcome, this._notizen, this._selectedFilters);

  int get id => this._id;
  String get datum => this._datum;
  FormMetaData get formMetaData => this._formMetaData;
  Assessment get assessment => this._assessment;
  Diagnosis get diagnosen => this._diagnosen;
  Goals get ziele => this._ziele;
  Outcome get outcome => this._outcome;
  String get notizen => this._notizen;
  List<String> get selectedFilters => this._selectedFilters;

  set datum(String value) { this._datum = value; }
  set formMetaData(FormMetaData value) { this._formMetaData = value; }
  set assessment(Assessment value) { this._assessment = value; }
  set diagnosen(Diagnosis value) { this._diagnosen = value; }
  set ziele(Goals value) { this._ziele = value; }
  set outcome(Outcome value) { this._outcome = value; }
  set notizen(String value) { this._notizen = value; }
  set selectedFilters(List<String> value) { this._selectedFilters = selectedFilters; }
}
