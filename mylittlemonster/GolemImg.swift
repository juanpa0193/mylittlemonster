//
//  MonsterImg.swift
//  mylittlemonster
//
//  Created by JuanPa Villa on 6/14/16.
//  Copyright © 2016 JuanPa Villa. All rights reserved.
//

import Foundation
import UIKit

class GolemImg: MonsterImg {
    
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

        self.image = UIImage(named: "idle1.png")
        
        self.animationImages = nil
        
        var imageArray = [UIImage]()
        
        for x in 1...4 {
            let img = UIImage(named: "idle\(x).png")
            imageArray.append(img!)
            
        
            }
        
        self.animationImages = imageArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 0
        self.startAnimating()
    }
    
    
    override func playDeadAnimation() {
        
        self.image = UIImage(named: "dead5.png")
        
        self.animationImages = nil
        
        var imageArray = [UIImage]()
        
        for x in 1...5 {
            let img = UIImage(named: "dead\(x).png")
            imageArray.append(img!)
        }
        
        
        
        self.animationImages = imageArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1
        self.startAnimating()
    
        
        
    }

    
    
    
}
