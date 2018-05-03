//
//  ViewController.swift
//  TicTacToe
//
//  Created by Khalnayak on 04/04/18.
//  Copyright © 2018 Khalnayak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
 
    @IBOutlet weak var bu9: UIButton!
    @IBOutlet weak var bu8: UIButton!
    @IBOutlet weak var bu7: UIButton!
    @IBOutlet weak var bu6: UIButton!
    @IBOutlet weak var bu5: UIButton!
    @IBOutlet weak var bu4: UIButton!
    @IBOutlet weak var bu3: UIButton!
    @IBOutlet weak var bu2: UIButton!
    @IBOutlet weak var bu1: UIButton!
    //height of button
    @IBOutlet weak var bu1Height: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setting height
        bu1Height.constant = CGFloat(Double(UIScreen.main.bounds.width/4))
    }

    @IBAction func btnSelectEvent(_ sender: Any) {
        let btnSelect = sender as! UIButton
        playGame(btnSelect: btnSelect)
    }
    
    var activePlayer = 1
    var player1 = [Int]()
    var player2 = [Int]()
    
    @objc func playGame(btnSelect:UIButton){
        var isWinner = false
        
        if activePlayer == 1 {
            btnSelect.setTitle("X", for: UIControlState.normal)
            btnSelect.backgroundColor = UIColor(red: 102/255, green: 251/255, blue: 50/255, alpha: 0.5)
            player1.append(btnSelect.tag)
            isWinner = findWinner(player: player1)
            if isWinner == false {
                activePlayer = 2
                autoPlay()
            }else{
                showWinner(playerName: "You")
            }
        }else{
            btnSelect.setTitle("O", for: .normal)
            btnSelect.backgroundColor = UIColor(red: 32/255, green: 190/255, blue: 245/255, alpha: 0.5)
            player2.append(btnSelect.tag)
            isWinner = findWinner(player: player2)
            if isWinner {
                showWinner(playerName: "Siri")
            }
            activePlayer = 1
        }
        btnSelect.isEnabled = false
    }
    
    func showWinner(playerName : String) {
        let alert = UIAlertController(title: "Winner", message: "\(playerName) Wins", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: { (UIAlertAction) in
            self.refreshView()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func refreshView() {
        self.player1.removeAll()
        self.player2.removeAll()
        
        for view in self.view.subviews as [UIView] {
            if let btn = view as? UIButton {
                btn.setTitle("", for: UIControlState.normal)
                btn.isEnabled = true
                btn.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
            }
        }
        self.viewDidLoad()
    }
    
    func findWinner(player: [Int]) -> Bool{
        
        //Rows
        if ((player.contains(1)&&player.contains(2)&&player.contains(3)) || (player.contains(4)&&player.contains(5)&&player.contains(6)) || (player.contains(7)&&player.contains(8)&&player.contains(9))){
            return true
        }
        //Columns
        if ((player.contains(1)&&player.contains(4)&&player.contains(7)) || (player.contains(2)&&player.contains(5)&&player.contains(8)) || (player.contains(3)&&player.contains(6)&&player.contains(9))){
            return true
        }
        //Daigonal
        if ((player.contains(1)&&player.contains(5)&&player.contains(9)) || (player.contains(3)&&player.contains(5)&&player.contains(7))){
            return true
        }
        return false
    }
    
    
    func isWinning(player: [Int]) -> Int {
        //Rows
        if (player.contains(2)&&player.contains(3)){
            return 1
        }else if (player.contains(1)&&player.contains(3)){
            return 2
        }else if (player.contains(1)&&player.contains(2)){
            return 3
        }else if (player.contains(5)&&player.contains(6)){
            return 4
        }else if (player.contains(4)&&player.contains(6)){
            return 5
        }else if (player.contains(4)&&player.contains(5)){
            return 6
        }else if (player.contains(8)&&player.contains(9)){
            return 7
        }else if (player.contains(7)&&player.contains(9)){
            return 8
        }else if (player.contains(7)&&player.contains(8)){
            return 9
        }
        
        //Columns
        
        if (player.contains(4)&&player.contains(7)){
            return 1
        }else if (player.contains(1)&&player.contains(7)){
            return 4
        }else if (player.contains(1)&&player.contains(4)){
            return 7
        }else if (player.contains(5)&&player.contains(8)){
            return 2
        }else if (player.contains(2)&&player.contains(8)){
            return 5
        }else if (player.contains(2)&&player.contains(5)){
            return 8
        }else if (player.contains(6)&&player.contains(9)){
            return 3
        }else if (player.contains(3)&&player.contains(9)){
            return 6
        }else if (player.contains(3)&&player.contains(6)){
            return 9
        }
      
        //Daigonal
        if (player.contains(5)&&player.contains(9)){
            return 1
        }else if (player.contains(1)&&player.contains(9)){
            return 5
        }else if (player.contains(1)&&player.contains(5)){
            return 9
        }else if (player.contains(5)&&player.contains(7)){
            return 3
        }else if (player.contains(3)&&player.contains(7)){
            return 5
        }else if (player.contains(3)&&player.contains(5)){
            return 7
        }
       return 0
    }
    
    func autoPlay() {
        //scan empty place
        var emptyCell = [Int]()
        for index in 1...9{
            if !(player1.contains(index)||player2.contains(index)){
                emptyCell.append(index)
            }
        }
        
        if (isWinning(player: player2) != 0) {
            
            let cellID = isWinning(player: player2)
            
            if emptyCell.contains(cellID){
                 selectButton(cellID: cellID)
            }else{
                if emptyCell.count != 0{
                let randIndex = arc4random_uniform(UInt32(emptyCell.count))
                let cellID = emptyCell[Int(randIndex)]
                selectButton(cellID: cellID)
             }
            }
            
        }else if(isWinning(player: player1) != 0){
            
            let cellID = isWinning(player: player1)
            
            if emptyCell.contains(cellID){
                selectButton(cellID: cellID)
            }else{
                 if emptyCell.count != 0{
                let randIndex = arc4random_uniform(UInt32(emptyCell.count))
                let cellID = emptyCell[Int(randIndex)]
                selectButton(cellID: cellID)
                }
            }
            
        }else{

            let randIndex = arc4random_uniform(UInt32(emptyCell.count))
            let cellID = emptyCell[Int(randIndex)]
            selectButton(cellID: cellID)
            
        }
        
    }
    
    func selectButton(cellID : Int) {
        var btnSelect : UIButton?
        
        switch cellID {
        case 1 :
            btnSelect = bu1
        case 2 :
            btnSelect = bu2
        case 3 :
            btnSelect = bu3
        case 4 :
            btnSelect = bu4
        case 5 :
            btnSelect = bu5
        case 6 :
            btnSelect = bu6
        case 7 :
            btnSelect = bu7
        case 8 :
            btnSelect = bu8
        case 9 :
            btnSelect = bu9
        default:
            btnSelect = bu1
        }
        playGame(btnSelect: btnSelect!)
    }
    
}
