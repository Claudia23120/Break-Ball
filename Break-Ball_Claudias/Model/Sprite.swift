//
//  Sprite.swift
//  Break-Ball_Claudias
//
//  Created by Claudia Azorin Pla on 4/5/22.
//

import Foundation
import SwiftUI

class Sprite{
    
    var center:CGPoint
    var width:CGFloat
    var height:CGFloat
    
    var frame:CGRect{
        return CGRect(x: center.x-width/2,
                      y: center.y-height/2,
                      width: width,
                      height: height)
    }
    
    init(center:CGPoint, width:CGFloat, height: CGFloat){
        self.center = center
        self.width = width
        self.height = height
    }
    
    private let minX = UIScreen.main.bounds.minX
    private let maxX = UIScreen.main.bounds.maxX
    private let minY = UIScreen.main.bounds.minY
    private let maxY = UIScreen.main.bounds.maxY
    
    func checkScreenCollision()->Bool{
        return center.x >= maxX || center.x <= minX || center.y - 15 <= minY
    }
    
    func checkCollisionWith(_ frame:CGRect)->Bool{
        return self.frame.intersects(frame)
    }
    
}
