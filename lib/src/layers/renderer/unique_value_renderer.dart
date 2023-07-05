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

@immutable
class UniqueValueRenderer extends Renderer {
  const UniqueValueRenderer({
    required this.fieldNames,
    required this.uniqueValues,
    required String type,
  }) : super(type: type);

  final List<String> fieldNames;
  final List<UniqueValueInfo> uniqueValues;

  @override
  Map<String, Object> toJson() {
    var json = super.toJson();
    json['fieldNames'] = fieldNames;
    json['uniqueValues'] = uniqueValues.map((e) => e.toJson()).toList();

    return json;
  }
}
