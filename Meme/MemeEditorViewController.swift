//
//  ViewController.swift
//  Meme
//
//  Created by Samuel Doherty on 6/17/15.
//  Copyright (c) 2015 ColombiaIOS. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    //IBOutlets
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumbButton: UIBarButtonItem!

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var shareButton: UIBarButtonItem!

    @IBOutlet weak var topTF: UITextField!
    @IBOutlet weak var bottomTF: UITextField!
    //Vars
    let memeTextAttributes = [ NSStrokeColorAttributeName: UIColor.blackColor(), NSForegroundColorAttributeName: UIColor.whiteColor() , NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!, NSStrokeWidthAttributeName: NSNumber(double: -3.0) ]
    
    var memeImageNew:UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        topTF.defaultTextAttributes = memeTextAttributes
        topTF.textAlignment = .Center
        bottomTF.defaultTextAttributes = memeTextAttributes
        bottomTF.textAlignment = .Center
        
        self.tabBarController?.dismissViewControllerAnimated(true, completion: nil)
        
        toggleEnabled(false)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        self.subscribeToKeyboardNotifications()
        self.subscribeToKeyboardNotificationsHide()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
        self.unsubscribeFromKeyboardNotificationsHide() 
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage  {
                self.imageView.image = image
            }
            self.dismissViewControllerAnimated(true, completion: nil)
            
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // dismiss keyboard from textfields
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    // Keyboard Notifications
    func keyboardWillHide(notification: NSNotification){
        if(bottomTF.isFirstResponder()) {
            self.view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillShow(notification: NSNotification){
        if(bottomTF.isFirstResponder()) {
            self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func subscribeToKeyboardNotificationsHide() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil )
        
    }
    
    func unsubscribeFromKeyboardNotificationsHide(){
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    //Creating Meme 
    func save() -> UIImage {
        var meme = Meme(top: topTF.text!, bottom: bottomTF.text!, image: imageView.image!, memedImage: generateMemedImage())
        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
        return meme.memedImage
    }
    
    func generateMemedImage() -> UIImage {
        toggleNavs(true)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        toggleNavs(false)
        
        return memeImage
    }

    
    //IBActions
    @IBAction func shareMeme(sender: UIBarButtonItem) {
        memeImageNew = self.save()
        let vc = UIActivityViewController(activityItems: [memeImageNew], applicationActivities: [])
        presentViewController(vc, animated: true, completion: nil)
        self.shareButton.enabled = false
        
        vc.completionWithItemsHandler = {
            (activity, success, items, error) in
            if success {
                var nextVC = self.storyboard?.instantiateViewControllerWithIdentifier("tabBarController") as! UITabBarController
                self.presentViewController(nextVC, animated: true, completion: nil)
            }
        }
    }
    @IBAction func cancelEdit(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
 
    @IBAction func pickAnImageWithCamera(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
        toggleEnabled(true)
    }
    @IBAction func pickAnImage(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
        toggleEnabled(true)


        
    }
    
    
    //Helper functions
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    func toggleEnabled(toggle:Bool) {
        self.shareButton.enabled = toggle
        self.topTF.enabled = toggle
        self.bottomTF.enabled = toggle
    }
    
    func toggleNavs(toggle:Bool) {
        self.navigationController?.setNavigationBarHidden(toggle, animated: false)
        self.toolbar.hidden = toggle
    }


}

