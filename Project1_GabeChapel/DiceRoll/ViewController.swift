//
//  ViewController.swift
//  DiceRoll
//
//  Created by Gabriel Chapel on 9/30/17.
//  Copyright © 2017 Gabriel Chapel. All rights reserved.
//

import UIKit
var i : Int = 0
var num : Int = 0
var num1 : Int = 1
var num2 : Int = 2
var num3 : Int = 3
var num4 : Int = 4
var num5 : Int = 5
var num6 : Int = 6

class ViewController: UIViewController {
    @IBOutlet weak var oneImage: UIButton!
    @IBOutlet weak var twoImage: UIButton!
    @IBOutlet weak var threeImage: UIButton!
    @IBOutlet weak var fourImage: UIButton!
    @IBOutlet weak var fiveImage: UIButton!
    @IBOutlet weak var sixImage: UIButton!
    @IBOutlet weak var Result: UILabel!
    @IBOutlet weak var numberDice: UILabel!
    @IBOutlet weak var dieSlider: UISlider!
    @IBOutlet weak var rollAll: UIButton!
    
    func showImage(Number:Int, imageName:UIButton!){
        imageName.setImage(UIImage(named:String(Number)), for: .normal)
    }
    func hideImage(imageName:UIButton!){
        imageName.setImage(nil, for: .normal)
    }
    
    @IBAction func rollAllButton(_ sender: UIButton) {
        self.oneDie(oneImage)
        self.twoDie(twoImage)
        self.threeDie(threeImage)
        self.fourDie(fourImage)
        self.fiveDie(fiveImage)
        self.sixDie(sixImage)
    }
    @IBAction func changeDiceNumber(_ sender: UISlider) {
        let dieNumber = Int(sender.value)
        if dieNumber == 6 {
            showImage(Number:2,imageName:twoImage)
            showImage(Number:3,imageName:threeImage)
            showImage(Number:4,imageName:fourImage)
            showImage(Number:5,imageName:fiveImage)
            showImage(Number:6, imageName:sixImage)
        }
        if dieNumber == 5 {
            showImage(Number:2,imageName:twoImage)
            showImage(Number:3,imageName:threeImage)
            showImage(Number:4,imageName:fourImage)
            showImage(Number:5,imageName:fiveImage)
            hideImage(imageName:sixImage)
        }
        else if dieNumber == 4 {
            showImage(Number:2,imageName:twoImage)
            showImage(Number:3,imageName:threeImage)
            showImage(Number:4,imageName:fourImage)
            hideImage(imageName:fiveImage)
            hideImage(imageName:sixImage)
        }
        else if dieNumber == 3 {
            showImage(Number:2,imageName:twoImage)
            showImage(Number:3,imageName:threeImage)
            hideImage(imageName:fourImage)
            hideImage(imageName:fiveImage)
            hideImage(imageName:sixImage)
        }
        else if dieNumber == 2 {
            showImage(Number:2,imageName:twoImage)
            hideImage(imageName:threeImage)
            hideImage(imageName:fourImage)
            hideImage(imageName:fiveImage)
            hideImage(imageName:sixImage)
        }
        else if dieNumber == 1 {
            hideImage(imageName:twoImage)
            hideImage(imageName:threeImage)
            hideImage(imageName:fourImage)
            hideImage(imageName:fiveImage)
            hideImage(imageName:sixImage)
        }
        numberDice.text = String(format: "%.0f", sender.value)
    }
    
    // The delay function below was derived from https://stackoverflow.com/questions/38031137/how-to-program-a-delay-in-swift-3
    func rollDie(die:Int, imageName:UIButton!){
        for i in 0 ... 10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) / 10.0) {
                num = Int(arc4random_uniform(6)) + 1
                imageName.setImage(UIImage(named: String(num)), for: .normal)
            }
        }
    }
    
    
    func updateResult(num1:Int, num2:Int, num3:Int, num4:Int, num5:Int, num6:Int){
        let resultNumber: Int = Int(dieSlider.value)
        var num:[Int] = [num1, num2, num3, num4, num5, num6]
        if resultNumber < 6{
        num.removeSubrange(resultNumber...5)
        }
        let resultSum = num.reduce(0, +)
        Result.text = String(resultSum)
        }
    
    @IBAction func oneDie(_ sender: UIButton) {
        rollDie(die:num1, imageName: oneImage)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.updateResult(num1:num, num2:num2, num3:num3, num4:num4, num5:num5, num6:num6)
            num1 = num
        }
    }
    
    @IBAction func twoDie(_ sender: UIButton) {
        if Int(dieSlider.value) > 1 {
        rollDie(die:2, imageName: twoImage)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.updateResult(num1:num1, num2:num, num3:num3, num4:num4, num5:num5, num6:num6)
            num2 = num
            }
        }
    }
    
    @IBAction func threeDie(_ sender: UIButton) {
        if Int(dieSlider.value) > 2 {
        rollDie(die:3, imageName: threeImage)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.updateResult(num1:num1, num2:num2, num3:num, num4:num4, num5:num5, num6:num6)
            num3 = num
            }
        }
    }
    
    @IBAction func fourDie(_ sender: UIButton) {
        if Int(dieSlider.value) > 3 {
        rollDie(die:4, imageName: fourImage)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.updateResult(num1:num1, num2:num2, num3:num3, num4:num, num5:num5, num6:num6)
            num4 = num
            }
        }
    }
    
    @IBAction func fiveDie(_ sender: UIButton) {
        if Int(dieSlider.value) > 4 {
        rollDie(die:5, imageName: fiveImage)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.updateResult(num1:num1, num2:num2, num3:num3, num4:num4, num5:num, num6:num6)
            num5 = num
            }
        }
    }
    
    @IBAction func sixDie(_ sender: UIButton) {
        if Int(dieSlider.value) > 5 {
        rollDie(die:6, imageName: sixImage)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.updateResult(num1:num1, num2:num2, num3:num3, num4:num4, num5:num5, num6:num)
            num6 = num
        }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.becomeFirstResponder()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The following two overrides are derived from https://stackoverflow.com/questions/33503531/detect-shake-gesture-ios-swift
    override var canBecomeFirstResponder: Bool {
        get{
            return true
        }
    }
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEventSubtype.motionShake{
            self.oneDie(oneImage)
            self.twoDie(twoImage)
            self.threeDie(threeImage)
            self.fourDie(fourImage)
            self.fiveDie(fiveImage)
            self.sixDie(sixImage)
        }
    }


}

