//
//  ViewController.swift
//  Midterm_GabrielChapel
//
//  Created by Gabriel Chapel on 10/19/17.
//  Copyright © 2017 Gabriel Chapel. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var miles: UITextField!
    @IBOutlet weak var totalCommuteTime: UILabel!
    @IBOutlet weak var totalGasNeeded: UILabel!
    @IBOutlet weak var monthSwitch: UISwitch!
    @IBOutlet weak var transportType: UISegmentedControl!
    @IBOutlet weak var transportImage: UIImageView!
    @IBOutlet weak var tankGas: UILabel!
    
    @IBAction func commuteButton(_ sender: UIButton) {
        updateCommuteInfo()
    }
    
    @IBAction func showMonthlyInfo(_ sender: Any) {
        updateCommuteInfo()
    }
    
    @IBAction func transportSelect(_ sender: Any) {
        updateCommuteInfo()
    }
    
    @IBAction func changeTankGas(_ sender: UISlider) {
        let gasAmount = sender.value
        tankGas.text = String(format: "%.0f", gasAmount)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func updateCommuteInfo() {
        var distance:Float
        let carSpeed:Float = 20.0
        let carGasMileage:Float = 24.0
        
        let busSpeed:Float = 12
        
        let bikeSpeed:Float = 10
        
        if miles.text!.isEmpty{
            distance = 0.0
        }else{
            distance = Float(miles.text!)!
        }
        
        if distance > 50.0 {
            let alert = UIAlertController(title: "Warning", message: "You are traveling over 50 miles.", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
        
        if transportType.selectedSegmentIndex==0{
            transportImage.image = UIImage(named: "car")
            var commuteTime = distance / carSpeed
            var gasNeeded = distance / carGasMileage
            let numberFormat = NumberFormatter()
            if monthSwitch.isOn{
                commuteTime = commuteTime*20
                gasNeeded = gasNeeded*20
            }
            numberFormat.numberStyle=NumberFormatter.Style.decimal
            totalCommuteTime.text = numberFormat.string(from: NSNumber(value: commuteTime))
            totalGasNeeded.text = numberFormat.string(from: NSNumber(value: gasNeeded))
        }else if transportType.selectedSegmentIndex==1{
            transportImage.image = UIImage(named: "bus")
            var commuteTime = distance/busSpeed
            var gasNeeded = 0.0
            let numberFormat = NumberFormatter()
            if monthSwitch.isOn{
                commuteTime = commuteTime*20
                gasNeeded = gasNeeded*20
            }
            numberFormat.numberStyle=NumberFormatter.Style.decimal
            totalCommuteTime.text = numberFormat.string(from: NSNumber(value: commuteTime))
            totalGasNeeded.text = numberFormat.string(from: NSNumber(value: gasNeeded))
        }else if transportType.selectedSegmentIndex==2{
            transportImage.image = UIImage(named: "bike")
            var commuteTime = distance/bikeSpeed
            var gasNeeded = 0.0
            let numberFormat = NumberFormatter()
            if monthSwitch.isOn{
                commuteTime = commuteTime*20
                gasNeeded = gasNeeded*20
            }
            numberFormat.numberStyle=NumberFormatter.Style.decimal
            totalCommuteTime.text = numberFormat.string(from: NSNumber(value: commuteTime))
            totalGasNeeded.text = numberFormat.string(from: NSNumber(value: gasNeeded))
        }
    }
    
    override func viewDidLoad() {
        miles.delegate=self
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onTapGestureRecognized(_ sender: Any) {
        miles.resignFirstResponder()
        // Exit keyboard when screen is tapped
    }

}

