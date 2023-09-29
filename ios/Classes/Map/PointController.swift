//
// Created by Shantanu Patil on 09/28/2023
//

import Foundation
import ArcGIS

class PointController : BaseGraphicController {
    private let pointSymbol: AGSSimpleMarkerSymbol

    init(pointId: String) {
        pointSymbol = AGSSimpleMarkerSymbol(style: .cicrle, color: UIColor.black, width: 10)
        super.init(graphics: AGSGraphic(geometry: nil, symbol: pointSymbol, attributes: ["pointId": pointId]))
    }

    func setColor(color: UIColor) {
        pointSymbol.color = color
    }

    func setVisible(visible: Bool) {
        graphics.isVisible = visible
    }

    func setSize(size: CGFloat) {
        pointSymbol.size = size
    }

    func setStyle(style: AGSSimpleMarkerSymbolStyle) {
        pointSymbol.style = style
    }

    func setOutline(polyline: AGSSimpleLineSymbol) {
        graphics.outline = polyline
    }

    /// Not sure about the implementation of below functions
    /// Commenting out so they don't impede testing

    func setLeaderOffsetX(leaderOffsetX: CGFloat) {
        pointSymbol.leaderOffsetX = leaderOffsetX
    }

    func setLeaderOffsetY(leaderOffsetY: CGFloat) {
        pointSymbol.leaderOffsetY = leaderOffsetY
    }

    func setOffsetX(offsetX: CGFloat) {
        pointSymbol.offsetX = offsetX
    }

    func setOffsetY(offsetY: CGFloat) {
        pointSymbol.offsetY = offsetY
    }

    func setAngle(angle: Float) {
        pointSymbol.angle = angle
    }

    func setAngleAlignment(angleAlignment: AGSSymbolAngleAlignment) {
        pointSymbol.angleAlignment = angleAlignment
    }
}
