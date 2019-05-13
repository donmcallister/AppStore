//
//  AppsGroupCell.swift
//  AppStore
//
//  Created by Donald McAllister on 5/13/19.
//  Copyright © 2019 Donald McAllister. All rights reserved.
//


import UIKit



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
        
        // backgroundColor = .lightGray //.purple just prior to see if rendering this cell in AppsController..
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0))
        
        addSubview(horizontalController.view)
       // horizontalController.view.backgroundColor = .blue
        horizontalController.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
