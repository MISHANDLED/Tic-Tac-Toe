//
//  ViewController.swift
//  TicTacToe
//
//  Created by Devansh Mohata on 28/09/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var whoseTurn: UILabel!
    
    //Grid Buttons
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn8: UIButton!
    @IBOutlet weak var btn9: UIButton!

    // Custom Variables
    
    var firstTurn = "X"
    var currTurn = "X"
    var count: Int = 0
    var board = [UIButton]()
    
    var boardArr = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBoard()
    }
    
    private func initBoard() {
        
        whoseTurn.text = firstTurn
        
        for _ in 0...2 {
            boardArr.append(["","",""])
        }
        
        board.append(btn1)
        board.append(btn2)
        board.append(btn3)
        board.append(btn4)
        board.append(btn5)
        board.append(btn6)
        board.append(btn7)
        board.append(btn8)
        board.append(btn9)
    }
    
    
    
    @IBAction func onBtnClick(_ sender: UIButton) {
        if(sender.title(for: .normal) == nil) {
            sender.setTitle(currTurn, for: .normal)
            count += 1
        
            if let pos = board.firstIndex(of: sender) {
                let x: Int = pos / 3
                let y: Int = pos % 3
                boardArr[x][y] = currTurn
                if checkWinner(x: x, y: y, value: currTurn) && count >= 2 {
                    let alert = UIAlertController(title: "We have a Winner", message: "Player \(currTurn) is the winner", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: gameReset)
                } else if (count == 9) {
                    let alert = UIAlertController(title: "It's a Draw", message: "No Winner", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: gameReset)
                }
                
            }
            
            currTurn = currTurn == "X" ? "O" : "X"
            whoseTurn.text = currTurn
        }
    }
    
    private func checkWinner(x: Int, y: Int, value: String) -> Bool {
        
        var col = 0, row = 0, diag = 0, rdiag = 0
        
        for i in 0..<3 {
            if boardArr[x][i] == value {
                col += 1
            }
            if boardArr[i][y] == value {
                row += 1
            }
            if boardArr[i][i] == value {
                diag += 1
            }
            if boardArr[i][3-i-1] == value {
                rdiag += 1
            }
        }
        
        if row == 3 || col == 3 || diag == 3 || rdiag == 3 {
            return true
        }
        return false
    }
    
    private func gameReset() {
        currTurn = firstTurn
        count = 0
        whoseTurn.text = currTurn
        
        boardArr = [[String]]()
        
        for _ in 0...2 {
            boardArr.append(["","",""])
        }
        
        
        for ele in board {
            ele.setTitle(nil, for: .normal)
            ele.isEnabled = true
        }
        
    }
        
}

