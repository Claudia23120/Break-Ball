//
//  Bloque.swift
//  Break-Ball_Claudias
//
//  Created by Claudia Azorin Pla on 9/5/22.
//

import Foundation
import SwiftUI

class Bloque:Sprite, Identifiable{
    let id = UUID()
    
    override init(center:CGPoint, width:CGFloat, height: CGFloat){
        super.init(center: center, width: width, height: height)
    }
    
}
