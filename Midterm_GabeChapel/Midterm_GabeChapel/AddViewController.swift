//
//  AddViewController.swift
//  Midterm_GabeChapel
//
//  Created by Gabriel Chapel on 3/15/18.
//  Copyright © 2018 Gabriel Chapel. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    @IBOutlet weak var restaurantName: UITextField!
    @IBOutlet weak var restaurantURL: UITextField!
    
    var addedRestaurant = String()
    var addedURL = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "savesegue"{
            if restaurantName.text?.isEmpty == false && restaurantURL.text?.isEmpty == false {
                addedRestaurant = restaurantName.text!
                addedURL = restaurantURL.text!
            }
        }
    }


}
