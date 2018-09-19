import UIKit
import PlaygroundSupport
import UIKit

/// The Example Controller for demonstration purposes
open class MyExampleController: UIViewController {
    
    private var bigButton: UIButton!
    private let container = Partitions()
    private var slidingImageView: UIImageView!
    private var slidingViewStartPosition: CGFloat!
    private var slidingViewLeftAnchor: NSLayoutConstraint!
    private var blurOverlay: UIVisualEffectView!
    private var blurEffect: UIBlurEffect!
    private var logoImageView: UIImageView!
    private var underline: UIView!
    private var isPageTurned: Bool = false
    
    private var screenHeight: CGFloat {
        return iPhone8.frame.height
    }
    
    open override func loadView() {
        view = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 667))
        view.backgroundColor = UIColor.white
        view.clipsToBounds = true
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        runAllSetup()
    }
    
    /// The method that gets called when the button is touched
    @objc open func buttonTouched() {
        showOtherSide()
    }
    
    /// Reveals the other side of the controller
    public func showOtherSide(_ completionHandler: (() -> Void)? = nil) {
        let isOnFirstPage = !isPageTurned
        slidingViewLeftAnchor.constant = isOnFirstPage ? 0 : slidingViewStartPosition
        view.setNeedsLayout()
        
        UIView.animate(
            withDuration: 0.75,
            delay: 0,
            options: .curveEaseIn,
            animations: { [unowned self] in
                if isOnFirstPage {
                    self.bigButton.transform = CGAffineTransform(translationX: 0, y: self.screenHeight * 0.3)
                    self.bigButton.alpha = 0
                } else {
                    self.bigButton.transform = CGAffineTransform.identity
                    self.bigButton.alpha = 1
                }
            },
            completion: nil)
        
        UIView.animate(
            withDuration: 1.5,
            delay: 0,
            options: .curveEaseOut,
            animations: { [unowned self] in
                if isOnFirstPage {
                    self.blurOverlay.effect = nil
                } else {
                    self.blurOverlay.effect = self.blurEffect
                }
                self.view.layoutIfNeeded()
            } ,
            completion: { _ in completionHandler?() })
        
        isPageTurned = isOnFirstPage
    }
}

// SetUp Methods
extension MyExampleController {
    
    private func runAllSetup() {
        container.assignTo(view)
        setUpSlidingBackground()
        setUpBlurOverlay()
        setUpLogo()
        setUpButtons()
    }
    
    private func setUpSlidingBackground() {
        let image = UIImage(named: "SeaSideImage")
        slidingImageView = UIImageView(image: image)
        slidingImageView.contentMode = .scaleToFill
        view.addSubview(slidingImageView)
        slidingImageView.useAutoLayout()
        slidingViewStartPosition = -(iPhone8.frame.width)
        slidingViewLeftAnchor = slidingImageView
            .leadingAnchor
            .constraint(
                equalTo: view.leadingAnchor,
                constant: slidingViewStartPosition
        )
        
        activateConstraints(
            slidingImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2),
            slidingImageView.heightAnchor.constraint(equalTo: view.heightAnchor),
            slidingImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            slidingViewLeftAnchor
        )
    }
    
    private func setUpBlurOverlay() {
        blurEffect = UIBlurEffect(style: .regular)
        blurOverlay = UIVisualEffectView(effect: blurEffect)
        blurOverlay.useAutoLayout()
        view.addSubview(blurOverlay)
        
        activateConstraints(
            blurOverlay.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            blurOverlay.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            blurOverlay.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            blurOverlay.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        )
    }
    
    private func setUpButtons() {
        let button = UIButton()
        button.useAutoLayout()
        button.clipsToBounds = false
        
        let label = UILabel()
        label.useAutoLayout()
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        
        let topLine = UIView()
        let bottomLine = UIView()
        
        topLine.useAutoLayout()
        bottomLine.useAutoLayout()
        
        button.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        topLine.backgroundColor = UIColor.white
        bottomLine.backgroundColor = UIColor.white
        
        
        view.addSubview(button)
        button.addSubview(label)
        button.addSubview(topLine)
        button.addSubview(bottomLine)
        
        activateConstraints(
            button.heightAnchor.constraint(equalTo: container.firstQuad.heightAnchor, multiplier: 1.0),
            button.widthAnchor.constraint(equalTo: container.firstQuad.widthAnchor, multiplier: 0.95),
            button.centerXAnchor.constraint(equalTo: container.bottom.centerXAnchor, constant: 0),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30),
            
            label.centerYAnchor.constraint(equalTo: button.centerYAnchor, constant: 10),
            label.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            label.widthAnchor.constraint(equalTo: view.widthAnchor),
            label.heightAnchor.constraint(equalTo: button.heightAnchor),
            
            topLine.heightAnchor.constraint(equalToConstant: 1.5),
            topLine.leftAnchor.constraint(equalTo: label.leftAnchor, constant: 20),
            topLine.rightAnchor.constraint(equalTo: label.rightAnchor, constant: -20),
            topLine.bottomAnchor.constraint(equalTo: label.topAnchor, constant: 40),
            
            bottomLine.heightAnchor.constraint(equalTo: topLine.heightAnchor, constant: 0),
            bottomLine.leftAnchor.constraint(equalTo: label.leftAnchor, constant: 20),
            bottomLine.rightAnchor.constraint(equalTo: label.rightAnchor, constant: -20),
            bottomLine.topAnchor.constraint(equalTo: label.bottomAnchor, constant: -40)
        )
        
        let customFont = UIFont(name: "BradleyHandITCTT-Bold", size: 36) ?? UIFont.systemFont(ofSize: 24)
        let fontShadow = NSShadow()
        fontShadow.shadowColor = UIColor.black
        fontShadow.shadowBlurRadius = 2
        fontShadow.shadowOffset = CGSize(width: 1, height: 1)
        
        let attributedText = NSAttributedString(
            string: "Press Me",
            attributes: [
                NSAttributedStringKey.font: customFont,
                NSAttributedStringKey.foregroundColor: UIColor.white,
                NSAttributedStringKey.shadow: fontShadow
            ])
        
        label.attributedText = attributedText
        button.addTarget(self, action: #selector(buttonTouched) , for: .touchUpInside)
        button.layer.cornerRadius = (iPhone8.frame.height * 0.25) * 0.5
        bigButton = button
    }
    
    private func setUpLogo() {
        let image = UIImage(named: "LearnSwiftLogo")
        logoImageView = UIImageView(image: image)
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.clipsToBounds = false
        logoImageView.useAutoLayout()
        
        underline = UIView()
        underline.useAutoLayout()
        
        underline.backgroundColor = UIColor.white
        underline.alpha = 1
        underline.layer.shadowOffset = CGSize(width: 4, height: -0.5)
        underline.layer.shadowColor = UIColor.black.cgColor
        underline.layer.shadowOpacity = 0.75
        underline.layer.shadowRadius = 2
        
        view.addSubview(logoImageView)
        logoImageView.addSubview(underline)
        
        activateConstraints(
            logoImageView.heightAnchor.constraint(equalTo: container.firstQuad.heightAnchor, multiplier: 0.35),
            logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor, multiplier: 5.87719298),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            logoImageView.centerYAnchor.constraint(equalTo: container.firstQuad.centerYAnchor, constant: 0),
            
            underline.leftAnchor.constraint(equalTo: logoImageView.leftAnchor, constant: 20),
            underline.rightAnchor.constraint(equalTo: logoImageView.rightAnchor, constant: -20),
            underline.heightAnchor.constraint(equalToConstant: 1.5),
            underline.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 10)
        )
    }
    
}
