//
//  ContentView.swift
//  ChatAI2
//
//  Created by Isaac Palmer on 12/13/22.
//

import OpenAISwift
import SwiftUI

final class ViewModel: ObservableObject {
    init() {}
    
    private var client: OpenAISwift?
    
    func setup() {
        client = OpenAISwift(authToken: "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")
    }
    
    func send(text: String, completion: @escaping (String) -> Void) {
        client?.sendCompletion(with: text, maxTokens: 500, completionHandler: { result in
            switch result {
            case .success(let model):
                let output = model.choices.first?.text ?? ""
                completion(output)
            case.failure:
                break
            }
        })
    }
}

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    @State var text = ""
    @State var models = [String]()
    
    var body: some View {
        ScrollView{VStack(alignment: .leading)
            {
                ForEach(models, id: \.self) { string in Text(string)}
            }
            
            Spacer()
            
        }
        HStack {
            TextField("Type here...", text: $text)
            Button("Send") {
                send()
            }
        }
        
        .onAppear {
            viewModel.setup()
        }
        .padding()
    }
        

func send() {
    guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
        return
    }
    models.append("Me: \(text)")
    viewModel.send(text: text) { response in
        DispatchQueue.main.async {
            self.models.append("\nChatGPT: " + response + "\n")
            self.text = ""
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}