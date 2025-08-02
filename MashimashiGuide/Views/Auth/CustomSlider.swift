

import UIKit

class CustomSlider: UISlider {
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let tapPoint = touch.location(in: self)
        let fraction = Float(tapPoint.x / bounds.width)
        let newValue = (maximumValue - minimumValue) * fraction + minimumValue
        if newValue != value {
            value = newValue
            sendActions(for: .valueChanged)
        }
        return true
    }
    
}
