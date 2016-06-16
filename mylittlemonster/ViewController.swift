//
//  ViewController.swift
//  mylittlemonster
//
//  Created by JuanPa Villa on 6/13/16.
//  Copyright © 2016 JuanPa Villa. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    

    @IBOutlet weak var golemImg: GolemImg!
    @IBOutlet weak var kidGolemImg: KidGolemImg!
    @IBOutlet weak var heartImg: DragImg!
    @IBOutlet weak var foodImg: DragImg!
    @IBOutlet weak var penalty1Img: UIImageView!
    @IBOutlet weak var penalty2Img: UIImageView!
    @IBOutlet weak var penalty3Img: UIImageView!
    @IBOutlet weak var restartBttn: UIButton!
    @IBOutlet weak var livesPanel: UIImageView!
    @IBOutlet weak var characterSelectionLbl: UILabel!
    @IBOutlet weak var characterSelectionView: UIStackView!
    @IBOutlet weak var skullStackView: UIStackView!
    
    
    var monsterImgSelected: MonsterImg!
    
  
    
    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE_ALPHA: CGFloat = 1.0
    let MAX_PENALTIES = 3
    
    var currentPenalties = 0
    var monsterHappy = false
    var currentItem: UInt32 = 0
    
    var timer: NSTimer!
    
    var musicPlayer: AVAudioPlayer!
    var sfxBite: AVAudioPlayer!
    var sfxHeart: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.itemDroppedOnCharacter(_:)), name: "onTargetDropped", object: nil)
        
        
        
        
        do {
            try musicPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!))
            try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))
            try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
            try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))
            
            
            musicPlayer.prepareToPlay()
            musicPlayer.play()
            
            sfxBite.prepareToPlay()
            sfxHeart.prepareToPlay()
            sfxSkull.prepareToPlay()
            sfxDeath.prepareToPlay()
       
        } catch let err as NSError {
            print(err.debugDescription)
        }
       
        
    }
    
    
    
    func startTimer() {
        
        if timer != nil {
            timer.invalidate()
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(ViewController.changeGameState), userInfo: nil, repeats: true)
        
    }
    
    
    func changeGameState() {
        
        
        if !monsterHappy {
        currentPenalties += 1
        sfxSkull.play()
        
        if currentPenalties == 1 {
            penalty1Img.alpha = OPAQUE_ALPHA
            penalty2Img.alpha = DIM_ALPHA
        } else if currentPenalties == 2 {
            penalty2Img.alpha = OPAQUE_ALPHA
            penalty3Img.alpha = DIM_ALPHA
        } else if currentPenalties >= 3 {
            penalty3Img.alpha = OPAQUE_ALPHA
        } else {
            penalty1Img.alpha = DIM_ALPHA
            penalty2Img.alpha = DIM_ALPHA
            penalty3Img.alpha = DIM_ALPHA
        }
        
        if currentPenalties >= MAX_PENALTIES {
            gameOver()
        }
        }
        
        let rand = arc4random_uniform(2) // 0 or 1
        
        if rand == 0 {
            foodImg.alpha = DIM_ALPHA
            foodImg.userInteractionEnabled = false
            
            heartImg.alpha = OPAQUE_ALPHA
            heartImg.userInteractionEnabled = true
        } else if rand == 1 {
            heartImg.alpha = DIM_ALPHA
            heartImg.userInteractionEnabled = false
            
            foodImg.alpha = OPAQUE_ALPHA
            foodImg.userInteractionEnabled = true
        }
        
        currentItem = rand
        monsterHappy = false

        
    }
    
    
    func gameOver() {
        timer.invalidate()
        monsterImgSelected.playDeadAnimation()
        sfxDeath.play()
        heartImg.hidden = true
        foodImg.hidden = true
        
        restartBttn.hidden = false
    }
    
    
    func itemDroppedOnCharacter(notif: AnyObject) {
        monsterHappy = true
        startTimer()
        
        foodImg.alpha = DIM_ALPHA
        foodImg.userInteractionEnabled = false
        heartImg.alpha = DIM_ALPHA
        heartImg.userInteractionEnabled = false
        
        
        if currentItem == 0 {
            sfxHeart.play()
        } else {
            sfxBite.play()
        }
        
    }
    
    

    @IBAction func restartBttnPrssed(sender: AnyObject) {
        
        restartBttn.hidden = true
        monsterImgSelected.playIdleAnimation()
        currentPenalties = 0
        penalty1Img.alpha = DIM_ALPHA
        penalty2Img.alpha = DIM_ALPHA
        penalty3Img.alpha = DIM_ALPHA
        heartImg.hidden = false
        foodImg.hidden = false
        
        startTimer()
        
        
        
    }
    
    
    
    func startGame() {
        
        characterSelectionView.hidden = true
        characterSelectionLbl.hidden = true
        
        livesPanel.hidden = false
//        penalty1Img.hidden = false
//        penalty2Img.hidden = false
//        penalty3Img.hidden = false
        skullStackView.hidden = false
        
        penalty1Img.alpha = DIM_ALPHA
        penalty2Img.alpha = DIM_ALPHA
        penalty3Img.alpha = DIM_ALPHA
        

        heartImg.hidden = false
        foodImg.hidden = false
        
        monsterImgSelected.hidden = false
        
        

        
    }
    
    
    @IBAction func golemSelected(sender: AnyObject) {
        startTimer()

        golemImg.hidden = false
        kidGolemImg.hidden = true
        monsterImgSelected = golemImg
        
        loadMonsterImg(golemImg)
        
        startGame()
        
    }
    
    
    
    @IBAction func kidGolemSelected(sender: AnyObject) {
        startTimer()
        
        kidGolemImg.hidden = false
        golemImg.hidden = true

        
        loadMonsterImg(kidGolemImg)
        
        startGame()
        
    }
    
    
    func loadMonsterImg(monsterImg: MonsterImg) {
        monsterImgSelected = monsterImg
        foodImg.dropTarget = monsterImg
        heartImg.dropTarget = monsterImg
        monsterImg.playIdleAnimation()
    }
    
    

}

