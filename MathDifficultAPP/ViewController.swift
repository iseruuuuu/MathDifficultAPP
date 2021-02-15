//
//  ViewController.swift
//  MathDifficultAPP
//
//  Created by 井関竜太郎 on 2021/02/14.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var start: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var player:AVAudioPlayer?
    var playing:Bool = false
    var point = 0
    var rank = 0
    var hightScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        start.layer.cornerRadius = start.frame.height*0.5
        start.clipsToBounds = true
        
        if playing == false {
        
        
        let soundURL = Bundle.main.url(forResource: "BGM", withExtension: "mp3")
        do {
            player = try AVAudioPlayer(contentsOf: soundURL!)
            player?.numberOfLoops = -1   // ループ再生する
            player?.prepareToPlay()      // 即時再生させる
            player?.play()               // BGMを鳴らす
        } catch {
            print("error...")
        
        }
        }else{
    }
    
}

override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    scoreLabel.text = "あなたのハイスコア：\(hightScore)点 \(rank)級"
    
}

}
