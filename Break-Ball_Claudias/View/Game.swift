//
//  Game.swift
//  Break-Ball_Claudias
//
//  Created by Claudia Azorin Pla on 11/5/22.
//

import SwiftUI

struct Game: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var gameOv = false
    var drag : some Gesture{
        DragGesture()
            .onChanged{value in
                viewModel.movePlayerTo(value.location.x)
            }
    }
    var body: some View {
        ZStack{
            
            ForEach(viewModel.bloques){obstacle in
                Rectangle()
                    .foregroundColor(.red)
                    .frame(width: obstacle.width, height: obstacle.height, alignment: .center)
                    .position(obstacle.center)
            }
            Circle()
                .fill(Color.red)
                .frame(width: viewModel.ball?.frame.width, height: viewModel.ball?.frame.height)
                .position(self.viewModel.ball?.center ?? CGPoint(x: 50, y: 50))
            Rectangle()
                .foregroundColor(.blue)
                .frame(width: viewModel.player?.frame.width, height: viewModel.player?.frame.height)
                .position(viewModel.player?.center ?? CGPoint(x: 50, y: 50))
                .gesture(drag)
            
            if(viewModel.gameOverVar){
                VStack{
                    Text("\(viewModel.text)")
                        .foregroundColor(Color.white)
                    Button(action: {
                        viewModel.restart()
                        viewModel.createPlayer()
                        viewModel.createBola()
                        viewModel.createObstacle()
                        viewModel.createDisplayLink()
                        

                    }, label: {Text("Restart")})
                    .buttonStyle(GrowingButton())
            
                }
                //NavigationLink(destination: ContentView, label: Text("Torna la menu"))
            }else{
                Text("Score: \(viewModel.score)")
                    .foregroundColor(Color.white)
            }
        }.background(Color.yellow)
        .onAppear(){
            viewModel.createPlayer()
            viewModel.createBola()
            viewModel.createObstacle()
            viewModel.createDisplayLink()
        }
    }
}

struct Game_Previews: PreviewProvider {
    static var previews: some View {
        Game()
    }
}
