/*:
 [Home](Welcome) | [Previous](@previous) | [Next](@next)
 
 ## An Advanced Use Case
 
 Let's take a look at a more advanced use case for the lowly closure. Communication
 between objects is something that is typically done through a technique called
 delegation, which takes advantage of reference symantics and protocols. However
 if you've ever tried to do this with value types you'd end up coming dry. This is
 a perfect case for closure based delegation
 */
import UIKit
import PlaygroundSupport
/*:
 ___
 ### Communicating between value types
 */
enum MessageType: String {
    case greeting
    case goodbye
    case getTogether
    case angery
}

struct Message {
    let sender: String
    let recipient: String
    let type: MessageType
    let body: String
}

struct MessageLogger {
    
    var sentMessages = [Message]()
    
    mutating func logMessage(_ message: Message) {
        sentMessages.append(message)
    }
    
    func dumpMessages() {
        sentMessages.forEach { message in
            let form = """
            .........................
            Sender: \(message.sender)
            Recipient: \(message.recipient)
            Message Type: \(message.type.rawValue)
            Body: \(message.body)
            -------------------------
            """
            print(form)
        }
    }
}

struct Friend {
    
    var name: String
    
    var recievedMessage: Message? {
        didSet {
          print("Recieved message from \(recievedMessage?.sender ?? "None")")
        }
    }
    
    var messageSent: ((Message) -> Void)?
    
    init(name: String){
        self.name = name
    }
    
    func talkTo(friend: inout Friend, messageType: MessageType, body: String) {
        let message = Message(
            sender: name,
            recipient: friend.name,
            type: messageType,
            body: body)
        friend.recievedMessage = message
        messageSent?(message)
    }
    
}

var messageLog = MessageLogger()
var john = Friend(name: "John")

john.messageSent = { messageLog.logMessage($0) }

var andy = Friend(name: "Andy")

andy.messageSent = { messageLog.logMessage($0) }

john.talkTo(friend: &andy, messageType: .greeting, body: "hello")
andy.talkTo(friend: &john, messageType: .greeting, body: "Well hello to you!")
john.talkTo(friend: &andy, messageType: .goodbye, body: "Alrighty, maybe I'll see you next time?")
messageLog.dumpMessages()
/*:
 ___
 ### Communicating between reference types
 */
class MyController: MyExampleController {
    
    override func buttonTouched() {
        super.buttonTouched()
        print("The Button was touched")
        let message = ShowMessageController()
        message.message = "Hello every body. It's really nice to see you!!!"
        message.selectionText = "Go Back Now"
        message.selectionAction = messageAction(message)
        addToDisplay(message)
    }
    
    func messageAction(_ controller: ShowMessageController) -> () -> Void {
        return { [weak controller, weak self] in
            controller?.remove()
            self?.showOtherSide()
        }
    }
    
}

let myController = MyController()

PlaygroundPage.current.liveView = myController
/*:
 ___
 [Home](Welcome) | [Previous](@previous) | [Next](@next)
 */
