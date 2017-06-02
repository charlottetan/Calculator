//
//  ViewController.swift
//  Calculator
//
//  Created by Charlotte Tan on 5/22/17.
//  Copyright © 2017 Charlotte Tan. All rights reserved.
//

import UIKit

enum OpMode {
    case notSet
    case div
    case mult
    case subtract
    case add
}

enum NumMode {
    case normal
    case dot
}

extension Double {
    var cleanValue: String {
        return String(format: "%g", self)
    }
    
    var trailingDotValue: String {
        if (!cleanValue.contains(".")) {
            return cleanValue.appending(".")
        }
        
        return cleanValue
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    var currentOpMode:OpMode = .notSet
    var currentNumMode:NumMode = .normal
    var savedNum:Double = 0
    var labelNum:Double = 0
    var lastButtonWasOpMode:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressClear(_ sender: Any) {
        reset()
        updateText()
    }
    
    @IBAction func didPressSign(_ sender: Any) {
        labelNum *= -1
        updateText()
        
    }
    
    @IBAction func didPressPercent(_ sender: Any) {
        labelNum /= 100
        updateText()
    }
    
    @IBAction func didPressDiv(_ sender: Any) {
        changeOpMode(newOpMode: .div)
    }

    @IBAction func didPressMult(_ sender: Any) {
        changeOpMode(newOpMode: .mult)
    }
 
    @IBAction func didPressSubtract(_ sender: Any) {
        changeOpMode(newOpMode: .subtract)
    }
    
    @IBAction func didPressAdd(_ sender: Any) {
        changeOpMode(newOpMode: .add)
    }
    
    @IBAction func didPressEquals(_ sender: Any) {
        changeOpMode(newOpMode: .notSet)
    }
    
    @IBAction func didPressDot(_ sender: Any) {
        if (labelNum == 0 || labelNum.cleanValue.contains(".")) {
            return
        }
        
        currentNumMode = .dot
        updateText()
    }
    
    @IBAction func didPressNumber(_ sender: UIButton) {
        let stringValue:String? = sender.titleLabel?.text
        
        if (lastButtonWasOpMode) {
            labelNum = 0
        }
        
        lastButtonWasOpMode = false
        
        var labelString = currentNumMode == .dot ? labelNum.trailingDotValue : labelNum.cleanValue
        labelString = labelString.appending(stringValue!)
        
        guard let labelNumGuard:Double = Double(labelString) else {
            return
        }
        
        labelNum = labelNumGuard
        
        updateText()
    }
    
    func reset() {
        currentOpMode = .notSet
        currentNumMode = .normal
        savedNum = 0
        labelNum = 0
        lastButtonWasOpMode = false
    }
    
    func updateText() {
        label.text = currentNumMode == .dot ? labelNum.trailingDotValue : labelNum.cleanValue
        
    }
    
    func changeOpMode(newOpMode:OpMode) {
        switch currentOpMode {
        case .add:
            savedNum += labelNum
        case .subtract:
            savedNum -= labelNum
        case .mult:
            savedNum *= labelNum
        case .div:
            savedNum /= labelNum
        default:
            savedNum = labelNum
        }

        labelNum = savedNum
        
        currentOpMode = newOpMode
        lastButtonWasOpMode = true
        currentNumMode = .normal
        
        updateText()
    }
}

