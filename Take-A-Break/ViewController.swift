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
    @IBOutlet var timerLabel:NSTextField!
    @IBOutlet var customText: NSTextField!
    @IBOutlet var doneButton: NSButton!
    var musicPlayer: AVAudioPlayer?
    var statusItem: NSStatusItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func setUp(){
        
        maxTimerCount = 20 * 60
        timerCount = 0
        customText.isHidden = true
        doneButton.isHidden = true
        textToDisplay = getDisplayStringfromDefaults()
        if !textToDisplay.isEmpty {
            customText.stringValue = textToDisplay
        }
        statusItem = NSStatusBar.system().statusItem(withLength: 100.0)
        statusItem?.title = "0"
    }
    
    func updateLabel(_ timer: Timer) {
        //NSLog(@"Updated");
        timerCount += 1
        timerLabel.stringValue = "Seconds elapsed:\(Int(timerCount))"
        statusItem?.title = "Sec:\(Int(timerCount))"
        if timerCount >= maxTimerCount {
            timerCount = 0
            playAlert()
            let newString = "\(textToDisplay) \nNo break taken since:\(getDateAsString())"
    
            let alert = NSAlert()
            alert.messageText = newString
            alert.alertStyle = NSAlertStyle.warning
            alert.addButton(withTitle: "OK")
            alert.runModal()
        }
    }
    
    func getDateAsString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss"
        return dateFormatter.string(from: Date())
    }
    func storeTextToUserDefaults() {
        let pref = UserDefaults.standard
        pref.set(textToDisplay, forKey: "dispString")
    }
    
    func getDisplayStringfromDefaults() -> String {
        let pref = UserDefaults.standard
        var savedString = ""
        if let dataStr = pref.object(forKey: "dispString") as? String{
            
            savedString = dataStr
        }
        return savedString
    }
    
    func playAlert() {
        let pathURL = Bundle.main.url(forResource: "Horn", withExtension: "mp3")

        musicPlayer = try? AVAudioPlayer(contentsOf: pathURL!)
        musicPlayer?.prepareToPlay()
        musicPlayer?.play()
    }
    
    @IBAction func menuChanged(_ sender: NSPopUpButton) {
        
        let btn = sender
        if let selectedItemtitle = btn.selectedItem?.title {
            //NSLog(@"Selected value is %@",selectedItem);
            maxTimerCount = Int(selectedItemtitle)!
        }

    }
    
    @IBAction func startTimer(_ sender: Any) {
        
        currTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateLabel), userInfo: nil, repeats: true)
    }
    

    @IBAction func stopTimer(_ sender: Any) {
        
        currTimer?.invalidate()
        timerCount = 0
        timerLabel.stringValue = "Seconds elapsed:\(Int(timerCount))"
    }
    

    @IBAction func setText(_ sender: Any) {
        customText.isHidden = false
        doneButton.isHidden = false
    }
    
    @IBAction func doneText(_ sender: Any) {
        
        customText.isHidden = true
        doneButton.isHidden = true
        textToDisplay = customText.stringValue
        storeTextToUserDefaults()
    }


}

