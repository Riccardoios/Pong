//
//  MenuVC.swift
//  Pong
//
//  Created by Riccardo Carlotto on 21/12/2019.
//  Copyright © 2019 Riccardo Carlotto. All rights reserved.
//

import Foundation
import UIKit

enum gameType {
    case easy
    case medium
    case hard
    case player2
}

class MenuVC : UIViewController {
    
    @IBAction func Player2(_ sender: UIButton) {
        moveToGame(game: .player2)
    }
    
    @IBAction func Easy(_ sender: UIButton) {
        moveToGame(game: .easy)
    }
    @IBAction func Medium(_ sender: UIButton) {
        moveToGame(game: .medium)
    }

    @IBAction func Hard(_ sender: UIButton) {
        moveToGame(game: .hard)
    }
    
    func moveToGame(game: gameType) {
        let gameVC = self.storyboard?.instantiateViewController(identifier: "gameVC") as! GameViewController
        currentGameType = game
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
    
}
