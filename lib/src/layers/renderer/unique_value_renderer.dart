part of arcgis_maps_flutter;

@immutable
class UniqueValueRenderer extends BaseRenderer {
  const UniqueValueRenderer(
      {required this.fields,
      required this.fieldDelimiter,
      required this.defaultSymbol,
      required this.defaultLabel,
      required this.uniqueValueInfos,
      required super.type});

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
