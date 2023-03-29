//
//  Break_Ball_ClaudiasApp.swift
//  Break-Ball_Claudias
//
//  Created by Claudia Azorin Pla on 4/5/22.
//

import SwiftUI

@main
struct Break_Ball_ClaudiasApp: App {
    @State var viewModel = ViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(viewModel)
        }
    }
}
