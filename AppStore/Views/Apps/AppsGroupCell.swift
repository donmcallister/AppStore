//
//  AppsGroupCell.swift
//  AppStore
//
//  Created by Donald McAllister on 5/13/19.
//  Copyright © 2019 Donald McAllister. All rights reserved.
//
// To layout a horizontal cell inside the gray cell?
// Add another collection view inside it: horizontalController = UIViewController
// let horizontalController = UIViewController() //dummy collection controller
//  addSubview(horizontalController.view)
// horizontalController.view.anchor(top: titleLabel.bottomAnchor
// now we can create a HorizontalController
//now can trade out dummy collection controller with AppsHorizontalController()
//now we see our nested controller with purple as defined in AppsHorizontalController class
//now we can render out our horizontal cells inside AppsHorizontalcontroller.. 

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
    }
}

class AppsGroupCell: UICollectionViewCell {
  
    let titleLabel = UILabel(text: "App Section",
                             font: .boldSystemFont(ofSize: 30))
    
//    let titleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "App Section"
//        label.font = .boldSystemFont(ofSize: 30)
//        return label
//    }()
    
    let horizontalController = AppsHorizontalController() //dummy collection controller
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightGray //.purple just prior to see if rendering this cell in AppsController..
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        
        addSubview(horizontalController.view)
        horizontalController.view.backgroundColor = .blue
        horizontalController.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
