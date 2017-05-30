//
//  AboutViewController.swift
//  AirHockey2
//
//  Created by student1 on 5/26/17.
//  Copyright © 2017 John Hersey High School. All rights reserved.
//

import UIKit
import AVFoundation

let cheerSoundURL =  Bundle.main.url(forResource: "cheerSound", withExtension: "mp3")!
var cheerPlayer = AVAudioPlayer()



class AboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func playMySound(){
        cheerPlayer = try! AVAudioPlayer(contentsOf: cheerSoundURL)
        cheerPlayer.prepareToPlay()
        cheerPlayer.play()
    }
    
    @IBAction func back(_ sender: UIButton) {
        var viewControllerForSegue = self.view?.window?.rootViewController
        viewControllerForSegue?.dismiss(animated: true, completion: nil)
    }

    @IBAction func button1(_ sender: UIButton) {
        playMySound()
    }

    @IBAction func button2(_ sender: UIButton) {
        playMySound()
    }
    
    @IBAction func button3(_ sender: UIButton) {
        playMySound()
    }
    
}
