import UIKit

extension UIView {
    
    /// Allows a view to use auto layour
    func useAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

extension UIViewController {
    
    /// Allows a ViewController to add and display a child ViewController
    public func addToDisplay(_ child: UIViewController) {
        addChildViewController(child)
        view.addSubview(child.view)
        child.didMove(toParentViewController: self)
    }
    
    /// Called on the child, this removes it from its parent ViewController
    func removeFromDisplay() {
        guard parent != nil else { return }
        willMove(toParentViewController: nil)
        removeFromParentViewController()
        view.removeFromSuperview()
    }
    
    /// Activates the constraints passed in.
    func activateConstraints(_ constraints: NSLayoutConstraint...) {
        NSLayoutConstraint.activate(constraints)
    }
    
}

internal let iPhone8 = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 667))
