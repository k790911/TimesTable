//
//  ViewController.swift
//  TimesTable
//
//  Created by 김재훈 on 2022/05/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var tempNo: Int = 1
    var myTimer: Timer? = nil
    var dapSoo: Int = 0
    
    @IBOutlet var dan: UILabel!
    @IBOutlet var count: UILabel!
    @IBOutlet var dap: UILabel!
    @IBOutlet var myLabel: UILabel!
    
    let btnStart: UIButton = {
        let b = UIButton()
        b.setTitle("Start/Stop", for: .normal)
        b.backgroundColor = .black
        b.frame.size.width = 200
        b.frame.size.height = 52
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(btnStart)
        btnStart.center.x = view.center.x + 200
        btnStart.center.y = view.center.y / 3
        btnStart.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        
        myLabel.text = "0"
        dan.text = "0"
        count.text = "0"
        dap.text = "0"
    }

    @objc func startTimer() {
        
        if myTimer == nil {
            myTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(timerCalled), userInfo: nil, repeats: true)
        } else {
            stopTimer()
        }
    }
    
    @objc func timerCalled() {
        
        myLabel.text = String(tempNo)
        
        if dap.text != " " {
            
            //let danSoo = Int.random(in: 2 ... 9)
            let danSoo = 3
            let countSoo = Int.random(in: 1 ... 9)
            dapSoo = danSoo * countSoo
            
            dan.text = String(danSoo)
            count.text = String(countSoo)
            dap.text = " "
            
            speakTable(dan: danSoo, cnt: countSoo)

        } else {
            tempNo += 1
            
            dap.text = String(dapSoo)
            dapSoo = 0
            
            if tempNo >= 4 {
                stopTimer()
            }
        }
        

        
    }
    
    func stopTimer() {
        myTimer?.invalidate()
        myTimer = nil
        tempNo = 0
        
        //dan.text = "0"
        //count.text = "0"
        //dap.text = "0"
        //myLabel.text = "0"
        
        print("timer stops.")
    }
    
    func speakTable(dan: Int, cnt: Int) {
        
        var danReads: String
        var cntReads: String
        
        switch(dan) {
        case 2: danReads = "이"
        case 3: danReads = "삼"
        case 4: danReads = "사"
        case 5: danReads = "오"
        case 6: danReads = "육"
        case 7: danReads = "칠"
        case 8: danReads = "팔"
        case 9: danReads = "구"
        default: danReads = "영"
        }
        
        switch(cnt) {
        case 1: cntReads = "일은."
        case 2: cntReads = "이."
        case 3: cntReads = "삼은."
        case 4: cntReads = "사."
        case 5: cntReads = "오."
        case 6: cntReads = "육."
        case 7: cntReads = "칠은."
        case 8: cntReads = "팔은."
        case 9: cntReads = "구."
        default: cntReads = "영."
        }
        
        let words: String = danReads + cntReads
        
        let utterane = AVSpeechUtterance(string: words)
        utterane.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        //utterane.rate = 0.5
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterane)
    }
    
}

