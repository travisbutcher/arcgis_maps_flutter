import 'package:arcgis_maps_flutter/arcgis_maps_flutter.dart';
import 'package:arcgis_maps_flutter/src/maps_object_updates.dart';

/// [Point] update events to be applied to the [ArcgisMapView]
/// 
/// (Do not re-export)
class PointUpdates extends MapsObjectUpdates<Point> {
  /// Computes [PointUpdates] given previous and current [Point]s.
  PointUpdates.from(Set<Point> previous, Set<Point> current)
      : super.from(previous, current, objectName: 'point');
}