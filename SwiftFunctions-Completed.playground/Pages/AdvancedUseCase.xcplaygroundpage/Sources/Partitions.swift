import UIKit

/// Provides a set of partitions to build a layout from
class Partitions {
    let top: UILayoutGuide = UILayoutGuide()
    let bottom: UILayoutGuide = UILayoutGuide()
    let firstQuad: UILayoutGuide = UILayoutGuide()
    let secondQuad: UILayoutGuide = UILayoutGuide()
    let thirdQuad: UILayoutGuide = UILayoutGuide()
    let fourthQuad: UILayoutGuide = UILayoutGuide()
    
    func assignTo(_ view: UIView) {
        [top, bottom, firstQuad, secondQuad, thirdQuad, fourthQuad]
            .forEach { view.addLayoutGuide($0) }
        
        NSLayoutConstraint.activate([
            top.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            top.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            top.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            top.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            
            bottom.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            bottom.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            bottom.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            bottom.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
            firstQuad.heightAnchor.constraint(equalTo: top.heightAnchor, multiplier: 0.5),
            firstQuad.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            firstQuad.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            firstQuad.topAnchor.constraint(equalTo: top.topAnchor, constant: 0),
            
            secondQuad.heightAnchor.constraint(equalTo: top.heightAnchor, multiplier: 0.5),
            secondQuad.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            secondQuad.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            secondQuad.bottomAnchor.constraint(equalTo: top.bottomAnchor, constant: 0),
            
            thirdQuad.heightAnchor.constraint(equalTo: bottom.heightAnchor, multiplier: 0.5),
            thirdQuad.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            thirdQuad.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            thirdQuad.topAnchor.constraint(equalTo: bottom.topAnchor, constant: 0),
            
            fourthQuad.heightAnchor.constraint(equalTo: bottom.heightAnchor, multiplier: 0.5),
            fourthQuad.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            fourthQuad.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            fourthQuad.bottomAnchor.constraint(equalTo: bottom.bottomAnchor, constant: 0)
            ])
    }
    
}
