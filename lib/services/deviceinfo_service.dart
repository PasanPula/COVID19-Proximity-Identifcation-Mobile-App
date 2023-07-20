import '/models/Device.Models/device_model.dart';
import 'package:device_info_plus/device_info_plus.dart';

//******************************* SERVICE USED TO GET DEVICE NAME AND ANDROID ID  USING DEVICE INFO PLUGIN *****************************

class DeviceInfoService {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

//return device data for registration
  Future<DeviceModel?> getDeviceInfo() async {
    try {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      if ((androidInfo.androidId != null) && (androidInfo.model != null)) {
        return DeviceModel(
            deviceName: androidInfo.model!,
            deviceId: androidInfo.androidId!,
            userId: 0);
      }
    } catch (e) {
      throw "Error: $e";
    }
  }
}
