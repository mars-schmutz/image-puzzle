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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let world = self.view.subviews[0]
        tiles.world = world
        tiles.setupTiles()
//        tiles.checkWin()
    }
    
    @IBAction func rulesToggled(_ sender: Any) {
        tiles.rules = rulesSwitch.state.rawValue
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

