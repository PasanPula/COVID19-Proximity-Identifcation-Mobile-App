//All api endpoints
class Apis {
  //TODO - Update your base URL
  static const _baseUrl = '<Your Base URL>'

  static const usersignUpApi = _baseUrl + 'user/save';
  static const markAffectApi = _baseUrl + 'user/markAffected';
  static const deviceSignUpApi = _baseUrl + 'device/save';
  static const nearByDeviceApi = _baseUrl + 'device/getNearByDevices';
  static const saveLocationApi = _baseUrl + 'device/saveLocation';
  static const getLocationApi = _baseUrl + 'device/getLocationsById/';
  static const checkStatusApi = _baseUrl + 'device/getStatusById/';
  
}
