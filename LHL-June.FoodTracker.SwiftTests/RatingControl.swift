//
//  RatingControl.swift
//  LHL-June.FoodTracker.Swift
//
//  Created by Asuka Nakagawa on 2016-07-31.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

import UIKit

class RatingControl: UIView {
    
    
    // MARK: Properties
    var rating = 0 {
        
        // setNeedsLayout(), which will trigger a layout update every time the rating changes.
        didSet {
            setNeedsLayout()
        }
    }
    
    var ratingButtons = [UIButton]()
    
    // Add Properties for Spacing and Number of Stars
    let spacing = 5
    let starCount = 5
    
    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        
        // Add this line to call the superclass’s initializer.
        super.init(coder: aDecoder)

        let filledStarImage = UIImage(named:"filledStar")
        let emptyStarImage = UIImage(named: "emptyStar")
        
        
        // To create a total of five buttons(0-4)
        // The underscore (_) represents a wildcard, which you can use when you don’t need to know which iteration of the loop is currently executing.
        for _ in 0..<starCount {
            
            let button = UIButton()
            
            button.setImage(emptyStarImage, forState: .Normal)
            button.setImage(filledStarImage, forState: .Selected)
            button.setImage(filledStarImage, forState: [.Highlighted, .Selected])
            
            button.adjustsImageWhenHighlighted = false
            
//            button.backgroundColor = UIColor.redColor()
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(_:)), forControlEvents: .TouchDown)
            
            // As you create each button, you add it to the ratingButtons array to keep track of it.
            ratingButtons += [button]
            // The addSubview() method adds the button you created to the RatingControl view.
            addSubview(button)
        }
    }
    
    // This code creates a frame, and uses a for-in loop to iterate over all of the buttons to set their frames.
    override func layoutSubviews() {
        
        // Set the button's width and height to a square the size of the frame's height. instead of 44
        let buttonSize = Int(frame.size.height)
        
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        // Offset each button's origin by the length of the button plus spacing.
        for (index, button) in ratingButtons.enumerate() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
        updateButtonSelectionStates()
    }
    
    override func intrinsicContentSize() -> CGSize {
        
        let buttonSize = Int(frame.size.height)
        
        let width = (buttonSize * starCount) + (spacing * (starCount - 1))

        return CGSize(width: width, height: buttonSize)
    }
    
    // MARK: Button Action
    func ratingButtonTapped(button: UIButton) {
//        print("Rating Button Tapped 👍")
        rating = ratingButtons.indexOf(button)! + 1
        
        updateButtonSelectionStates()
    }
    
    func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerate() {
            
            // If the index of a button is less than the rating, that button should be selected.
            button.selected = index < rating
        }
    }
}


