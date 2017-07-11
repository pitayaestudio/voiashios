//
//  VODiscoverListVC.swift
//  Voiash
//
//  Created by Brenda Saavedra on 7/5/17.
//  Copyright © 2017 Pitaya Estudio. All rights reserved.
//

import UIKit

class VODiscoverListVC: VOBaseVC {

    @IBOutlet weak var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       self.navigationController?.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    
    
    
    // MARK: - IBAction
    @IBAction func onMenuBtnPressed(){
        
    }
 
    @IBAction func onNotificationsBtnPressed(){
        
    }

}

extension VODiscoverListVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VODiscoverTypeCell
        cell.configureCell()
        return cell
    }
}

extension VODiscoverListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
