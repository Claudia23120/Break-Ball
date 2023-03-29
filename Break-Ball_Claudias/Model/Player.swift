//
//  Player.swift
//  Break-Ball_Claudias
//
//  Created by Claudia Azorin Pla on 4/5/22.
//

import Foundation
import SwiftUI


class Player: Sprite{
    
    func moveToPoint(_ point:CGPoint){
        withAnimation{
            self.center =  point
        }
    }
}
