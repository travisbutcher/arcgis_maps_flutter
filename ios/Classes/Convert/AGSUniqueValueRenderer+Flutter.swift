import Foundation
import ArcGIS

extension AGSUniqueValueRenderer {
    convenience init(data: Dictionary<String, Any>) {
        self.init()
        self.fieldNames = data["fieldNames"] as! [String]
        
        if let defaultSymbolData = data["defaultSymbol"] as? [String: Any] {
            self.defaultSymbol = createSymbol(from: defaultSymbolData)
        } else {
            self.defaultSymbol = createDefaultSymbol(type: "Polygon")
        }
        
        if let defaultLabelData = data["defaultLabel"] as? String {
            self.defaultLabel = defaultLabelData
        } else {
            self.defaultLabel = "Unique"
        }
        
        if let uniqueValuesData = data["uniqueValues"] as? [[String: Any]] {
            for uniqueValueData in uniqueValuesData {
                if let description = uniqueValueData["description"] as? String,
                   let label = uniqueValueData["label"] as? String,
                   let symbolData = uniqueValueData["symbol"] as? [String: Any],
                   let values = uniqueValueData["values"] as? [Any] {
                    
                    let symbol = (createSymbol(from: symbolData) ?? defaultSymbol)!
                    let uniqueValue = AGSUniqueValue.init(description: description, label: label, symbol: symbol, values: values)
                    
                    // Add the created UniqueValue to the AGSUniqueValueRenderer
                    self.uniqueValues.append(uniqueValue)
                }
            }
        }
    }
    
    
    private func createSymbol(from symbolData: [String: Any]) -> AGSSymbol? {
        let symbol = AGSSimpleFillSymbol()
        symbol.outline = AGSLineSymbol()
        if let strokeWidth = symbolData["strokeWidth"] as? Double {
            symbol.outline?.width = strokeWidth
        } else {
            symbol.outline?.width = 1.0
        }

        guard let strokeColor = UIColor(data: symbolData["strokeColor"]),
              let _ = UIColor(data: symbolData["strokeColor"]) else {
            return nil
        }
        symbol.outline?.color = strokeColor

        guard let fillColor = UIColor(data: symbolData["fillColor"]),
              let _ = UIColor(data: symbolData["fillColor"]) else {
            return nil
        }
        
        symbol.color = fillColor
        return symbol
    }
    
    private func createDefaultSymbol(type: String) -> AGSSymbol? {
        switch(type){
        case "Polygon":
            let defaultPolySymbol = AGSSimpleFillSymbol()
            defaultPolySymbol.color = UIColor.green
            return defaultPolySymbol
        default:
            return nil
        }
    }
}

