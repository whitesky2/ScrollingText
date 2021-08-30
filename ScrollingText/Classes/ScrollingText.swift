import UIKit

@IBDesignable
public class ScrollingText: UIView {
    @IBInspectable public var text: String = ""
    @IBInspectable public var isLeft: Bool = false
    
    private var timer: Timer?
    private var pos: CGPoint = CGPoint.zero
    private var textWidth: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    private func setup() {
        self.pos = CGPoint(x: 0, y: self.bounds.height / 2.0)
    }
    
    public override func draw(_ rect: CGRect) {
        (self.text as NSString).draw(at: self.pos, withAttributes: nil)
    }
    
    public func startMove() {
        let label = UILabel()
        label.text = self.text
        label.sizeToFit()
        
        textWidth = label.bounds.width
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(moveText), userInfo: nil, repeats: true)
    }
    
    public func stopMove() {
        self.timer?.invalidate()
        self.timer = nil
        
        self.setup()
        self.setNeedsDisplay()
    }
    
    @objc private func moveText() {
        if self.isLeft {
            self.pos.x -= 3
            
            if self.pos.x < -self.textWidth {
                self.pos.x = self.bounds.width
            }
        } else {
            self.pos.x += 3
            
            if self.pos.x > self.bounds.width {
                print(-self.textWidth)
                self.pos.x = -self.textWidth
            }
        }
        
        self.setNeedsDisplay()
    }
}
