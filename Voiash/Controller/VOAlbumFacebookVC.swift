//
//  VOAlbumFacebookVC.swift
//  Voiash
//
//  Created by Brenda Saavedra on 10/07/17.
//  Copyright © 2017 Pitaya Estudio. All rights reserved.
//

import UIKit
import GBHFacebookImagePicker

class VOAlbumFacebookVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var imageModels = [GBHFacebookImage]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.backgroundColor = .clear
        self.tableView.tableFooterView = UIView()
        
        // Init picker
        let picker = GBHFacebookImagePicker()
        
        // Allow multiple selection (false by default)
        //GBHFacebookImagePicker.pickerConfig.allowMultipleSelection = false
        //GBHFacebookImagePicker.pickerConfig.maximumSelectedPictures = 1
        
        // Make some customisation
        // self.someCustomisation()
        
        // Present picker
        picker.presentFacebookAlbumImagePicker(from: self,
                                               delegate: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension VOAlbumFacebookVC: GBHFacebookImagePickerDelegate {
    
    // MARK: - GBHFacebookImagePicker Protocol
    
    func facebookImagePicker(imagePicker: UIViewController,
                             successImageModels: [GBHFacebookImage],
                             errorImageModels: [GBHFacebookImage],
                             errors: [Error?]) {
        // Append selected image(s)
        // Do what you want with selected image
        self.imageModels.append(contentsOf: successImageModels)
    }
    
    func facebookImagePicker(imagePicker: UIViewController, didFailWithError error: Error?) {
        print("Cancelled Facebook Album picker with error")
        print(error.debugDescription)
    }
    
    // Optional
    func facebookImagePicker(didCancelled imagePicker: UIViewController) {
        print("Cancelled Facebook Album picker")
    }
    
    // Optional
    func facebookImagePickerDismissed() {
        print("Picker dismissed")
    }
}

extension VOAlbumFacebookVC: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.imageModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! VOFacebookPhotoCell
        cell.selectedImageView.image = self.imageModels[indexPath.row].image
        return cell
    }
}
