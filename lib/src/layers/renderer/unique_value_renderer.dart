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
    required this.fields,
    required this.fieldDelimiter,
    required this.defaultSymbol,
    required this.defaultLabel,
    required this.uniqueValueInfos,
    required String type,
  }) : super(type: type);

  final List<String> fields;
  final String fieldDelimiter;
  final Symbol defaultSymbol;
  final String defaultLabel;
  final List<UniqueValueInfo> uniqueValueInfos;

  @override
  Map<String, Object> toJson() {
    var json = super.toJson();
    json['fields'] = fields;
    json['fieldDelimiter'] = fieldDelimiter;
    json['defaultSymbol'] = defaultSymbol.toJson();
    json['defaultLabel'] = defaultLabel;
    json['uniqueValueInfos'] = uniqueValueInfos.map((e) => e.toJson()).toList();

    return json;
  }
}
