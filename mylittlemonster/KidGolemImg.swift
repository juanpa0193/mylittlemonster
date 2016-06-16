//
//  KidGolemImg.swift
//  mylittlemonster
//
//  Created by JuanPa Villa on 6/16/16.
//  Copyright © 2016 JuanPa Villa. All rights reserved.
//

import Foundation
import UIKit

class KidGolemImg: MonsterImg {
    
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//    
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        playIdleAnimation()
//    }
    
    override func playIdleAnimation() {
        
        self.image = UIImage(named: "kidIdle1.png")
        
        self.animationImages = nil
        
        var imageArray = [UIImage]()
        
        for x in 1...4 {
            let img = UIImage(named: "kidIdle\(x).png")
            imageArray.append(img!)
            
            
        }
        
        self.animationImages = imageArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 0
        self.startAnimating()
        
    }
    
    
    override func playDeadAnimation() {
        
        self.image = UIImage(named: "kidDead5.png")
        
        self.animationImages = nil
        
        var imageArray = [UIImage]()
        
        for x in 1...4 {
            let img = UIImage(named: "kidDead\(x).png")
            imageArray.append(img!)
            
            
        }
        
        self.animationImages = imageArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1
        self.startAnimating()
    }
    
    
    
    
}