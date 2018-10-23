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
    var newExp = false
    var inProgress = false
    var exp: String = ""
    var history: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "HistorySegue") {
            if let destination = segue.destination as? HistoryViewController {
            destination.history = self.history
            }
        }
    }
        

    @IBOutlet weak var output: UILabel!
    
    @IBAction func operations(_ sender: UIButton) {
        let op = sender.titleLabel!.text
        
        // numbers displaying in output label
        if (output.text != "" && !inProgress) {
            nums.append(Int(output.text!)!)
            exp += output.text! + " "
        }
        
        // cases: op is +-*/, op is =, op is avg/count/fact
        if (op != "=" && output.text != "") {
            output.text = op
            ops.append(op!)
            inProgress = true
            exp += output.text! + " "
        } else if (op == "=" && output.text != ""){ // op is "="
            output.text = String(calculate())
            exp += "= " + output.text!
            history.append(exp)
            newExp = true
            print(history)
        }
    }
    
    @IBAction func numbers(_ sender: UIButton) {
        if (newExp) {
            nums = []
            ops = []
            inProgress = true
            exp = ""
            newExp = false
        }
        
        // first time: input number - set output text to number
        if (!inProgress) {
            output.text = output.text! + sender.titleLabel!.text!
        } else { // operation is currently in label (operation happening)
            output.text = sender.titleLabel!.text!
            inProgress = false
        }
    }
    
    func calculate() -> Int {
        let op = ops[0]
        switch op {
        case "avg":
            var sum = 0
            for num in nums {
                sum += num
            }
            return sum / nums.count
        case "count":
            return nums.count
        case "fact":
            return factorial(nums[0])
        default: // +-*/%
            return calculate(nums[0], nums[1], op)
        }
    }
    
    func factorial(_ num: Int) -> Int {
        if (num == 0) {
            return 1
        }
        var product = 1
        for i in 1...num {
            product = product * i
        }
        return product
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
    
    // clear all previous history
    @IBAction func clear(_ sender: Any) {
        output.text = ""
        nums = []
        ops = []
        newExp = false
        inProgress = false
        exp = ""
        
    }
}

