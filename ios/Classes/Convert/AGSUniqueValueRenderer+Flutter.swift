import Foundation
import ArcGIS

extension AGSUniqueValueRenderer {
    convenience init(data: Dictionary<String, Any>) {
        let type = data["type"] as! String
        
        self.init()
    }

        func toJSONFlutter() -> Any {
        [
            "type": "AGSUniqueValueRenderer",
        ]
    }
}