//
//  SearchResultCell.swift
//  AppStore
//
//  Created by Donald McAllister on 5/10/19.
//  Copyright © 2019 Donald McAllister. All rights reserved.
//

// 1- init
// 2- imageView, nameLabel, getButton definitions..
// 3- inside init: addSubview() and utilize a stack view..
// 4- stackView.translateAutoresizingMaskIntoConstraints = false
// 5- constraints
// 6- manipulate stackView subviews to get desired look
// *rchange background color green to yellow
// *getButton section add:  button.backgroundColor = UIColor(white: 0.95, alpha: 1)
// *inside imageView add: iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
// *button.widthAnchor.constraint(equalToConstant: 80).isActive = true
// copy and paste nameLabel...adding categoryLabel and ratingsLabel..
// head back to stack view.. labelStacksView =
// labelStackView.axis = .vertical --- aligning this vertically and now replae labelView in the other stack with this..
// stackView = imageView, labelStackView, getButton --- our horizontal view..
// now need to adjust alignment of stack view to get desired look..
// stackView.alignment -- the alignment of the arranged subviews perpendicular to the stack view's axis =.center
// give imageView a height anchor cosntraint since it disappeared.. and change cornerRadius.. 

import UIKit

class SearchResultCell: UICollectionViewCell {
    
    let appIconImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        iv.layer.cornerRadius = 12
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "APP NAME"
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos & Video"
        return label
    }()
    
    let ratingsLabel: UILabel = {
        let label = UILabel()
        label.text = "9.26M"
        return label
    }()
    
    let getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.layer.cornerRadius = 16
        return button
    }()
    
    //three image views:
    
    //can't declare as let, need to set as lazy var to have access to instance variables and functions like just created below in order to compile:
    lazy var screenshot1ImageView = self.createScreenshotImageView()
    lazy var screenshot2ImageView = self.createScreenshotImageView()
    lazy var screenshot3ImageView = self.createScreenshotImageView()

    func createScreenshotImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        return imageView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       // backgroundColor = .yellow
        
        //we can reduce this code since vertical alignment stack views very common with use of new file: Vertical Stack View
        let labelsStackView = VerticalStackView(arrangedSubviews: [
            nameLabel, categoryLabel, ratingsLabel])
        
        //rename CMD+CTRL+E to infoStackView:
        let infoTopStackView = UIStackView(arrangedSubviews: [
            appIconImageView, labelsStackView, getButton
            ])
        infoTopStackView.spacing = 12
        infoTopStackView.alignment = .center //important to get labels vertically aligned correctly..
        
        let screenshotStackView = UIStackView(arrangedSubviews: [screenshot1ImageView, screenshot2ImageView, screenshot3ImageView])
        screenshotStackView.spacing = 12 //compile here won't get the three snapshots...need distrubution property set:
        screenshotStackView.distribution = .fillEqually
        //now go back to appsearch controller to extend the cells height: sizeForItemAt
        
    
        //overllStackView was created prior to the screenshot stack view
        let overallStackView = VerticalStackView(arrangedSubviews: [infoTopStackView, screenshotStackView], spacing: 16)

        
        addSubview(overallStackView)
        overallStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
