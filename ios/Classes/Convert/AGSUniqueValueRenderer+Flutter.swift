import Foundation
import ArcGIS

extension AGSUniqueValueRenderer {
    convenience init(data: Dictionary<String, Any>) {
        self.init()
        self.fieldNames = data["fieldNames"] as! [String]
//        No longer doing default symbol if
//        if let defaultSymbolData = data["defaultSymbol"] as? [String: Any], let symbolType = data["type"] as? String{
//            self.defaultSymbol = createSymbol(from: defaultSymbolData, type: symbolType)
//        } else {
//            return
//        }
//
//        if let defaultLabelData = data["defaultLabel"] as? String {
//            self.defaultLabel = defaultLabelData
//        } else {
//            self.defaultLabel = "Unique"
//        }
        
        if let uniqueValuesData = data["uniqueValues"] as? [[String: Any]] {
            for uniqueValueData in uniqueValuesData {
                if let description = uniqueValueData["description"] as? String,
                   let label = uniqueValueData["label"] as? String,
                   let symbolData = uniqueValueData["symbol"] as? [String: Any],
                   let values = uniqueValueData["values"] as? [Any] {
                    
                    let symbolType = symbolData["type"] as? String
                    guard let symbol = createSymbol(from: symbolData, type: symbolType!) else { return }
//                    let symbol = (createSymbol(from: symbolData, type: symbolType) ?? defaultSymbol)!
                    let uniqueValue = AGSUniqueValue.init(description: description, label: label, symbol: symbol, values: values)
                    
                    // Add the created UniqueValue to the AGSUniqueValueRenderer
                    self.uniqueValues.append(uniqueValue)
                }
            }
        }
    }
    
    
    private func createSymbol(from symbolData: [String: Any], type: String) -> AGSSymbol? {
        switch(type){
        case "Polygon":
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
            outline.style = getStrokeStyle(type: strokeStyle)
            
            symbol.color = fillColor
            symbol.outline = outline
            return symbol
        case "Polyline":
            let symbol = AGSSimpleLineSymbol()
            guard let strokeWidth = symbolData["width"] as? Int32,
                  let _ = symbolData["width"] as? Int32 else {
                return nil
            }
            symbol.width = CGFloat(strokeWidth)
            
            guard let strokeColor = UIColor(data: symbolData["color"]),
                  let _ = UIColor(data: symbolData["color"]) else {
                return nil
            }
            guard let strokeStyle = symbolData["style"] as? Int32,
                  let _ = symbolData["style"] as? Int32 else {
                return nil
            }
            symbol.style = getStrokeStyle(type: strokeStyle)
            symbol.color = strokeColor
            return symbol
        case "Point":
            let symbol = AGSSimpleMarkerSymbol()
            
            guard let symbolStyle = symbolData["style"] as? Int32,
                  let _ = symbolData["style"] as? Int32 else {
                return nil
            }
            symbol.style = getSymbolStyle(type: symbolStyle)
            
            guard let strokeColor = UIColor(data: symbolData["color"]),
                  let _ = UIColor(data: symbolData["color"]) else {
                return nil
            }
            
            guard let strokeSize = symbolData["size"] as? Int32,
                  let _ = symbolData["size"] as? Int32 else {
                return nil
            }
            symbol.size = CGFloat(strokeSize)
            symbol.color = strokeColor
            return symbol
        default:
            return nil
        }
        
    }
    
    private func getStrokeStyle(type: Int32) -> AGSSimpleLineSymbolStyle {
        switch(type){
        case 0:
            return AGSSimpleLineSymbolStyle.dash
        case 1:
            return AGSSimpleLineSymbolStyle.dashDot
        case 2:
            return AGSSimpleLineSymbolStyle.dashDotDot
        case 3:
            return AGSSimpleLineSymbolStyle.dot
        case 4:
            return AGSSimpleLineSymbolStyle.solid
        case 5:
            return AGSSimpleLineSymbolStyle.longDash
        case 6:
            return AGSSimpleLineSymbolStyle.longDashDot
        case 7:
            return AGSSimpleLineSymbolStyle.shortDash
        case 8:
            return AGSSimpleLineSymbolStyle.shortDashDot
        case 9:
            return AGSSimpleLineSymbolStyle.shortDashDotDot
        case 10:
            return AGSSimpleLineSymbolStyle.shortDot
        default:
            return AGSSimpleLineSymbolStyle.null
        }
    }
    
    private func getSymbolStyle(type: Int32) -> AGSSimpleMarkerSymbolStyle {
        switch(type){
        case 0:
            return AGSSimpleMarkerSymbolStyle.circle
        case 1:
            return AGSSimpleMarkerSymbolStyle.cross
        case 2:
            return AGSSimpleMarkerSymbolStyle.diamond
        case 3:
            return AGSSimpleMarkerSymbolStyle.square
        case 4:
            return AGSSimpleMarkerSymbolStyle.triangle
        case 5:
            return AGSSimpleMarkerSymbolStyle.X
        default:
            return AGSSimpleMarkerSymbolStyle.circle
        }
    }
    
}

