
//
//  A ready-made, view based animation solution by John Sundell
//

import UIKit
import PlaygroundSupport

let canvasView = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
canvasView.backgroundColor = UIColor.white

PlaygroundPage.current.liveView = canvasView

struct Animation {
    var duration: TimeInterval
    var closure: (UIView) -> Void
}

extension Animation {
    static func fadeIn(duration: TimeInterval) -> Animation {
        return Animation(duration: duration, closure: { $0.alpha = 1 })
    }
    
    static func scale(to size: CGSize, duration: TimeInterval) -> Animation {
        return Animation(duration: duration, closure: { $0.frame.size = size })
    }
}

extension UIView {
    func animate(_ animations: [Animation]) {
        guard !animations.isEmpty else { return }
        
        var animations = animations
        let animation = animations.removeFirst()
        
        UIView.animate(withDuration: animation.duration, animations: {
            animation.closure(self)
        }) { _ in
            self.animate(animations)
        }
    }
}

let aButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
aButton.alpha = 0
aButton.backgroundColor = .red
aButton.center = canvasView.center
aButton.setTitle("Button", for: .normal)
canvasView.addSubview(aButton)

aButton.animate([
    .fadeIn(duration: 1),
    .scale(to: CGSize(width: 80, height: 80), duration: 1)
    ])
