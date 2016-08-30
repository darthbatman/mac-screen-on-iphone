//
//  ViewController.swift
//  macScreenGetTest
//
//  Created by Rishi Masand on 12/28/15.
//  Copyright © 2015 Rishi Masand. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var screenView: UIImageView!
    
    var getScreenTimer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getScreenTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("getScreen"), userInfo: nil, repeats: true)
    }
    
    func getScreen() {
        if let checkedUrl = NSURL(string: "http://cb18f256.ngrok.io") {
            screenView.contentMode = .ScaleAspectFill
            downloadImage(checkedUrl)
        }
    }

    func downloadImage(url: NSURL){
        print("Download Started")
        print("lastPathComponent: " + (url.lastPathComponent ?? ""))
        getDataFromUrl(url) { (data, response, error)  in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                print(response?.suggestedFilename ?? "")
                print("Download Finished")
                self.screenView.image = UIImage(data: data)
            }
        }
    }
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

