//
//  ViewController.swift
//  LHL-June.FoodTracker.Swift
//
//  Created by Asuka Nakagawa on 2016-07-31.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    // Handle the textField's user input through delegate callbacks.
    // 1. textField
    nameTextField.delegate = self
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: UITextField Delegate // called when 'return' key pressed. return NO to ignore.
    // 1-1.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        // Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
    // 1-2.
    func textFieldDidEndEditing(textField: UITextField) {
        mealNameLabel.text = textField.text
    }
    
    // 3-1.
    // UIImagePickerControllerDelegate // Dismiss the VC if user canceled.
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // 3-2.
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Actions
    // 2.imagePicker
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        
        // if the user taps the image view while typing in the text field, the keyboard is dismissed properly.
        // 2-1.
        nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        // 2-2.
        let imagePickerController = UIImagePickerController()
        // 2-3.
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        // 2-4.
        imagePickerController.delegate = self
        // 2-5.
        presentViewController(imagePickerController, animated: true, completion: nil)
        
    }
    
//    @IBAction func setDefaultLabelText(sender: UIButton) {
//        mealNameLabel.text = "Default Text"
//    }
    
    
}

