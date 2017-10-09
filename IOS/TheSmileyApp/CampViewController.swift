//
//  CampViewController.swift
//  TheSmileyApp
//
//  Created by Yicong Gong on 10/6/17.
//  Copyright © 2017 Yicong Gong. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CampViewController: UIViewController {

    @IBOutlet weak var ExpNumText: UILabel!
    @IBOutlet weak var ExperienceText: UILabel!
    @IBOutlet weak var NameText: UILabel!
    @IBOutlet weak var EmailText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Request User Infomation
        requestProfileInfo(email:currentUser.email)
        requestFriendList(email: currentUser.email)
        requestPlaces(email: currentUser.email, rule:"default")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Enter_Smiley(_ sender: Any) {
//        input =
//            [
//                ["https://www.materdei.org/pics/alumni/facebook.png", "-33.870001", "151.21000001"],
//                ["https://upload.wikimedia.org/wikipedia/commons/d/d5/Japan_small_icon.png", "-33.88", "151.25"]
//        ]
//        requestPlaces(email: currentUser.email, rule:"default")
    }
    
    func requestProfileInfo(email:String)
    {
        //Request User Infomation
        
        let parameters: Parameters = [
            "email": email
        ]
        Alamofire.request("https://thatsmileycompany.com/profile", method: .get, parameters: parameters).responseJSON
            {   response in
                
                let result = response.result.value
                let data = JSON(result!)
                
                //Present Data
                self.ExpNumText.text = data["id"].stringValue
                self.ExperienceText.text = data["experience"].stringValue
                self.NameText.text = data["name"].stringValue
                self.EmailText.text = data["email"].stringValue
        }
    }
    
    func requestFriendList(email:String)
    {
        //Request Friendlist
        let parameters: Parameters = [
            "email": email
        ]
        Alamofire.request("https://thatsmileycompany.com/friendlist", method: .get, parameters: parameters).responseJSON
            {   response in
                
                let result = response.result.value
                let friends = JSON(result!)
                
                //Load Data to Friendlist
                Friends.removeAllFriend()
                Friends.initFriend(rows: 3)
                for (_, friend):(String, JSON) in friends {
                    Friends.addFriend(newFriend: friend["name"].stringValue, emailID: friend["email"].stringValue, ExNum: friend["explorer_num"].stringValue)
                }
        }
    }
    
//    func requestPlaces(email:String)
//    {
//        //Request and Load Places
//
//        let parameters: Parameters = [
//            "email": email,
//            "rule" : "default"
//        ]
//        Alamofire.request("https://thatsmileycompany.com/map", method: .get, parameters: parameters).responseJSON
//            {   response in
//
//                let result = response.result.value
//                let data = JSON(result!)
//
//                //Load Data to Places
//                Places.removeAll()
//                for (index, place):(String, JSON) in data {
//                    let i = Int(index)!
//                    Places[i][0] = place["url"].stringValue
//                    Places[i][1] = place["lat"].stringValue
//                    Places[i][2] = place["lng"].stringValue
//                }
//        }
//    }
    
    

}
