//
//  VODiscoverListVC.swift
//  Voiash
//
//  Created by Brenda Saavedra on 7/5/17.
//  Copyright © 2017 Pitaya Estudio. All rights reserved.
//

import UIKit

class VODiscoverListVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VODiscoverTypeCell
        cell.configureCell()
        return cell
    }
    
    
    // MARK: - IBAction
    @IBAction func onMenuBtnPressed(){
        
    }
 
    @IBAction func onNotificationsBtnPressed(){
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
