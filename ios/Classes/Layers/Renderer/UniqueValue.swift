import Foundation
import ArcGIS

class UniqueValue {
  let value: String
  let label: String
  let symbol: AGSSymbol

  init(value: String, label: String, symbol: AGSSymbol) {
    self.value = value
    self.label = label
    self.symbol = symbol
  }

  func toDictionary() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    dictionary["value"] = value
    dictionary["label"] = label
    dictionary["symbol"] = symbol.toJSON()
    return dictionary
  }

  static func fromDictionary(dictionary: [String: Any]) -> UniqueValue? {
    guard let value = dictionary["value"] as? String,
          let label = dictionary["label"] as? String,
          let symbolDict = dictionary["symbol"] as? [String: Any],
          let symbol = AGSSymbol.fromJSON(dictionary: symbolDict)
    else {
      return nil
    }
    return UniqueValue(value: value, label: label, symbol: symbol)
  }
}
