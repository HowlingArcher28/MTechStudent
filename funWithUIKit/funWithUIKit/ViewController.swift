//
//  ViewController.swift
//  funWithUIKit
//
//  Created by Zachary Jensen on 1/20/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var numberSlider: UISlider!
    
    @IBOutlet weak var myText: UILabel!
    
    @IBOutlet weak var buttonTap: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        myText.textColor = .red
        buttonTap.tintColor = .orange
        numberSlider.minimumValue = 0
        numberSlider.maximumValue = 100
        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        myText.textColor = .green
    }
    
    @IBAction func sliderSlid(_ sender: Any) {
        myText.text = String(Int(numberSlider.value))
    }
    
}

