//
// Created by Valentin Grigorean on 08.11.2021.
//

import Foundation
import ArcGIS

extension AGSGeometry {
    static func fromFlutter(data: Dictionary<String, Any>) -> AGSGeometry? {
        let geometryType = AGSGeometryType(rawValue: data["geometryType"] as! Int)!
        switch (geometryType) {
        case .point:
            return AGSPoint(data: data)
        case .envelope:
            return AGSEnvelope(data: data)
        case .polyline, .polygon, .multipoint:
            do {
                let geometry = try AGSGeometry.fromJSON(data)
                return geometry as? AGSGeometry
            } catch let error {
                fatalError("\(error)")
            }
        case .unknown:
            fatalError("not impl")
        @unknown default:
            return nil
        }
    }

    func toJSONFlutter() -> Any {
        let json = try! toJSON()
        if var dict = json as? Dictionary<String, Any> {
            dict["geometryType"] = geometryType.rawValue
            return dict
        }
        return json
    }
}

