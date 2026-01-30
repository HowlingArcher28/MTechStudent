//
//  ViewController.swift
//  DisplayingData
//
//  Created by Zachary Jensen on 1/20/26.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myText: UILabel!
    
    @IBOutlet weak var myButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
    }
    @IBAction func Buttontap(_ sender: Any) {
        myText.text = "FBI Agent"
    }
    

}

