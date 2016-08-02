//
//  MealViewController.swift
//  LHL-June.FoodTracker.Swift
//
//  Created by Asuka Nakagawa on 2016-07-31.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
//    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    /*
     This value is either passed by `MealTableViewController` in `prepareForSegue(_:sender:)`
     or constructed as part of adding a new meal.
     */
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Handle the textField's user input through delegate callbacks.
        // 1. textField
        nameTextField.delegate = self
        
        // Set up views if editing an existing Meal.
        if let meal = meal {
            
            navigationItem.title = meal.name
            nameTextField.text   = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
        
        checkValidMealName()        // Enable the Save button only if the text field has a valid Meal name.

    
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
        
        checkValidMealName()    // check if the text field has text in it, which enables the SaveButton if it does.
        navigationItem.title = textField.text    // sets the title of the scene to that text.

//        mealNameLabel.text = textField.text
    }
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.enabled = false
    }
    
    func checkValidMealName() {
        // Disable the Save button if the text field is empty.
        let text = nameTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
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
    

    // MARK: Navigation
    
    
    
    
    
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // identity operator (===) to check that the object referenced by the saveButton outlet is the same object instance as sender
        if saveButton === sender {
            
            /* nil coalescing operator is used to return the value of an optional if the optional has a value, or return a default value otherwise. Here, the operator unwraps the optional String returned by nameTextField.text (which is optional because there may or may not be text in the text field), and returns that value if it’s a valid string. But if it’s nil, the operator the returns the empty string ("") instead. */
            let name = nameTextField.text ?? ""
            let photo = photoImageView.image
            let rating = ratingControl.rating
            
            
            // Set the meal to be passed to MealTableViewController after the unwind segue.
            meal = Meal(name: name, photo: photo, rating: rating)
        }
    }
    
    
    // MARK: Actions
    
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        // it now only happens when isPresentingInAddMealMode is true.
        if isPresentingInAddMealMode {
            dismissViewControllerAnimated(true, completion: nil)
            
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    

    
    
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

