//
//  ViewController.swift
//  simple-calc
//
//  Created by Michelle Ho on 10/17/18.
//  Copyright © 2018 Michelle Ho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var nums: [Int] = []
    var ops: [String] = []
    var count = 0
    var opOpen = false
    var newExp = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet weak var output: UILabel!
    
    @IBAction func operations(_ sender: UIButton) {
        let op = sender.titleLabel!.text
        
        // if expression in progress, add numbers displayed to nums for later use
        if (Int(output.text!) != nil) {
            nums.append(Int(output.text!)!)
        }
        
        // if op can happen (numbers appear on label), update label text, add op to ops, opOpen true
        // start newExp
        if (op != "=" && output.text != "") {
            output.text = op
            ops.append(op!)
            opOpen = true
        } else if (op == "=") {     // otherwise calculate output
            output.text = String(calculate())
            newExp = true
        }
    }
    
    @IBAction func numbers(_ sender: UIButton) {
        // if new expression is starting, refresh all previous expression info
        if (newExp) {
            nums = []
            ops = []
            count = 0
            opOpen = false
            newExp = false
            output.text = ""
        }
        
        // operation is not about to happen: ("" becomes "7", "7 becomes "78") -- update label
        if (!opOpen) {
            output.text = output.text! + sender.titleLabel!.text!
        } else { // if operation is about to happen (output text is an operation), clear output text and output text becomes number. newExp starting
            output.text = sender.titleLabel!.text!
            opOpen = true
        }
    }
    
    // clear all previous history
    @IBAction func clear(_ sender: Any) {
        nums = []
        ops = []
        output.text = ""
    }
    
    func calculate() -> Int {
        let op = ops[0]
        switch op {
        case "count":
            nums = []
            ops = []
            return count
        case "avg":
            nums = []
            ops = []
            var sum = 0
            for num in nums {
                sum = sum + num
            }
            return sum/count
        case "fact":
            nums = []
            ops = []
            var start = nums[0]
            var product = nums[0] //5
            while (start - 1 > 0) { // 5 4 3 2 1
                product = product * start - 1
                start = start - 1
            }
            return product
        default: // if general +/-%*
            return calculate(nums[0], nums[1], op)
        }
    }
    
    func calculate(_ x1: Int, _ x2: Int, _ op: String) -> Int {
        switch op {
        case "+":
            return x1 + x2
        case "-":
            return x1 - x2
        case "/":
            return x1 / x2
        case "%":
            return x1 % x2
        case "*":
            return x1 * x2
        default:
            return 0
        }
    }
}

