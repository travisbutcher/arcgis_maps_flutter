import 'package:arcgis_maps_flutter/arcgis_maps_flutter.dart';
import 'package:arcgis_maps_flutter/src/utils/maps_object.dart';

/// Converts an [Iterable] of Points in a Map of PointId -> Point.
Map<PointId, Point> keyByPointId(Iterable<Point> points) {
  return keyByMapsObjectId<Point>(points).cast<PointId, Point>();
}

/// Converts a Set of Points into something serializable in JSON.
Object serializePointSet(Set<Point> points) {
  return serializeMapsObjectSet(points);
}