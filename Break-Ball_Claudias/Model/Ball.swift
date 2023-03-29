//
//  Ball.swift
//  Break-Ball_Claudias
//
//  Created by Claudia Azorin Pla on 4/5/22.
//

import Foundation
import SwiftUI

class Ball: Sprite{
    var direction:Direction = Direction.rightUp
    var speed : CGFloat = 3
    var limiteInferior : CGFloat{
        return self.center.y + self.height / 2
    }
    
    private let minX = UIScreen.main.bounds.minX
    private let maxX = UIScreen.main.bounds.maxX
    private let minY = UIScreen.main.bounds.minY
    private let maxY = UIScreen.main.bounds.maxY
    
    func changeDirection(){
        switch self.direction {
        
            case .leftDown:
                if self.center.x <= minX{
                    self.direction = .rightDown
                }else{
                    self.direction = .leftUp
                }
            case .rightDown:
                if self.center.x >= maxX{
                    self.direction = .leftDown
                }else{
                    self.direction = .rightUp
                }
            case .leftUp:
                if self.center.x <= minX {
                    self.direction = .rightUp
//                } else if self.center.y <= minY {
//                    self.direction = .leftDown

                }else{
                    self.direction = .leftDown
                }
            case .rightUp:
                if self.center.x >= maxX {
                    self.direction = .leftUp
//                }else if self.center.y <= minY{
//                    self.direction = .rightDown
                }else{
                    self.direction = .rightDown
                }
        }
    }
    func move(){
        switch direction {
        
          
            case .leftDown:
                self.center.y += speed
                self.center.x -= speed

            case .rightDown:
                self.center.y += speed
                self.center.x += speed

            case .leftUp:
                self.center.y -= speed
                self.center.x -= speed

            case .rightUp:
                self.center.y -= speed
                self.center.x += speed

        }
    }
//    func colisionPlayer(){
//        if (self.direction == .down) {
//            self.direction = Direction.up
//        }
//    }
    
    func checkPlayerColision(_ frame : CGRect)->Bool{
        if self.center.x >= frame.origin.x && self.center.x <= frame.origin.x + frame.width{
            return self.limiteInferior >= frame.origin.y
        }
        return false
    }
    
}
enum Direction : CaseIterable{
    case leftDown, rightDown, leftUp, rightUp
}
