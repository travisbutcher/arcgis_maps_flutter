part of arcgis_maps_flutter;

enum SymbolAngleAlignment {map, screen}

/// Uniquely identifies a [Point] among [ArcgisMapView] polygons.
///
/// This does not have to be globally unique, only unique among the list.
@immutable
class PointId extends SymbolId<Point> {
  /// Creates an immutable identifier for a [Point].
  const PointId(String value) : super(value);
}

// AGSSimpleMarkerSymbol

@immutable
class Point extends Symbol {
  const Point({
    required this.pointId,
    this.consumeTapEvents = false,
    this.color = Colors.black,
    this.visible = true,
    this.size = 10,
    this.style = SimpleMarkerSymbolStyle.circle,
    this.outline = const Polyline(polylineId: PolylineId("markerPolyline")),
    this.onTap,
    this.leaderOffsetX=0,
    this.leaderOffsetY=0,
    this.offsetX=0,
    this.offsetY=0,
    this.angle = 0,
    this.angleAlignment = SymbolAngleAlignment.map,
    this.type = "Point",
}) : super(symbolId: pointId);

  /// Uniquely identifies a [Point].
  final PointId pointId;

  /// True if the [Point] consumes tap events.
  ///
  /// If this is false, [onTap] callback will not be triggered.
  final bool consumeTapEvents;

  /// True if the marker is visible.
  final bool visible;

  /// Line segment color in ARGB format, the same format used by Color. The default value is black (0xff000000).
  final Color color;

  /// Style of the line
  final SimpleMarkerSymbolStyle style;

  /// Size of the marker symbol
  final int size;

  /// Outline of the point symbology
  final Polyline outline;

  /// Callbacks to receive tap events for polyline placed on this map.
  final VoidCallback ?onTap;

  /// Specifies how to position a callout's leader in relation to the symbol (for example, when a user taps on the map
  /// to display a callout for the feature or graphic). Default value is 0 and the callout's leader is positioned at 
  /// the horizontal center of the symbol. The values specified here are interpreted in a cartesian coordinate system 
  /// and in points (not pixels). Thus, a value of -5 will offset the callout's leader left on the x-axis by 5 points
  final double leaderOffsetX;

  /// Specifies how to position a callout's leader in relation to the symbol (for example, 
  /// when a user taps on the map to display a callout for the feature or graphic). Default value is 0 and 
  /// the callout's leader is positioned at the vertical center of the symbol. The values specified here are 
  /// interpreted in a cartesian coordinate system and in points (not pixels). Thus, a value of -5 will offset the 
  /// callout's leader down on the y-axis by 5 points
  final double leaderOffsetY;

  /// Specifies how to position the symbol in relation to the graphic or feature's point geometry. 
  /// This is useful when the marker needs to be offset to properly coincide with a location on the map.
  /// 
  /// Default value is 0 and the symbol is centered horizontally on the point geometry. The values specified are 
  /// interpreted in a cartesian coordinate system. Thus, a value of -5 will shift the marker left by 5 points on the 
  /// x-axis.
  final double offsetX;

  /// Specifies how to position the symbol in relation to the graphic or feature's point geometry. 
  /// This is useful when the marker needs to be offset to properly coincide with a location on the map.
  /// 
  /// Default value is 0 and the symbol is centered vertically on the point geometry. 
  /// The values specified are interpreted in a cartesian coordinate system. Thus, a value of -5 will shift 
  /// the marker down by 5 points on the y-axis.
  final double offsetY;

  /// The angle (in degrees) of the marker symbol
  final double angle;

  /// Specifies whether the symbol should rotate with the map/scene or stay at the same angle with regards to the screen. 
  /// Default is AGSSymbolAngleAlignmentScreen which keeps it aligned with the screen. Only supported for graphics overlays 
  /// when AGSGraphicsOverlay::renderingMode is AGSGraphicsRenderingModeDynamic, and for feature layers when 
  /// AGSFeatureLayer::renderingMode is AGSFeatureRenderingModeDynamic
  final SymbolAngleAlignment angleAlignment;

  /// Identifies the type of geometry type for this symbol
  final String type;

  Point copyWith({
    bool? consumeTapEventsParam,
    Color? colorParam,
    bool? visibleParam,
    int? sizeParam,
    SimpleMarkerSymbolStyle? styleParam,  
    Polyline? outlineParam, 
    VoidCallback? onTapParam,
    double? leaderOffsetXParam, 
    double? leaderOffsetYParam, 
    double? offsetXParam, 
    double? offsetYParam, 
    double? angleParam,
    SymbolAngleAlignment? angleAlignmentParam,
    String? typeParam,
  }) {
    return Point(
      pointId: pointId,
      consumeTapEvents: consumeTapEventsParam ?? consumeTapEvents,
      color: colorParam ?? color, 
      visible: visibleParam ?? visible, 
      size: sizeParam ?? size, 
      style: styleParam ?? style,
      outline: outlineParam ?? outline, 
      onTap: onTapParam ?? onTap,
      leaderOffsetX: leaderOffsetXParam ?? leaderOffsetX,
      leaderOffsetY: leaderOffsetYParam ?? leaderOffsetY,
      offsetX: offsetXParam ?? offsetX,
      offsetY: offsetYParam ?? offsetX,
      angle: angleParam ?? angle,
      angleAlignment: angleAlignmentParam ?? angleAlignment,
      type: typeParam ?? type,
    );
  }

  @override
  clone(){
    return copyWith();
  }

  @override
  Object toJson(){
    final Map<String, Object> json = <String, Object>{};

    void addIfPresent(String fieldName, Object? value) {
      if (value != null) {
        json[fieldName] = value;
      }
    }
    addIfPresent('pointId', pointId.value);
    addIfPresent('consumeTapEvents', consumeTapEvents);
    addIfPresent('color', color.value);
    addIfPresent('visible', visible);
    addIfPresent('size', size);
    addIfPresent('style', style.index);
    addIfPresent('outline', outline.clone());
    addIfPresent('onTap', onTap);
    addIfPresent('leaderOffsetX', leaderOffsetX);
    addIfPresent('leaderOffsetY', leaderOffsetY);
    addIfPresent('offsetX', offsetX);
    addIfPresent('offsetY', offsetY);
    addIfPresent('angle', angle);
    addIfPresent('angleAlignment', angleAlignment);
    addIfPresent('type', type);
    return json;
  }

  @override
  int get hashCode => pointId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Point && 
        runtimeType == other.runtimeType &&
        pointId == other.pointId &&
        consumeTapEvents == other.consumeTapEvents &&
        color == other.color &&
        visible == other.visible &&
        size == other.size &&
        style == other.style &&
        outline == other.outline &&
        onTap == other.onTap &&
        leaderOffsetX == other.leaderOffsetX &&
        leaderOffsetY == other.leaderOffsetY &&
        offsetX == other.offsetX &&
        offsetY == other.offsetY &&
        angle == other.angle &&
        angleAlignment == other.angleAlignment &&
        type == other.type;
}