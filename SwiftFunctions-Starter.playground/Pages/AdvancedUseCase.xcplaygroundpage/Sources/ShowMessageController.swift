import Foundation
import UIKit

public class ShowMessageController: UIViewController {
    
    private var messageLabel: UILabel!
    private var button: UIButton!
    private let container = Partitions()
    
    /// The message to assign the message controller
    public var message: String = "This is a default message set upon starting"
    
    /// The text for the selection button
    public var selectionText: String = "Select"
    
    /// The action to run when the selection is pressed
    public var selectionAction: (() -> Void)?
    
    /// The delegate to assign for recieving messages
    public weak var delegate: ShowMessageDelegate?
    
    public override func loadView() {
        view = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 667))
        view.backgroundColor = UIColor.clear
        view.alpha = 0
        view.clipsToBounds = true
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        container.assignTo(view)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpMessage()
        setUpSelectionButton()
        reveal()
    }
    
    private func reveal() {
        UIView.animate(
            withDuration: 0.25,
            delay: 1.0,
            options: .curveEaseIn,
            animations: { [unowned self] in
                self.view.alpha = 1
            },
            completion: nil)
    }
    
    /// Removes the Show Message Controller from the parent
    public func remove() {
        UIView.animate(
            withDuration: 0.25,
            delay: 0,
            options: .curveEaseIn,
            animations: { [unowned self] in
                self.view.alpha = 0
            },
            completion: { [weak self] _ in
                self?.removeFromDisplay()
        })
        
        
    }
    
    private func setUpMessage() {
        messageLabel = UILabel()
        messageLabel.useAutoLayout()
        messageLabel.backgroundColor = UIColor.white.withAlphaComponent(0.25)
        messageLabel.clipsToBounds = true
        messageLabel.layer.cornerRadius = 15
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.layer.borderColor = UIColor.white.cgColor
        messageLabel.layer.borderWidth = 1.5
        messageLabel.text = message
        messageLabel.font = UIFont(name: "BradleyHandITCTT-Bold", size: 36)
        messageLabel.textColor = UIColor(red: 74/255, green: 94/255, blue: 108/255, alpha: 1)
        
        view.addSubview(messageLabel)
        
        activateConstraints(
            messageLabel.widthAnchor.constraint(equalToConstant: iPhone8.frame.width * 0.80),
            messageLabel.heightAnchor.constraint(equalToConstant: iPhone8.frame.height * 0.50),
            messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        )
        
    }
    
    private func setUpSelectionButton() {
        button = UIButton()
        button.useAutoLayout()
        button.backgroundColor = UIColor.white.withAlphaComponent(0.25)
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 2
        view.addSubview(button)
        
        let customFont = UIFont(name: "Noteworthy-Bold", size: 30) ?? UIFont.systemFont(ofSize: 24)
        let fontShadow = NSShadow()
        fontShadow.shadowColor = UIColor.black
        fontShadow.shadowBlurRadius = 2
        fontShadow.shadowOffset = CGSize(width: 1, height: 1)
        
        let attributedText = NSAttributedString(
            string: selectionText,
            attributes: [
                NSAttributedStringKey.font: customFont,
                NSAttributedStringKey.foregroundColor: UIColor.white,
                NSAttributedStringKey.shadow: fontShadow
            ])
        
        activateConstraints(
            button.leftAnchor.constraint(equalTo: messageLabel.leftAnchor, constant: 0),
            button.rightAnchor.constraint(equalTo: messageLabel.rightAnchor, constant: 0),
            button.heightAnchor.constraint(equalTo: messageLabel.heightAnchor, multiplier: 0.25),
            button.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20)
        )
        
        button.setAttributedTitle(attributedText, for: .normal)
        button.addTarget(self, action: #selector(selectionMade), for: .touchUpInside)
        button.showsTouchWhenHighlighted = true
    }
    
    @objc private func selectionMade() {
        selectionAction?()
        delegate?.selectionMade()
    }
    
    deinit {
        print("ShowMessageController has been deinitialized")
    }
    
}


public protocol ShowMessageDelegate: AnyObject {
    
    /// Gets called when the selection is made.
    func selectionMade()
    
}

