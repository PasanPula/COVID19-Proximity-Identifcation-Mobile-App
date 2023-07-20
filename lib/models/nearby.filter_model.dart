//Data model used to send nearby devce filter parameters passing to backend

class NearbyFilterModel {
  late int _deviceId;
  // late double _distance;
  late String _date;
  late String _startTime;
  late String _endTime;

  NearbyFilterModel(
      {required int deviceId,
      // required double distance,
      required String date,
      required String startTime,
      required String endTime}) {
    this._deviceId = deviceId;
    // this._distance = distance;
    this._date = date;
    this._startTime = startTime;
    this._endTime = endTime;
  }

  int get deviceId => _deviceId;
  set deviceId(int deviceId) => _deviceId = deviceId;
  // double get distance => _distance;
  // set distance(double distance) => _distance = distance;
  String get date => _date;
  set date(String date) => _date = date;
  String get startTime => _startTime;
  set startTime(String startTime) => _startTime = startTime;
  String get endTime => _endTime;
  set endTime(String endTime) => _endTime = endTime;

  NearbyFilterModel.fromJson(Map<String, dynamic> json) {
    _deviceId = json['deviceId'];
    // _distance = json['distance'];
    _date = json['date'];
    _startTime = json['startTime'];
    _endTime = json['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deviceId'] = this._deviceId;
    // data['distance'] = this._distance;
    data['date'] = this._date;
    data['startTime'] = this._startTime;
    data['endTime'] = this._endTime;
    return data;
  }

  Map<String, dynamic> toQueryParams() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deviceId'] = _deviceId.toString();
    // data['distance'] = _distance.toString();
    data['date'] = _date.toString();
    data['startTime'] = _startTime.toString();
    data['endTime'] = _endTime.toString();
    return data;
  }
}
