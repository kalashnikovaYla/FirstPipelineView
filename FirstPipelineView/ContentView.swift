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
            Spacer()
            Text(viewModel.data)
                .font(.title)
                .foregroundColor(.green)
            Text(viewModel.status)
                .foregroundColor(.blue)
            Spacer()
            
            Button("Cancel") {
                viewModel.cancel()
            }
            .foregroundColor(.pink)
            .opacity(viewModel.status == "Bank request" ? 1.0 : 0.0)
            
            Button("Re-request") {
                viewModel.refresh()
            }
        }
    }
}

class FirstPipelineViewModel: ObservableObject {
    
    @Published var data = ""
    @Published var status = ""
    
    private var cancellable: AnyCancellable?
    
    init() {
        cancellable = $data
            .map {[unowned self] value -> String in
                self.status = "Bank request"
                return value
            }
            .delay(for: 5, scheduler: DispatchQueue.main)
            .sink(receiveValue: { [unowned self] value in
                self.data = "The sum of all accounts is 1 000 000"
                self.status = "Data recived"
            })
    }
    
    func refresh() {
        status = "Re-request data"
    }
    func cancel() {
        status = "Operation cancelled"
        cancellable?.cancel()
        cancellable = nil
    }
}

 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
