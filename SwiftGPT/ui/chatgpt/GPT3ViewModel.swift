import Foundation
import ChatGPTSwift

class GPT3ViewModel: ObservableObject {
    private let api: ChatGPTAPI
    @Published var messages: [Message] = []
    @Published var typingMessage: String = ""
    let bottomID = UUID()
    
    init(apiKey: String = Constants.API_KEY) {
        self.api = ChatGPTAPI(apiKey: apiKey)
    }
    
    func sendMessage() {
        guard !typingMessage.isEmpty else { return }
        let tempMessage = typingMessage
        typingMessage = ""
        Task {
            await getResponse(text: tempMessage)
        }
    }
    
    private func addMessage(_ content: Any, type: MessageType, isUserMessage: Bool) {
        DispatchQueue.main.async {
            guard let lastMessage = self.messages.last else {
                let message = Message(content: content, type: type, isUserMessage: isUserMessage)
                self.messages.append(message)
                return
            }
            
            let message = Message(content: content, type: type, isUserMessage: isUserMessage)
    
            if lastMessage.type == .indicator && !lastMessage.isUserMessage {
                self.messages[self.messages.count - 1] = message
            } else {
                self.messages.append(message)
            }
            
            if self.messages.count > 100 {
                self.messages.removeFirst()
            }
        }
    }
    
    func getResponse(text: String) async {
        
        self.addMessage(text, type: .text, isUserMessage: true)
        self.addMessage("", type: .text, isUserMessage: false)
        
        do {
            let stream = try await api.sendMessageStream(text: text)
            
            for try await line in stream {
                DispatchQueue.main.async {
                    
                    self.messages[self.messages.count - 1].content = self.messages[self.messages.count - 1].content as! String + line
                }
            }
        } catch {
            self.addMessage(error.localizedDescription, type: .error, isUserMessage: false)
        }
    }
}
