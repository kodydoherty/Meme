//
//  MemeTableViewController.swift
//  Meme
//
//  Created by Samuel Doherty on 6/18/15.
//  Copyright (c) 2015 ColombiaIOS. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController, UINavigationBarDelegate {

    var memes:[Meme]!
    override func viewDidLoad() {
        super.viewDidLoad()
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MemeTableViewCell
        cell.memeImageView.image = memes[indexPath.row].memedImage
        cell.label.text = memes[indexPath.row].top
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let nextVC = storyboard?.instantiateViewControllerWithIdentifier("sentVC") as! SentViewController
        nextVC.meme = memes[indexPath.row]
        self.presentViewController(nextVC, animated: true, completion: nil)
    }

}
