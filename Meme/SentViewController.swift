//
//  SentViewController.swift
//  Meme
//
//  Created by Samuel Doherty on 6/19/15.
//  Copyright (c) 2015 ColombiaIOS. All rights reserved.
//

import UIKit

class SentViewController: UIViewController {
    // Vars
    var meme:Meme!
    
    //IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if meme != nil {
            imageView.image = meme.memedImage
        }
    }
    
    //IBActions
    @IBAction func backButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
