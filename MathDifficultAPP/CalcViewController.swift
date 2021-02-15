//
//  CalcViewController.swift
//  MathDifficultAPP
//
//  Created by 井関竜太郎 on 2021/02/14.
//

import UIKit
import AVFoundation

class CalcViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var timeDownLabel: UILabel!
    
     
    var answer = 0
    var point = 0
    var time = 60
    var timer:Timer?
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ボタンを押して話した時。。。
        button1.addTarget(self, action: #selector(onButton(_:)), for: .touchUpInside)
        //ボタンを押して話した時。。。
        button2.addTarget(self, action: #selector(onButton(_:)), for: .touchUpInside)
        //ボタンを押して話した時。。。
        button3.addTarget(self, action: #selector(onButton(_:)), for: .touchUpInside)
        //ボタンを押して話した時。。。
        button4.addTarget(self, action: #selector(onButton(_:)), for: .touchUpInside)
        
        makeNewQuestion()
        setButtonTitle()
        timer = Timer.scheduledTimer(timeInterval: 1,target: self,selector: #selector(countTime), userInfo: nil,repeats: true)
        timeDownLabel.isHidden = true
    }
    
    @objc func countTime() {
        time -= 1
        timeLabel.text = "残り\(time)秒"
        if time <= 0 {
            //残りが０になったら、
            timer?.invalidate()
            performSegue(withIdentifier: "next", sender: nil)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! ResultViewController
        nextVC.point = point
    }
    
    
    
    
    
    func makeNewQuestion() {
        
        let num1 = Int.random(in: 0...999)
        label.text = "\(num1) ✖︎ \(num1) = "
        answer = num1 * num1
    }
    
    func setButtonTitle() {
        var answerList = [answer]
        while answerList.count < 4 {
            let randomAnswer = Int.random(in: 0...998001)
            if !answerList.contains(randomAnswer) {
                answerList.append(randomAnswer)
            }
        }
        answerList.shuffle()
        button1.setTitle(String(answerList[0]), for: .normal)
        button2.setTitle(String(answerList[1]), for: .normal)
        button3.setTitle(String(answerList[2]), for: .normal)
        button4.setTitle(String(answerList[3]), for: .normal)
    }
    
    
    //一斉に表示する。。sender->押されたボタン
    @objc func onButton(_ sender:UIButton) {
        let input = Int(sender.currentTitle!)
        if input == answer {
            answerLabel.text = "前回の回答：正解"
            point += 1
            timeDownLabel.isHidden = true
            playSound(name: "maru")
        }else{
            answerLabel.text = "前回の回答：不正解"
            time -= 1
            timeDownLabel.isHidden = false
            timeDownLabel.text = "-1秒"
            playSound(name: "batu")
            
         
        }
        makeNewQuestion()
        setButtonTitle()
    }
    
    
    
    var player:AVAudioPlayer?
    
    func playSound(name:String) {
        let path = Bundle.main.bundleURL.appendingPathComponent(name+".mp3")
        do{
            player = try AVAudioPlayer(contentsOf: path,fileTypeHint: nil)
            player?.play()
        }catch{
            print("error")
        }
    }
    
    
    
}
