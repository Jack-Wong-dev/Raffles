//
//  ContentView.swift
//  Raffles
//
//  Created by Jack Wong on 5/29/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = RafflesViewModel()
    
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                viewModel.getRaffles()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
