//
//  ViewController.swift
//  Landing Page
//
//  Created by xian he on 2/4/16.
//  Copyright © 2016 com.foodeasygo.dev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var titleMessage: UILabel!
    @IBOutlet weak var infoMessage: UILabel!
    
    
    override func viewDidLoad() {
        
        
        
        let myUrl = NSURL(string: "***");//URL在接口说明上
        let request = NSMutableURLRequest(URL:myUrl!);
        request.HTTPMethod = "GET";
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(myUrl!, completionHandler: { data, response, error -> Void in
            //print(data)
            if (error != nil) {
                print(error?.localizedDescription)
            }
            
            var err: NSError?
            
            do{
                //把数据以dictionary形式储存
                let parseJSON = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                
                //parseJSON内的2个data
                let resultValue = parseJSON["code"] as! Int
                
                let resultMessage = parseJSON["data"] as! NSDictionary
                
                //result对应API接口说明的变量名data，以dictionary形式储存
                let webOpen = resultMessage["webopen"] as! String
                
                //尚未设置背景图
                let image = resultMessage["app_bg_img"] as! String
                
                let closeTitle = resultMessage["close_title"] as! String
                
                let closeWords = resultMessage["close_words"] as! String
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    if webOpen != "1" {
                        self.titleMessage.text = closeTitle
                        self.infoMessage.text = closeWords
                    }
                    else {
                        // continue to http://*** URL后缀为getRegionList
                        self.titleMessage.text = "Web Open"
                        self.infoMessage.text = ""
                    }
                })
            }
            catch {
                print("Error: \(err)")
            }
        })
        
        task.resume();
        
        
        
        super.viewDidLoad()
        
        
        //
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

