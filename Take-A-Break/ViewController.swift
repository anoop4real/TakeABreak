//
//  ViewController.swift
//  Take-A-Break
//
//  Created by anoopm on 04/04/17.
//  Copyright © 2017 anoopm. All rights reserved.
//

import Cocoa
import AVFoundation

class ViewController: NSViewController {

    var currTimer: Timer?
    var timerCount: Int = 0
    var maxTimerCount: Int = 0
    var textToDisplay: String = ""
    @IBOutlet var customText: NSTextField!
    @IBOutlet var doneButton: NSButton!
    var musicPlayer: AVAudioPlayer?
    var statusItem: NSStatusItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func menuChanged(_ sender: NSPopUpButton) {
    }
    
    @IBAction func startTimer(_ sender: Any) {
    }
    
    @IBAction func menuItemChanged(_ sender: Any) {
    }
    
    @IBAction func stopTimer(_ sender: Any) {
    }
    
    @IBAction func setText(_ sender: Any) {
    }
    
    @IBAction func doneText(_ sender: Any) {
    }


}

