//
//  RestaurantTableViewController.swift
//  Midterm_GabeChapel
//
//  Created by Gabriel Chapel on 3/15/18.
//  Copyright © 2018 Gabriel Chapel. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    var restaurants = Restaurant()
    var restaurantName = [String]()
    var restaurantURL = [String]()
    var restaurantList = [[String]]()
    let kfilename = "data1.plist"
    
    @IBAction func unwindSegue(segue:UIStoryboardSegue){
        if segue.identifier == "savesegue" {
            let source = segue.source as! AddViewController
            if source.addedRestaurant.isEmpty == false {
                restaurantList.append([source.addedRestaurant, source.addedURL])
                tableView.reloadData()
            }
        }
    }

    @objc func applicationWillResignActive(_ notification: NSNotification){
        let dirPath = FileManager.default.urls(for:.documentDirectory, in: .userDomainMask)
        let docDir = dirPath[0]
        print(docDir)
        let dataFileURL = docDir.appendingPathComponent(kfilename)
        let plistencoder = PropertyListEncoder()
        plistencoder.outputFormat = .xml
        do{
            let data = try plistencoder.encode(restaurantList)
            try data.write(to: dataFileURL)
        }catch{
            print(error)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var restaurant = restaurants.restaurant
        
        let app = UIApplication.shared
        NotificationCenter.default.addObserver(self, selector: #selector(RestaurantTableViewController.applicationWillResignActive(_:)), name: NSNotification.Name.UIApplicationWillResignActive, object: app)
        
        //URL for plist
        if let pathURL = Bundle.main.url(forResource: "restaurants", withExtension: "plist"){
            let plistdecoder = PropertyListDecoder()
            do{
                let data = try Data(contentsOf: pathURL)
                restaurant = try plistdecoder.decode([[String:String]].self, from:data)
                for i in 0...restaurant.count{
                    restaurantList.append([restaurant[i]["name"]!, restaurant[i]["url"]!])
                }
            } catch{
                //handle error
                print(error)
            }
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurantList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantcell", for: indexPath)
        let restaurant = restaurantList[indexPath.row]
        cell.textLabel!.text = restaurant[0]
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            restaurantList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showdetail" {
            let detailVC = segue.destination as! WebViewController
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            let restaurant = restaurantList[indexPath.row]
            detailVC.title = restaurant[0]
            detailVC.webpage = restaurant[1]
        }
    }


}
