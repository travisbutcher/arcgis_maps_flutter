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
        let outline = AGSSimpleLineSymbol()
        
        guard let strokeWidth = symbolData["strokeWidth"] as? Int32,
              let _ = symbolData["strokeWidth"] as? Int32 else {
            return nil
        }
        outline.width = CGFloat(strokeWidth)
        
        guard let strokeColor = UIColor(data: symbolData["strokeColor"]),
              let _ = UIColor(data: symbolData["strokeColor"]) else {
            return nil
        }
        outline.color = strokeColor

        guard let fillColor = UIColor(data: symbolData["fillColor"]),
              let _ = UIColor(data: symbolData["fillColor"]) else {
            return nil
        }
        
        guard let strokeStyle = symbolData["strokeStyle"] as? Int32,
              let _ = symbolData["strokeStyle"] as? Int32 else {
            return nil
        }
        outline.style = getStrokeStyle(type: String(strokeStyle))
        
        symbol.color = fillColor
        symbol.outline = outline
        return symbol
    }
    
    private func getStrokeStyle(type: String) -> AGSSimpleLineSymbolStyle {
        switch(type){
        case "dash":
            return AGSSimpleLineSymbolStyle.dash
        default:
            return AGSSimpleLineSymbolStyle.null
        }
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

