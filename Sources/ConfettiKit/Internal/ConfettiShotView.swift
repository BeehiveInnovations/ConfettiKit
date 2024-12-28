import UIKit

final class ConfettiShotView: UIView {
  private let backgroundLayerView: ConfettiLayerView
  private let foregroundLayerView: ConfettiLayerView
  
  // Add a defaultScale parameter to the initializer
  init(mode: ConfettiMode,
       images: [ConfettiImage],
       birthRate1: Float,
       birthRate2: Float,
       defaultScale: CGFloat = 1.0) {
    // Calculate scales based on defaultScale
    let backgroundScale = defaultScale * 0.75
    let foregroundScale = defaultScale * 1.25
    
    // Initialize the layer views with the calculated scales
    backgroundLayerView = ConfettiLayerView(mode: mode, images: images, birthRate: birthRate1, scale: backgroundScale, speed: 0.95)
    foregroundLayerView = ConfettiLayerView(mode: mode, images: images, birthRate: birthRate2, scale: foregroundScale, scaleRange: defaultScale * 0.1)
    backgroundLayerView.alpha = 0.5
    
    super.init(frame: .zero)
    addSubview(backgroundLayerView)
    addSubview(foregroundLayerView)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    backgroundLayerView.frame = bounds
    foregroundLayerView.frame = bounds
  }
  
  func addAnimations() {
    backgroundLayerView.addAnimations()
    foregroundLayerView.addAnimations()
  }
}
