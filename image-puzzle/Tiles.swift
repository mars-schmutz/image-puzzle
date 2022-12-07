//
//  Tiles.swift
//  image-puzzle
//
//  Created by Marshall Schmutz on 11/30/22.
//

import Foundation
import Cocoa

class Tiles {
    // world view size
    let wX: Int = 300
    let wY: Int = 300
    
    // tile size
    let tW: CGFloat = 100.0
    let tH: CGFloat = 100.0
    
    var rules: Int = 1
    
    var tiles: [[Tile]] = []
    var winnerPos: [[NSRect]] = []
    var world: NSView? = nil
    var empty: NSRect? = nil // empty space frame
    
    let nc = NotificationCenter.default
    
    init() {
        var id: Int = 1
        for _ in 0..<3 {
            var row: [Tile] = []
            for _ in 0..<3 {
                let img = Tile(frame: NSRect(origin: .zero, size: CGSize(width: 100.0, height: 100.0)))
                img.identifier = NSUserInterfaceItemIdentifier(rawValue: "img\(id)")
                img.tiles = self
                row.append(img)
                id += 1
            }
            tiles.append(row)
        }
        
        tiles[tiles.count - 1].removeLast()
        empty = NSMakeRect(200.0, 200.0, tW, tH)
        
        // set up listeners
        nc.addObserver(self, selector: #selector(useMountain), name: Notification.Name("useMountain"), object: nil)
        nc.addObserver(self, selector: #selector(usePhone), name: Notification.Name("usePhone"), object: nil)
    }
    
    @objc func useMountain() {
        replaceImg(prefix: "test_split_T")
        print("images replaced")
    }
    
    @objc func usePhone() {
        replaceImg(prefix: "phone")
        print("images replaced")
    }
    
    func createTiles() {
        var c: Int = 1
        for row in tiles {
            for t in row {
                let img = NSImage(named: "test_split_T\(c)")
                c += 1
                let sz = NSSize(width: 100, height: 100)

                img?.size = sz
                t.image = img
            }
        }
    }
    
    func setupTiles() {
        createTiles()
        
        for r in 0..<tiles.count {
            var row: [NSRect] = []
            for t in 0..<tiles[r].count {
                let x: CGFloat = (100 * CGFloat(t)).truncatingRemainder(dividingBy: CGFloat(300.0))
                let y: CGFloat = (100 * CGFloat(r)).truncatingRemainder(dividingBy: CGFloat(300.0))
                let frame = NSMakeRect(x, y, tW, tH)
                row.append(frame)
            }
            winnerPos.append(row)
        }
        
        for row in 0..<tiles.count {
            for t in 0..<tiles[row].count {
                tiles[row][t].frame = winnerPos[row][t]
                world?.addSubview(tiles[row][t])
            }
        }
        
        shuffleTiles()
    }
    
    func shuffleTiles() {
        let flattened_tiles: [Tile] = Array(self.tiles.joined())
        var flattened_frames: [NSRect] = Array(self.winnerPos.joined())
        flattened_frames.shuffle()
        empty = NSMakeRect(200.0, 200.0, tW, tH)
        
        for ft in 0..<flattened_tiles.count {
            flattened_tiles[ft].frame = flattened_frames[ft]
        }
    }
    
    func replaceImg(prefix: String) {
        for r in 0..<tiles.count {
            for t in 0..<tiles[r].count {
                var img_num = tiles[r][t].identifier?.rawValue.last!
                let name: String = "\(prefix)\(img_num!)"
                print(name)
                let img = NSImage(named: name)
                let sz = NSSize(width: 100, height: 100)
                img?.size = sz
                tiles[r][t].image = img
            }
        }
    }
    
    func checkWin() -> Bool {
        var win = true
        for r in 0..<tiles.count {
            for t in 0..<tiles[r].count {
                let myX: CGFloat = tiles[r][t].frame.minX
                let myY: CGFloat = tiles[r][t].frame.minY
                let expectedX: CGFloat = winnerPos[r][t].minX
                let expectedY: CGFloat = winnerPos[r][t].minY
                let same: Bool = (myX == expectedX) && (myY == expectedY)
                if (!same) {
                    win = false
                }
            }
        }
        if (win) {
            print("YOU WON!!1!")
        }
        return win
    }
}
