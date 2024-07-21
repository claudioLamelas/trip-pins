import 'package:latlong2/latlong.dart';

class Pin {
  final LatLng pinLocation;
  final List<PinData> pinsData;

  const Pin({
    required this.pinLocation,
    required this.pinsData,
  });
}

class PinData {
  final String pinName;
  final String pinStartDate;
  final String pinEndDate;
  final String tripName;
  final List<String> photos;
  final List<String> notes;

  const PinData(
      {required this.pinName,
      required this.pinStartDate,
      required this.pinEndDate,
      required this.tripName,
      required this.photos,
      required this.notes});
}
