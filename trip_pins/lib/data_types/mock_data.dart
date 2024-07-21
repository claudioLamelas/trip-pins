import 'package:latlong2/latlong.dart';
import 'package:trip_pins/data_types/pin.dart';

class MockData {
  static List<Pin> getPins() {
    return [
      Pin(
          pinLocation: const LatLng(38.81, -9.17),
          pinsData: getPinsData().sublist(0, 2)),
      Pin(
          pinLocation: const LatLng(38.81, -9.47),
          pinsData: getPinsData().sublist(2)),
    ];
  }

  static List<PinData> getPinsData() {
    return [
      const PinData(
          pinName: "test1",
          pinStartDate: "27-12-2003",
          pinEndDate: "03-05-2024",
          tripName: "Trip 1",
          photos: [],
          notes: []),
      const PinData(
          pinName: "test2",
          pinStartDate: "27-12-2003",
          pinEndDate: "03-05-2024",
          tripName: "Trip 2",
          photos: [],
          notes: []),
      const PinData(
          pinName: "test3",
          pinStartDate: "27-12-2003",
          pinEndDate: "03-05-2024",
          tripName: "Trip 3",
          photos: [],
          notes: [])
    ];
  }
}
