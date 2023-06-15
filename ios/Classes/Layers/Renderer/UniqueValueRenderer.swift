import Foundation
import ArcGIS

class UniqueValueRenderer: BaseRendererController{
let field: String
  let defaultSymbol: AGSSymbol
  let uniqueValues: [ArcGISUniqueValue]

  init(field: String, defaultSymbol: AGSSymbol, uniqueValues: [ArcGISUniqueValue]) {
    self.field = field
    self.defaultSymbol = defaultSymbol
    self.uniqueValues = uniqueValues
  }

  func toDictionary() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    dictionary["field"] = field
    dictionary["defaultSymbol"] = defaultSymbol.toJSON()
    dictionary["uniqueValues"] = uniqueValues.map { $0.toDictionary() }
    return dictionary
  }

  static func fromDictionary(dictionary: [String: Any]) -> ArcGISUniqueValueRenderer? {
    guard let field = dictionary["field"] as? String,
          let defaultSymbolDict = dictionary["defaultSymbol"] as? [String: Any],
          let defaultSymbol = AGSSymbol.fromJSON(dictionary: defaultSymbolDict),
          let uniqueValuesDict = dictionary["uniqueValues"] as? [[String: Any]]
    else {
      return nil
    }

    var uniqueValues: [ArcGISUniqueValue] = []
    for uniqueValueDict in uniqueValuesDict {
      if let uniqueValue = ArcGISUniqueValue.fromDictionary(dictionary: uniqueValueDict) {
        uniqueValues.append(uniqueValue)
      }
    }

    return ArcGISUniqueValueRenderer(field: field, defaultSymbol: defaultSymbol, uniqueValues: uniqueValues)
  }
}