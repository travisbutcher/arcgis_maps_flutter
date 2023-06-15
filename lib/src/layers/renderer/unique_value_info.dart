part of arcgis_maps_flutter;


class UniqueValueInfo {
  const UniqueValueInfo({
    required this.value,
    required this.label,
    required this.description,
    required this.symbol,
  });

  final String value;
  final String label;
  final String description;
  final Symbol symbol;

    Object toJson() {
    return {
      'value': value,
      'label': label,
      'description': description,
      'symbol': symbol.toJson()
    };
  }
}