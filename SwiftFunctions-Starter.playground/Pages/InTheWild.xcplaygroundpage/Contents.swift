/*:
 [Home](Welcome) | [Previous](@previous) | [Next](@next)
 
 ## Closures In The Wild
 
 Let's take a look at some closures as they are typically used in the wild, but first
 we'll have to discuss **[scope](https://en.wikipedia.org/wiki/Scope_(computer_science))**.
 Scope is essentially an object's, or in our case a closures's realm of influence.
 What makes closures so interesting in Swift is that not only do they have their own
 influence within it's body, denoted by curly brackets, but they also have influential
 access to the environment that they're defined in.
 
 However it is important to note that accessing the outer invironment can sometimes wreak
 havoc if capture symantics are not properly understood.
 */
import Foundation
/*:
 ___
 ### Capturing Global Objects
 
 * Create a global var called `anInt` and assign it a number
 * Create a constant called `globalCapturer` of type `() -> Int`
 * Capture `anInt` and do something to it and return it.
 
*/
var anInt = 6

// Create globalCapturer, capture and incrament anInt, then return it.


// Call globalCapturer


/*:
 ___
 ### Capturing Nested Objects
 
 
 
 **Using Standard Functions**
 * Define a `func incrament() -> (Int) -> Int {...}`
 * Create a var called `aValue: Int` and assign it 0
 * Define a nested `func theIncramenter(aNumber: Int) -> Int {...}`
 * Capture `aValue` in `theIncramenter` and += `aNumber` to it.
 * Return `aValue` from the nested func and return `theIncramenter`
 */
// Create incrament() -> (Int) -> Int


// Assign a constant anIncramenter with the result from calling incrament()


// Call anIncramenter several times


/*:
 **Using Closure Syntax**
 * Now attempt to do the same as above using closure syntax
 * Name it `anotherIncramenter`
 * Afterwards, utilize immediate execution to un-nest.
 */
// Create a constant called anotherIncramenter that does the same thing, but as a closure


// Call anotherIncramenter several times


/*:
 ___
 ### Capturing Class Bound Objects
 
 Take a look at the `ExampleClass` and in particular the `printer` property.
 
 It's a simple closure that stores the integer passed to it in a captured `startNumber` and then prints the stored value. A seemingly innocouos property, however when you take a look at the loop that utilizes this class we can see that an unexpected behavior is occuring. Find and fix the error.
 */
// Fix the error

class ExampleClass {
    
    var startNumber = 0

    lazy var printer: ((Int) -> ()) = {
        self.startNumber = $0
        print(self.startNumber)
    }

    deinit {
        print("I'm going away now, bye")
    }
    
}

Array(0..<1_000).forEach {
    ExampleClass().printer($0)
}
/*:
 **Capture Symantics & Reference Types**
 
 * **strong** - The standard referencing mode
 * **weak** - Deactivates reference counting against the owner of the object where the this keyword is used. The property must be optional when used.
 * **unowned** - Does the same as weak, but allows you to treat the property as a non-optional type. Be careful with this...

 ___
 ### Escaping Closures
 
 Closures that are marked as `@escaping` are closures that are allowed to **escape** or live
 beyond the scope/influence of the functions that they are declared in. In other words they
 can be passed off along with the environment that they capture to other processes and be
 called at another time. These are often used as call back methods to bring back results of
 a long running process, such as network calls.
 */
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

// Create a getsCalledIn(seconds:_, _ aFunction:_) function


// Call getsCalledIn(seconds:_) {...}


/*:
 Notice that if the last parameter of a function is a closure, then a *trailing closure
 syntax* can be used. This is where the last parameter is ommited and the function is
 followed by an open and closed curly braces, where the body of the closure can be defined.
 Additionally if there's only one parameter and it happens to be a closure, you can ommit
 the paranthesis altogether.
 
    func doSomething(_ something: () -> Void) {
        something()
    }
 
    doSomething { print("I'm doing something!") }
*/

/*:
 ___
 ### Autoclosures
 
 Taking an excerpt from one of my favorite blog sites,
 [Swift by Sundell](https://www.swiftbysundell.com/posts/using-autoclosure-when-designing-swift-apis),
 an autoclosure *"enables you to define an argument that automatically gets wrapped
 in a closure. It’s primarily used to defer execution of a (potentially expensive) expression
 to when it’s actually needed, rather than doing it directly when the argument is passed."*
 Additionally you can use it to sprinkle a little syntactical sugar over your code.
 
 The following is an example from the blog. Let's say you have a disctionary of type `Any`
 and you'd like to extract and cast to the expected value. This is a common situation if you've
 used any of the UserDefaults or JSON parsing APIs.
 */

import UIKit

var userCache: [String: Any] = [:]

let myDentistsCell = 1_619_822_7729
let aColorToStore = UIColor(red: 0.1, green: 0.7, blue: 1.0, alpha: 1.0)
userCache["A pretty bluish color"] = aColorToStore
userCache["My teeth hurt"] = myDentistsCell
//: Traditionally we would have to do some casting and unwrapping to get out our value.
let myExtractedColor = userCache["A pretty bluish color"] as? UIColor

if let myColor = myExtractedColor {
    myColor //Now we can use the color safely
}
//: Now let's define a function with an autoclosure to reduce the verbosity 👍
// Create an extension on Dictionary, providing a method called value(forKey:_, defaultValue:_)


// Create a constant called myExtractedNumber where My teeth hurt is extracted and passed to it.


/*:
 ___
 [Home](Welcome) | [Previous](@previous) | [Next](@next)
 */
