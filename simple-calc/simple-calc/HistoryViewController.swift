//
//  HistoryViewController.swift
//  simple-calc
//
//  Created by Michelle Ho on 10/21/18.
//  Copyright © 2018 Michelle Ho. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    var history: [String] = []
    var yOffset: Int = 0
    @IBOutlet weak var scrollview: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(history)

        for equation in history.reversed() {
            let label = UILabel(frame: CGRect(x:20,y:1 * yOffset, width:200, height: 50))
            yOffset += 50
            label.text = equation
            
            scrollview.addSubview(label)
        }
        
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "HomeSegue") {
            if let destination = segue.destination as? ViewController {
                destination.history = self.history
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
