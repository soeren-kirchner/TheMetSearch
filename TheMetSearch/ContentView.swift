//
//  ContentView.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 29.08.22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var networkMonitorManager = NetworkMonitorManager()
    let api: API
    
    var body: some View {
        ZStack {
            switch networkMonitorManager.connection {
            case .satisfied:
                SearchView(api: api)
            default:
                Text("No Connection")
            }
        }
        .task {
            networkMonitorManager.activate()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
