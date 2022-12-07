//
//  ViewController.swift
//  image-puzzle
//
//  Created by Marshall Schmutz on 11/30/22.
//

import Cocoa

class ViewController: NSViewController {
    var tiles = Tiles()
    
    @IBOutlet weak var rulesSwitch: NSSwitch!
    @IBOutlet weak var winMsg: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let world = self.view.subviews[0]
        tiles.world = world
        tiles.setupTiles()
        winMsg.isHidden = true
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(winnerWinner), name: Notification.Name("winnerWinner"), object: nil)
    }
    
    @objc func winnerWinner() {
        winMsg.isHidden = false
    }
    
    @IBAction func rulesToggled(_ sender: Any) {
        tiles.rules = rulesSwitch.state.rawValue
    }
    
    @IBAction func shuffleTiles(_ sender: NSButton) {
        self.tiles.initial_layout = self.tiles.shuffleTiles()
        winMsg.isHidden = true
    }
    
    @IBAction func restartCurrent(_ sender: NSButton) {
        self.tiles.restartGame()
        winMsg.isHidden = true
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

