import 'package:geocoding/geocoding.dart' as geocoder;

//************************* GENARATED ADREES FROM GEO COORDINATES *************************

class GeocoderService {
  //consumed by location service
  Future<String> getAddressFromLatLng(double lat, double long) async {
    String _address = "No data";
    try {
      List<geocoder.Placemark> placemarks =
          await geocoder.placemarkFromCoordinates(lat, long);

      geocoder.Placemark place = placemarks[0];
      _address = _buildAdress(place);
    } catch (e) {
      throw Exception(e);
    }
    return _address;
  }

//create full address line removing empty values
  String _buildAdress(geocoder.Placemark place) {
    late String _address = "no data";
    final validCharacters = RegExp(r'^[a-zA-Z0-9\s]+$');
    if ((place.name != null) && (validCharacters.hasMatch(place.name!))) {
      if ((place.street != null) && (validCharacters.hasMatch(place.street!))) {
        _address =
            "${place.name},${place.street},${place.locality},${place.administrativeArea}";
      } else {
        _address =
            "${place.name},${place.locality},${place.administrativeArea}";
      }
    } else {
      _address = "${place.locality},${place.administrativeArea}";
    }
    return _address;
  }
}
