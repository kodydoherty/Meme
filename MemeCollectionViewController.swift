//
//  MemeCollectionViewController.swift
//  Meme
//
//  Created by Samuel Doherty on 6/18/15.
//  Copyright (c) 2015 ColombiaIOS. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class MemeCollectionViewController: UICollectionViewController {

    // IBActions
    @IBOutlet var cView: UICollectionView!
    
    //Vars
    var memes: [Meme]!
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
        
        // Screen dementions
        screenSize = UIScreen.mainScreen().bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        // Change layout of collection view
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: screenWidth / 3, height: screenWidth / 3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        cView.collectionViewLayout = layout
        
    }

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MemeCollectionViewCell
        cell.imageView.image = memes[indexPath.row].memedImage
        // Change size of cell
        cell.frame.size.width = screenWidth / 3
        cell.frame.size.height = screenWidth / 3
    
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Cell tapped")
        let nextVC = storyboard?.instantiateViewControllerWithIdentifier("sentVC") as! SentViewController
        nextVC.meme = memes[indexPath.row]
        self.presentViewController(nextVC, animated: true, completion: nil)
    }
}