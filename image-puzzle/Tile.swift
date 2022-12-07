//
//  Tile.swift
//  image-puzzle
//
//  Created by Marshall Schmutz on 11/30/22.
//

import Foundation
import Cocoa

class Tile: NSImageView {
    var tiles: Tiles! // reference to parent class (NOT new Tiles() instance)
    
    override func mouseUp(with event: NSEvent) {
        if !canImove() {
            return
        }
        let myFrame = self.frame
//        print("my frame: \(myFrame.minX), \(myFrame.minY)")
//        print("empty frame: \(self.tiles.empty?.minX), \(self.tiles.empty?.minY)")
//        print("")
        self.frame = self.tiles.empty!
        self.tiles.empty = myFrame
        // check for win?
//        print("ME: \(self.identifier)")
        print(self.tiles.checkWin())
    }
    
    func canImove() -> Bool {
        if (self.tiles.rules == 0) {
            return true
        }
        let valid_moves = [
            [self.frame.minX, self.frame.minY + self.tiles.tH], // top
            [self.frame.minX + self.tiles.tW, self.frame.minY], // right
            [self.frame.minX, self.frame.minY - self.tiles.tH], // bottom
            [self.frame.minX - self.tiles.tW, self.frame.minY] // left
        ]
        
        for move in valid_moves {
            if (self.tiles.empty!.minX == move[0]) && (self.tiles.empty!.minY == move[1]) {
                return true
            }
        }
        return false
    }
}
