class ExposedModel {
  late int _deviceId;
  String? _pCRDate;
  List<String>? _affectedDates;

  ExposedModel({required int deviceId, String? pCRDate, List<String>? affectedDates}) {
    _deviceId = deviceId;
    _pCRDate = pCRDate;
    _affectedDates = affectedDates;
  }

  int get deviceId => _deviceId;
  set deviceId(int deviceId) => _deviceId = deviceId;
  String? get pCRDate => _pCRDate;
  set pCRDate(String? pCRDate) => _pCRDate = pCRDate;
  List<String>? get affectedDates => _affectedDates;

  ExposedModel.fromJsonExpose(Map<String, dynamic> json) {
    _deviceId = json['id'];
    _pCRDate = json['pcrDateTime'];
  }

  ExposedModel.fromJsonStatus(Map<String, dynamic> json) {
    _deviceId = int.parse(json['deviceId']);
    _affectedDates = json['affectedDates'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deviceId'] = _deviceId;
    data['PCRDate'] = _pCRDate;
    return data;
  }
}