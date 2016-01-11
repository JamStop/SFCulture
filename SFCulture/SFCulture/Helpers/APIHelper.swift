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
    
    func getCultureForUser(userid: String, handler: resultHandler) {
        ref = Firebase(url: firebaseURL + "users/" + userid)
        ref.queryOrderedByKey().observeEventType(.ChildAdded, withBlock: {
            snapshot in
            print(snapshot)
            guard let complete = snapshot else {
                handler(result: nil, error: "Error fetching user culture")
                return
            }
            guard let culture = snapshot.value["cultures"] as? String else {
                handler(result: nil, error: nil)
                return
            }
            handler(result: culture, error: nil)

        })
    }
    
    func setCultureForUser(userid: String, culture: String, handler: resultHandler) {
        ref = Firebase(url: firebaseURL + "users/" + userid)
        ref.updateChildValues(["culture": culture], withCompletionBlock: { error, firebase in
            if error != nil {
                handler(result: "", error: error.localizedDescription)
            }
            else {
                handler(result: "", error: "")
            }
        })
    }
    
}
