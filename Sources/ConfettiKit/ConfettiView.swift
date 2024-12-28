import UIKit

/// Wraps an image and an optional color to use for this image
public struct ConfettiImage {
  public var image: UIImage
  public var color: UIColor?
  
  public init(image: UIImage, color: UIColor? = nil) {
    self.image = image
    self.color = color
  }
}

public final class ConfettiView: UIView {
  public var birthRate1: Float = 48
  public var birthRate2: Float = 20
  
  private var images: [ConfettiImage]
  private var shootings: [Shooting] = []
  
  public init(images: [ConfettiImage]) {
    self.images = images
    super.init(frame: .zero)
    clipsToBounds = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override public func layoutSubviews() {
    super.layoutSubviews()
    for shooting in shootings {
      shooting.view?.frame = bounds
    }
  }
  
  public func shoot(mode: ConfettiMode = .topToBottom, birthRate1: Float? = nil, birthRate2: Float? = nil, updatedImages: [ConfettiImage]? = nil) {
    let effectiveBirthRate1 = birthRate1 ?? self.birthRate1
    let effectiveBirthRate2 = birthRate2 ?? self.birthRate2
    let effectiveImages = updatedImages ?? images
    
    let view = ConfettiShotView(mode: mode,
                                images: effectiveImages,
                                birthRate1: effectiveBirthRate1,
                                birthRate2: effectiveBirthRate2)
    view.frame = bounds
    addSubview(view)
    let shooting = Shooting(view: view)
    shooting.delegate = self
    view.addAnimations()
    shooting.scheduleFinish()
  }
}

extension ConfettiView: ShootingDelegate {
  func shootingDidFinish(_ shooting: Shooting) {
    shooting.view?.removeFromSuperview()
    shootings.removeAll { $0 === shooting }
  }
}
