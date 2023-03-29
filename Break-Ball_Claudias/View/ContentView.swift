//
//  ContentView.swift
//  Break-Ball_Claudias
//
//  Created by Claudia Azorin Pla on 4/5/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var willMoveToNextScreen = false
    
    var body: some View {
        
        NavigationView{
            ZStack {
                    Color.yellow
                        .opacity(0.3)
                        .ignoresSafeArea()
                VStack{
                    Image("Icon")
                        .resizable()
                        .scaledToFit()
                    NavigationLink("Start",
                        destination: Game())
                        .buttonStyle(GrowingButton())
                }.navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)

            }
        }
    }   
}
                                
    
struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
