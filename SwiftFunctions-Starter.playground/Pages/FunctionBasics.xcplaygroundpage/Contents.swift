/*:
 [Home](Welcome) | [Previous](@previous) | [Next](@next)
 
 ## Function Basics
 
 According to the [official language
 guide](https://docs.swift.org/swift-book/LanguageGuide/Functions.html),
 *"Functions are self-contained chunks of code that perform a specific task."*
 In **Swift**, not only do these perform tasks for you, they also hold a special
 place in the language as first class citezens, meaning that they have their
 very own `Type` signature much like a `class` or `struct` would.
 
 Since functions are baked in as a `Type` in the language, this affords them all
 of the same privilages and power that other types have. For example functions
 can be stored as variables, passed as arguments, and be type aliased with the
 best of them.
 
 Let's take a look at some of ways we can define the basic function.
 */
import Foundation
/*:
 ___
 ### Defining
 1 - Define a function by using the `func` keyword.
 
 2 - Place the parameters (it's arguments) in the parentheses.
 
 3 - Place the work it'll do inside the body between the curly brackets.
 
*/
func myBasicFunction(firstArg: Int, secondArg: Int) -> Int {
    return firstArg + secondArg
}
/*:
 ___
 ### Calling
 To call the function you simply type it's name and enter the arguments.
 */
let myInt = myBasicFunction(firstArg: 1, secondArg: 2)
/*:
 ___
 ### Overloading
 You can provide different functionality to the same function name space.
*/
func myBasicFunction(firstArg: Double, secondArg: Double) -> Double {
    return firstArg + secondArg
}

let myDouble = myBasicFunction(firstArg: 2.275, secondArg: 7.725)
/*:
 ___
 ### Customize your parameters
 
 A function's parameters can:
 
 1 - Have it's labels removed.
 */
func printOnlyTheFirstIn(_ printableArray: [CustomStringConvertible]) {
    guard let firstItem = printableArray.first else { return }
    print(firstItem)
}

let words = ["Hello", "Hi", "Whaaatup", "Yo"]

printOnlyTheFirstIn(words)
//: 2 - Have seperate inside and outside labels.
func printOnlyTheLast(itemOf printableArray: [CustomStringConvertible]) {
    guard let lastItem = printableArray.last else { return }
    print(lastItem)
}

printOnlyTheLast(itemOf: words)
/*:
 These parameter customizations are provided to help improve clarity when
 the function is being called as well as when being defined. Unfortunately
 they can also be misused to make the function overly concise at the
 expense of clarity. Check out the [Swift API Design Guide](https://swift.org/documentation/api-design-guidelines/#fundamentals)
 for more info on Swift naming conventions.
 ___
 ### Default Parameters
 Providing a default value for a paramter can help with berevity when
 the given value is common for the function's usage.
 */
func showValue(printed shouldPrint: Bool = true, ofMember member: CustomStringConvertible) {
    if shouldPrint { print(member) }
}

struct ExampleType: CustomStringConvertible {
    let name: String
    var description: String {
        return "ExampleType: \(name)"
    }
}

showValue(ofMember: ExampleType(name: "The Blob"))
showValue(printed: false, ofMember: ExampleType(name: "The Ghost"))
/*:
 ___
 ### Variadic Parameters
 Sometimes you don't know how many of a parameter you'd like to enter
 in so one way is to type you're parameter whith an `Array<T>` or instead
 you can make it variadic.
 */
func printAll(items: CustomStringConvertible...) {
    for item in items {
        print(item)
    }
}

printAll(items: "Well", "how", "do", "you", "do?")
/*:
 ___
 ### Multiple return Types
 Your functions also have the ability to return multiple types through a `Tuple`
 */
func allMath(firstNum: Int, secondNum: Int) -> (added: Int, subtracted: Int, multiplied: Double, divided: Double) {
    let added = firstNum + secondNum
    let subtracted = firstNum - secondNum
    let multiplied = Double(firstNum) * Double(secondNum)
    let divided = Double(firstNum) / Double(secondNum)
    return (added, subtracted, multiplied, divided)
}

let myCalculation = allMath(firstNum: 8, secondNum: 6)

myCalculation.added
myCalculation.subtracted
myCalculation.multiplied
myCalculation.divided
/*:
 ___
 ### inout Parameters
 In some cases it's helpful to be able to change a parametric value that's being passed in.
 The `inout` keyword is how you accomplish this.
 */
var myNum: Int = 0

func add(_ num: Int, toOutsideNum outsideNum: inout Int) {
    outsideNum = outsideNum + num
}

add(6, toOutsideNum: &myNum)

print("myNum is now: \(myNum)")
/*:
 ___
 [Home](Welcome) | [Previous](@previous) | [Next](@next)
*/
