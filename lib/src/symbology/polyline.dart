part of arcgis_maps_flutter;

enum SimpleLineSymbolStyle { dash, dashDot, dashDotDot, dot, none, solid, longDash, longDashDot, shortDash, shortDashDot, shortDashDotDot, shortDot }

/// Uniquely identifies a [Polyline] among [ArcgisMapView] polylines.
///
/// This does not have to be globally unique, only unique among the list.
@immutable
class PolylineId extends SymbolId<Polyline> {
  /// Creates an immutable object representing a [PolylineId] among [ArcgisMapView] polylines.
  ///
  /// An [AssertionError] will be thrown if [value] is null.
  const PolylineId(String value) : super(value);
}

@immutable
class Polyline extends Symbol {
  /// Creates an immutable object representing a line drawn through geographical locations on the map.
  const Polyline({
    required this.polylineId,
    this.consumeTapEvents = false,
    this.color = Colors.black,
    this.style = SimpleLineSymbolStyle.solid,
    this.points = const <AGSPoint>[],
    this.visible = true,
    this.width = 10,
    this.zIndex = 0,
    this.antialias = true,
    this.onTap,
    this.selectedColor,
    this.visibilityFilter,
    this.type = "Polyline",
  }) : super(symbolId: polylineId);

  /// Uniquely identifies a [Polyline].
  final PolylineId polylineId;

  /// True if the [Polyline] consumes tap events.
  ///
  /// If this is false, [onTap] callback will not be triggered.
  final bool consumeTapEvents;

  /// Line segment color in ARGB format, the same format used by Color. The default value is black (0xff000000).
  final Color color;

  /// Style of the line
  final SimpleLineSymbolStyle style;

  /// The vertices of the polygon to be drawn.
  final List<AGSPoint> points;

  /// True if the marker is visible.
  final bool visible;

  /// Width of the polyline, used to define the width of the line segment to be drawn.
  ///
  /// The width is constant and independent of the camera's zoom level.
  /// The default value is 10.
  final int width;

  /// The z-index of the polyline, used to determine relative drawing order of
  /// map overlays.
  ///
  /// Overlays are drawn in order of z-index, so that lower values means drawn
  /// earlier, and thus appearing to be closer to the surface of the Earth.
  final int zIndex;

  ///  Whether the line should be anti-aliased. Defaults to true.
  final bool antialias;

  /// Callbacks to receive tap events for polyline placed on this map.
  final VoidCallback? onTap;

  final Color? selectedColor;

  final SymbolVisibilityFilter? visibilityFilter;

  /// Identifies the type of geometry type for this symbol
  final String type;

  /// Creates a new [Polyline] object whose values are the same as this instance,
  /// unless overwritten by the specified parameters.
  Polyline copyWith({
    bool? consumeTapEventsParam,
    Color? colorParam,
    SimpleLineSymbolStyle? styleParam,
    List<AGSPoint>? pointsParam,
    bool? visibleParam,
    int? widthParam,
    int? zIndexParam,
    bool? antialiasParam,
    VoidCallback? onTapParam,
    Color? selectedColorParam,
    SymbolVisibilityFilter? visibilityFilterParam,
    String? typeParam,
  }) {
    return Polyline(
      polylineId: polylineId,
      color: colorParam ?? color,
      consumeTapEvents: consumeTapEventsParam ?? consumeTapEvents,
      style: styleParam ?? style,
      points: pointsParam ?? points,
      visible: visibleParam ?? visible,
      width: widthParam ?? width,
      zIndex: zIndexParam ?? zIndex,
      antialias: antialiasParam ?? antialias,
      onTap: onTapParam ?? onTap,
      selectedColor: selectedColorParam ?? selectedColor,
      visibilityFilter: visibilityFilterParam ?? visibilityFilter,
      type: typeParam ?? type,
    );
  }

  @override
  clone() {
    return copyWith(
      pointsParam: List<AGSPoint>.of(points),
    );
  }

  @override
  Object toJson() {
    final Map<String, Object> json = <String, Object>{};

    void addIfPresent(String fieldName, Object? value) {
      if (value != null) {
        json[fieldName] = value;
      }
    }

    addIfPresent('polylineId', polylineId.value);
    addIfPresent('consumeTapEvents', consumeTapEvents);
    addIfPresent('color', color.value);
    addIfPresent('style', style.index);
    json['points'] = _pointsToJson();
    addIfPresent('visible', visible);
    addIfPresent('width', width);
    addIfPresent('zIndex', zIndex);
    addIfPresent('antialias', antialias);
    addIfPresent('selectedColor', selectedColor?.value);
    addIfPresent('visibilityFilter', visibilityFilter?.toJson());
    addIfPresent("type", type);
    return json;
  }

  @override
  int get hashCode => polylineId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Polyline &&
          runtimeType == other.runtimeType &&
          polylineId == other.polylineId &&
          consumeTapEvents == other.consumeTapEvents &&
          color == other.color &&
          style == other.style &&
          points == other.points &&
          visible == other.visible &&
          width == other.width &&
          zIndex == other.zIndex &&
          antialias == other.antialias &&
          selectedColor == other.selectedColor &&
          visibilityFilter == other.visibilityFilter &&
          type == other.type;

  Object _pointsToJson() {
    final List<Object> result = <Object>[];
    for (final AGSPoint point in points) {
      result.add(point.toJson());
    }
    return result;
  }
}
