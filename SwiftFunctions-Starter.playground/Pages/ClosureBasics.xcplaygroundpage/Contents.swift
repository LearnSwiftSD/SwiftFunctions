/*:
 [Home](Welcome) | [Previous](@previous) | [Next](@next)
 
 ## Closure Basics
 
 First off let's define what a closure actually is. The
 [Swift programming guide](https://docs.swift.org/swift-book/LanguageGuide/Closures.html)
 says that *"Closures are self-contained blocks of functionality that can be passed
 around and used in your code."* I wouldn't blame you if the words *deja vu* come to mind.
 Closures are basically anonymous functions that can be thought of like function-literals.
 Technically speaking [a closure is](https://en.wikipedia.org/wiki/Closure_(computer_programming))
 a function (named or not) that has the ability to capture its lexical environment and closes
 upon at least one object.
 
 The syntax is a bit different but the **func**-tionality 🤣 is the same. Let's take a look at
 some of the different ways we can define our anonymous function literal friends we refer to as
 the **closure**
 */
import Foundation
/*:
 ___
 ### Defining
 
 For example we'll define a normal function and take a look at the different ways we can
 redefine it as a closure.
 
 */
func exampleIntAdder(first: Int, second: Int) -> Int {
    let added = first + second
    return added
}
//: ___
//: Let's define our first closure as a variable and we'll annotate it with the type for now.
var intAdder: (Int, Int) -> Int
//: This closure will take two Integers and return one added Integer
// Make and assign a closure to intAdder


//: Now let's call them both and see what we get.
// Call intAdder and exampleIntAdder


/*:
 Notice with the closure we're unable to use the named arguments in the call.
 
 ___
 The cool thing about `intAdder` being a var is that we can reassign it to something else
 with the same type signature. Let's reassign with the same functionality but in a different
 way, with a little more type inference.
*/
// reassign intAdder without the type annotation


// Call intAdder and exampleIntAdder


/*:
 Notice the lack of type info in the definition, which is possible due to the compiler infering
 it from the initial declaration.
 
 ___
 Now let's try this inferrence thing out to the max using anonymous argument labels. The syntax
 for the labels are: `$0` for the first argument, `$1` for the second and so forth.
 */
// Reassign intAdder using anonymous parameters


// Call intAdder and exampleIntAdder


/*:
 ___
 Now to demonstrate that function literals and normal functions are the same we'll assign our
 `exampleIntAdder(_:, _:)` to the intAdder variable and see if it works.
 */
// Reassign intAdder with exampleIntAdder


// Call intAdder


/*:
 Notice that when assigning functions we don't use the parenthesis because we're not executing
 it, merely assigning it.
 
 ___
 
 [Home](Welcome) | [Previous](@previous) | [Next](@next)
 */
