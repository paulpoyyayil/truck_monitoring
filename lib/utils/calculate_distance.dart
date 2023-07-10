import 'dart:math';

const double earthRadius = 6371.0; // Radius of the Earth in kilometers

double calculateDistance(double startLatitude, double startLongitude,
    double endLatitude, double endLongitude) {
  double lat1 = degreesToRadians(startLatitude);
  double lon1 = degreesToRadians(startLongitude);
  double lat2 = degreesToRadians(endLatitude);
  double lon2 = degreesToRadians(endLongitude);

  double dLat = lat2 - lat1;
  double dLon = lon2 - lon1;

  double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  double distance = earthRadius * c;
  return distance;
}

double degreesToRadians(double degrees) {
  return degrees * pi / 180.0;
}
