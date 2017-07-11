//
//  VOFBDataService.swift
//  Voiash
//
//  Created by Brenda Saavedra on 03/07/17.
//  Copyright © 2017 Pitaya Estudio. All rights reserved.
//

import Foundation
import Firebase


typealias CompletionUser = (_ user:VOFBUser?)-> Void

class VOFBDataService {
    fileprivate static let _shared = VOFBDataService()
    
    var myUser: VOFBUser?
    
    static var shared:VOFBDataService{
        return _shared
    }

    var mainRef:DatabaseReference {
        return Database.database().reference().child(K.FB.kindDB)
    }
    
    var usersRef:DatabaseReference {
        return mainRef.child(K.FB.user.ref)
    }
    
    var mainStorageRef: StorageReference {
        return Storage.storage().reference(forURL: K.FB.urlStorage)
    }
    
    var imagesStorageRef: StorageReference {
        return mainStorageRef.child(K.FB.user.ref)
    }
    
    //MARK: - User
    /*
    * Save user with all data
    */
    func saveUser(uid: String, userData:JSONStandard, onComplete:@escaping (_ success:Bool)-> Void){
        usersRef.child(uid).setValue(userData, withCompletionBlock: { (err, ref) in
            if err == nil {
                self.myUser = VOFBUser.init(userKey: uid, userData: userData)
                onComplete(true)
            }else{
                onComplete(false)
            }
        })
    }
    
    /*
     * Get the users data
     */
    func getUser(uid: String, onComplete:@escaping CompletionUser){
        usersRef.child(uid).observeSingleEvent(of: .value, with: {(snapshot)  in
            if snapshot.exists() {
                if let data = snapshot.value as? JSONStandard {
                    let user = VOFBUser.init(userKey:uid, userData:data)
                    onComplete(user)
                    return
                }
            }else{
                onComplete(nil)
            }
        })
    }
    
    /*
     * Update users data
     */
    func updateMyUser(name:String, lastName:String, age:String, data:Data?, onComplete: @escaping (_ errMsg: String?)-> Void ){
        var newData: Dictionary<String, Any>! = [K.FB.user.birthday:"\(age)", K.FB.user.lastName:"\(lastName)", K.FB.user.name: "\(name)"]
        
        let userId = self.myUser!.userKey!
        if let data = data {
            let storage = imagesStorageRef.child(userId).child(K.FB.urlProfile)
            let snapName = "\(K.FB.user.nameProfilePicture).jpg"
            
            let ref = storage.child(snapName)
            
            ref.delete(completion: { (error) in
                if error != nil {
                    print("======> error delete \(userId)/\(K.FB.user.nameProfilePicture):: \(error.debugDescription)")
                }
                _ = ref.putData(data, metadata: nil, completion: { (meta, err) in
                    if err != nil {
                        onComplete(err?.localizedDescription)
                    }else{
                        let downloadURL = meta!.downloadURL()?.absoluteString
                        newData[K.FB.user.urlAvatar] = downloadURL!
                        
                        self.usersRef.child(userId).updateChildValues(newData)
                        self.myUser!.birthday = age
                        self.myUser!.name = name
                        self.myUser!.lastName = lastName
                        self.myUser!.urlAvatar = meta!.downloadURL()!
                        onComplete(nil)
                    }
                })
            })
        }else{
            self.usersRef.child(userId).updateChildValues(newData)
            self.myUser!.birthday = age
            self.myUser!.name = name
            self.myUser!.lastName = lastName
            onComplete(nil)
        }
    }
    
    /*
     Delete all contents of current User
     */
    func deleteMyUser(_ onComplete:@escaping (_ error:String?)-> Void){
        let userId = self.myUser!.userKey
        self.usersRef.child(userId!).removeValue { (error, ref) in
            if error != nil {
                onComplete(error?.localizedDescription)
            }else{
                self.imagesStorageRef.child(userId!).delete(completion: { (error) in
                    if error != nil {
                        print(error.debugDescription)
                    }
                    
                    let user = Auth.auth().currentUser
                    user?.reauthenticate(with: VOFBAuthService.shared.currentCredential!) { error in
                        if let error = error {
                            print("========> error reauth")
                            self.myUser = nil
                            onComplete(nil)
                        } else {
                            Auth.auth().currentUser?.delete { error in
                                if error != nil {
                                    onComplete(error.debugDescription)
                                } else {
                                    self.myUser = nil
                                    VOFBAuthService.shared.currentCredential = nil
                                    onComplete(nil)
                                }
                            }
                        }
                    }
                    
                    
                })
            }
        }
    }
    
    
}
