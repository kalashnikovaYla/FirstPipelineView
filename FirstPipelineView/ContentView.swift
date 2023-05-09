//
//  ContentView.swift
//  FirstPipelineView
//
//  Created by sss on 09.05.2023.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @StateObject var viewModel = FirstPipelineViewModel()
    
    var body: some View {
        VStack {
            HStack{
                TextField("Your name", text: $viewModel.name)
                    .textFieldStyle(.roundedBorder)
                    
                Text(viewModel.validation)
            }
            .padding()
        }
    }
}

class FirstPipelineViewModel: ObservableObject {
    @Published var name = ""
    @Published var validation = ""
    
    init() {
        $name
            .map {$0.isEmpty ? "💔": "❤️‍🔥"}
            .assign(to: &$validation)
    }
}

 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
