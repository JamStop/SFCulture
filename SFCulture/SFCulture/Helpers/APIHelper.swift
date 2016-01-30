//
//  APIHelper
//  SFCulture
//
//  Created by Jimmy Yue on 1/8/16.
//  Copyright © 2016 Augmented Humanity. All rights reserved.
//

import Foundation
import RxSwift
import Firebase
import SDWebImage
import RealmSwift
import Alamofire

class APIHelper {
    var ref: Firebase!
    
    let realm = try! Realm()
    let imageDownloader = SDWebImageDownloader()
    
    let firebaseURL = "https://sfculture.firebaseio.com/"
    
    typealias resultHandler = (result: String?, error: String?) -> Void
    typealias requestHandler = (response: JSON?, error: String?) -> Void
    typealias JSON = [String: AnyObject]
    
//    func getUsersForCulture(
    
    func getCultureForUser(userid: String, handler: resultHandler) {
//        ref = Firebase(url: firebaseURL + "users/" + userid)
//        ref.queryOrderedByKey().observeEventType(.ChildAdded, withBlock: {
//            snapshot in
//            print(snapshot.value)
//            guard let complete = snapshot.childSnapshotForPath("culture") else {
//                handler(result: nil, error: "Error fetching user culture")
//                return
//            }
//            guard let culture = complete.value as? String else {
//                handler(result: nil, error: nil)
//                return
//            }
//            handler(result: culture, error: nil)
//
//        })
        self.get("users/" + userid, handler: {
            response, err in
            if err != nil {
                print(err)
            }
            else {
                guard let culture = response!["culture"] as? String else{
                    handler(result:nil, error: nil)
                    return
                }
                handler(result: culture, error: nil)
            }
        })
    }
    
    func rx_getCultureForUser(userid: String) -> Observable<String> {
        return Observable.create { observer in
            self.get("users/" + userid, handler: {
                response, err in
                if let culture = response!["culture"]! as? String {
                    observer.onNext(culture)
                }
                observer.onCompleted()
            })
            
            return NopDisposable.instance
        }
        
    }
    
    func setCultureForUser(user: User, culture: String, handler: resultHandler) {
        ref = Firebase(url: firebaseURL + "users/" + user.uid)
        let firebaseCulturesRef = Firebase(url: firebaseURL)
        let newUser = [
            "name": user.name,
            "profilePicture": user.profilePictureURL!
            ]
        let newCulture = [
            user.uid: newUser
            ]
        firebaseCulturesRef.childByAppendingPath("cultures").childByAppendingPath(culture).updateChildValues(newCulture)
        ref.updateChildValues(["culture": culture], withCompletionBlock: { error, firebase in
            if error != nil {
                handler(result: "", error: error.localizedDescription)
            }
            else {
                handler(result: "", error: "")
            }
        })
    }
    
    func rx_getUsersInCulture(culture: String) -> Observable<JSON> {
        ref = Firebase(url: firebaseURL)
        return Observable.create { observer in
            self.ref.childByAppendingPath("cultures").childByAppendingPath(culture).queryOrderedByChild("name").observeEventType(.ChildAdded, withBlock: { snapshot in
                
                guard let userJSON = snapshot.value as? JSON else {
                    return
                }
                
                print(userJSON)
                
                
                
            })
            return NopDisposable.instance
        }
        
    }
    
    private func get(endPoint: String, handler: requestHandler?) {
        
        request(.GET, endpoint: endPoint, handler: handler)
        
    }
    
    private func post(endPoint: String, handler: requestHandler?) {
        
        request(.POST, endpoint: endPoint, handler: handler)
        
    }
    
    private func request(method: Alamofire.Method, endpoint: String, handler: requestHandler?) {
        
        let encoding: Alamofire.ParameterEncoding = method == Alamofire.Method.GET ? .URL : .JSON
        print(firebaseURL + endpoint + ".json")
        Alamofire.request(method, firebaseURL + endpoint + ".json", encoding: encoding, headers: nil)
            .responseJSON(options: .AllowFragments) { (Response) -> Void in
                
                guard let response = Response.response else {
                    handler?(response: nil, error: "No Response")
                    return
                }
                    
                guard let responseJSON = Response.result.value as? JSON else {
                    handler?(response: nil, error: "Error parsing JSON")
                    return
                }
                handler?(response: responseJSON, error: nil)
                
                
        }
        
    }
    
}
