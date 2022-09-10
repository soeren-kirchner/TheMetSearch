//
//  TheMetSearchApp.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 29.08.22.
//

import SwiftUI

@main
struct TheMetSearchApp: App {
    
    var api = API()
    
    var body: some Scene {
        WindowGroup {
            ContentView(api: api)
                .tint(.tint)
        }
    }
}
