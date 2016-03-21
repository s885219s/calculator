//
//  ViewController.swift
//  Calculator
//
//  Created by sodas on 2/28/16.
//  Copyright © 2016 sodas. All rights reserved.
//

import UIKit
import CalculatorCore

class ViewController: UIViewController {

    var core: Core<Float>!
    func resetCore() {
        self.core = Core()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.resetCore()
    }
    
    var opSignal: Bool = false
    
    @IBOutlet weak var displayLabel: DisplayLabel!

    @IBAction func numericButtonClicked
        (sender: UIButton) {
        if(opSignal){
            self.displayLabel.clear()
            opSignal = false
        }
        if sender.tag >= 1000 && sender.tag < 1010 {
            self.displayLabel.append(sender.tag - 1000)
        } else if sender.tag == 1010 {
            self.displayLabel.append(0)
            self.displayLabel.append(0)
        }
    }

    @IBAction func negativeButtonClicked(sender: UIButton) {
        self.displayLabel.changeSign()
    }

    @IBAction func operatorButtonClicked(sender: UIButton) {
        try! self.core.addStep(self.displayLabel.floatValue)

        switch (sender.titleForState(.Normal)!) {
        case "+":
            try! self.core.addStep(+)
        case "-":
            try! self.core.addStep(-)
        case "×":
            try! self.core.addStep(*)
        case "÷":
            try! self.core.addStep(/)
        default:
            break
        }
        opSignal=true
        //self.displayLabel.clear()
    }

    @IBAction func calculateButtonClicked(sender: UIButton) {
        try! self.core.addStep(self.displayLabel.floatValue)
        self.displayLabel.floatValue = try! self.core.calculate()
        self.resetCore()
    }

    @IBAction func percentButtonClicked(sender: UIButton) {
        self.displayLabel.percent()
    }
    @IBAction func dotBottinClicked(sender: UIButton) {
        self.displayLabel.decimal()
    }
    @IBAction func resetButtonClicked(sender: UIButton) {
        self.resetCore()
        self.displayLabel.clear()
    }
}

