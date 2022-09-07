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
                VStack(spacing: 20) {
                    Text("Search The Met")
                    Text("\(Image(systemName: "wifi.exclamationmark"))")
                        .font(.largeTitle)
                    Text("No Connection")
                        .font(.title)
                    Text("Please check your internet connection.")
                }
            }
        }
        .task {
            networkMonitorManager.activate()
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
