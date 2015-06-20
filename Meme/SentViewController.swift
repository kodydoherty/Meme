//
//  SentViewController.swift
//  Meme
//
//  Created by Samuel Doherty on 6/19/15.
//  Copyright (c) 2015 ColombiaIOS. All rights reserved.
//

import UIKit

class SentViewController: UIViewController {
    
    var meme:Meme!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if meme != nil {
            imageView.image = meme.memedImage
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButton(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
