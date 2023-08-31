part of arcgis_maps_flutter;

class UniqueValueInfo {
  const UniqueValueInfo({
    required this.values,
    required this.label,
    required this.description,
    required this.symbol,
  });

  final List<dynamic> values;
  final String label;
  final String description;
  final Symbol symbol;

  Object toJson() {
    return {
      'values': values,
      'label': label,
      'description': description,
      'symbol': symbol.toJson()
    };
  }
}
