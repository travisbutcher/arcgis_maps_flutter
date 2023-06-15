part of arcgis_maps_flutter;

abstract class Renderer {
  const Renderer({
    required this.type,
  });

  final String type;

  Map<String, Object> toJson() {
    return {'type': type};
  }
}
