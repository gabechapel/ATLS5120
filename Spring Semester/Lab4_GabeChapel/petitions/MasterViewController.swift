//
//  MasterViewController.swift
//  petitions
//
//  Created by Gabriel Chapel on 3/1/18.
//  Copyright © 2018 Gabriel Chapel. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var petitions = [Petition]()
    
    func loadjson(){
        let urlPath = "https://api.whitehouse.gov/v1/petitions.json?limit=50"
        guard let url = URL(string: urlPath)
            else {
                print("url error")
                return
        }
        let session = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            guard statusCode == 200
                else{
                    print("file download error")
                    return
            }
            //download successful
            print("download complete")
            DispatchQueue.main.async{self.parsejson(data!)}
        })
        session.resume()
    }
    
    func parsejson(_ data: Data){
        print(data)
        do{
            // get json data
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
            //get all results
            let allresults = json["results"] as! [[String:Any]]
            print(allresults)
            
            // add results to objects
            for result in allresults {
                //check that data exists
                guard let newtitle = result["title"] as? String,
                let newsigCount = result["signatureCount"] as? Int,
                let newurl = result["url"]! as? String
                    else {
                        continue
                }
                //create new object
                let newpetition = Petition(title: newtitle, sigCount: newsigCount, url: newurl)
                //add object to array
                self.petitions.append(newpetition)
            }
        } catch {
            print("Error with JSON: \(error)")
            return
        }
        // reload table data after json has been downloaded
        tableView.reloadData()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        loadjson()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let petition = petitions[indexPath.row]
                let title = petition.title
                let url = petition.url
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = url
                controller.title = title
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let petition = petitions[indexPath.row]
        cell.textLabel!.text = petition.title
        cell.detailTextLabel!.text = String(petition.sigCount) + " signatures"
        cell.backgroundColor = UIColor.init(red: CGFloat((100000.0-Float(petition.sigCount))/100000.0), green: CGFloat(Float(petition.sigCount)/100000.0), blue: 0.0, alpha: 0.5)
        return cell
    }

//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }

//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            objects.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//        }
//    }


}

