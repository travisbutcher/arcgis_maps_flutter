//
// Created by Shantanu Patil 09/28/2023
// 

import Foundation
import ArcGIS

class PointsController: NSObject, SymbolsController {
    private var pointIdToController = Dictionary<String, PointController>()

    private let graphicsOverlays: AGSGraphicsOverlay

    private let methodChannel: FlutterMethodChannel

    var selectionPropertiesHandler: SelectionPropertiesHandler?

    var symbolVisibilityFilterController: SymbolVisibilityFilterController?

    init(methodChannel: FlutterMethodChannel,
         graphicsOverlays: AGSGraphicsOverlay
    ) {
        self.methodChannel = methodChannel
        self.graphicsOverlays = graphicsOverlays
    }

    func addPoints(pointsToAdd: [Dictionary<String, Any>]) {
        for point in pointsToAdd {
            let pointId = point["pointId"] as! String
            let controller = PointController(pointId: pointId)
            pointIdToController[pointId] = controller
            updatePoint(data: point, controller: controller)
            controller.add(graphicsOverlay: graphicsOverlays)
        }
    }

    func changePoints(pointsToChange: [Dictionary<String, Any>]) {
        for point in pointsToChange {
            let pointId = point["pointId"] as! String
            guard let controller = pointIdToController[pointId] else {
                continue
            }
            updatePoint(data: point, controller: controller)
        }
    }

    func removePoints(pointIdsToRemove: [String]) {
        for pointId in pointIdsToRemove {
            guard let controller = pointIdToController[pointId] else {
                continue
            }
            symbolVisibilityFilterController?.removeGraphicsController(graphicController: controller)
            controller.remove(graphicsOverlay: graphicsOverlays)
            pointIdToController.removeValue(forKey: pointId)
        }
    }

    private func updatePoint(data: Dictionary<String, Any>,
                               controller: PointController) {

        updateController(controller: controller, data: data)

        if let color = UIColor(data: data["color"]) {
            controller.setFillColor(fillColor: fillColor)
        }

        if let size: Double = data["size"] as? Double {
            controller.setSize(size: CGFloat(size))
        }

        if let style = data["style"] as? Int {
            controller.setStyle(style: AGSSimpleMarkerSymbolStyle(rawValue: style)!)
        }

        // TODO Add support for other properties such as outline here
    }

}

extension PointsController: MapGraphicTouchDelegate {

    func canConsumeTaps() -> Bool {
        for (_, controller) in pointIdToController {
            if controller.consumeTapEvents {
                return true
            }
        }
        return false
    }

    func didHandleGraphic(graphic: AGSGraphic) -> Bool {
        guard let pointId = graphic.attributes["pointId"] as? String else {
            return false
        }
        if let currentPoint = pointIdToController[pointId] {
            guard currentPoint.consumeTapEvents else {
                return false
            }
            methodChannel.invokeMethod("point#onTap", arguments: ["pointId": pointId])
        }
        return true
    }
}