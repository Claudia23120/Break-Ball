//
//  ViewModel.swift
//  Break-Ball_Claudias
//
//  Created by Claudia Azorin Pla on 4/5/22.
//

import SwiftUI
import AudioToolbox
import AVFoundation

class ViewModel:ObservableObject{
    
    private var displaylink:CADisplayLink?
    
    @Published var player:Player?
    @Published var ball:Ball?
    @Published var bloques = [Bloque]()
    @Published var inArea = false
    @Published var gameOverVar = false
    @Published var score = 0
    @Published var text = ""

    @Published var level = 1
    private var borrar = [Int]()
    private var arraySoundButton : [String : SystemSoundID] = [:]

    init(){
        setUpSounds()
    }
    func restart (){
        inArea = false
        gameOverVar = false
        score = 0
        text = ""

        level = 1
        borrar = [Int]()
    }
    func playSoundButton(recurso : String){
        if let x = arraySoundButton[recurso]{
            AudioServicesPlaySystemSound(x)
        }else{
            print("no va")
        }
        
    }
    func createDisplayLink() {
        displaylink = CADisplayLink(target: self, selector: #selector(gameLoop))
        
        displaylink?.add(to: .current, forMode: RunLoop.Mode.default)
    }
    private func setUpSounds(){
        var soundID : SystemSoundID = 0
        if let soundURL:CFURL
                = Bundle.main.url(forResource: "bloque", withExtension: "mp3") as CFURL?{
                    AudioServicesCreateSystemSoundID(soundURL, &soundID)
            arraySoundButton["bloque"] = soundID
        }
        if let soundURL:CFURL
                = Bundle.main.url(forResource: "player", withExtension: "mp3") as CFURL?{
                    AudioServicesCreateSystemSoundID(soundURL, &soundID)
            arraySoundButton["player"] = soundID
        }
    }
    @objc private func gameLoop(displaylink: CADisplayLink) {
        objectWillChange.send()
        ball?.move()

        if ball!.checkScreenCollision(){
            ball?.changeDirection()
        }
        
        if (ball!.checkPlayerColision(player!.frame)){
            playSoundButton(recurso : "player")
            ball?.changeDirection()
        }
        if ball!.center.y >= UIScreen.main.bounds.maxY {
            gameOver()
        }
        inArea = ball!.checkPlayerColision(player!.frame)

        for (n,bloque) in bloques.enumerated(){
            if ball!.checkCollisionWith(bloque.frame){
                playSoundButton(recurso : "bloque")
                self.score += 1
                borrar.append(n)
                print(borrar)

                //bloques.remove(at: n)//???
                ball?.changeDirection()
            }
            
        }
        borrarBloques()
        if bloques.isEmpty && !gameOverVar{
            createObstacle2()
            level += 1
        }
    }
    private func borrarBloques(){
        
        if !borrar.isEmpty{
            let indexStart = borrar[borrar.startIndex]
            let indexEnd = borrar[borrar.endIndex-1]
            print(indexEnd)
            bloques.removeSubrange(indexStart...indexEnd)
            borrar.removeAll()
        }
    }
    
    func createPlayer(){
        self.player = Player(center: CGPoint(x:150,y:UIScreen.main.bounds.maxY-70), width: 60, height: 30)
    }
    
    func createBola(){
        self.ball = Ball(center: CGPoint(x:150,y:200), width: 25, height: 25)
        self.ball?.direction = Direction.allCases.randomElement()!
        
    }
    
    func createObstacle(){
        var x = UIScreen.main.bounds.minX + 35
        for _ in 1...5{
            let obstacle = Bloque(center: CGPoint(x:x,y:100), width: 60, height: 30)
            self.bloques.append(obstacle)
            x += 62
        }
        
        
    }
    
    func createObstacle2(){
        ball!.speed = 5
        if level == 1 {
            var y = UIScreen.main.bounds.minY + 35
            for _ in 1...3{
                var x = UIScreen.main.bounds.minX + 35
                for _ in 1...5{
                    let obstacle = Bloque(center: CGPoint(x:x,y:y), width: 60, height: 30)
                    self.bloques.append(obstacle)
                    x += 62
                }
                y += 32
            }
        }else{
            hasGuanyat()
        }
        
    }
    
    func movePlayerTo(_ point : CGFloat){
        objectWillChange.send()
        self.player?.moveToPoint(CGPoint(x: point, y: UIScreen.main.bounds.maxY-70))
    }
    
    func gameOver(){
        displaylink?.remove(from: .current, forMode: RunLoop.Mode.default)
        text = "GAME OVER"
        gameOverVar = true
        self.bloques.removeAll()

    }
    func hasGuanyat(){
        displaylink?.remove(from: .current, forMode: RunLoop.Mode.default)
        text = "HAS GUANYAT!!"
        gameOverVar = true
        self.bloques.removeAll()

    }
    
    
}
