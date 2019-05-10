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
    
    let imageView: UIImageView = {
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
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .yellow
        
        let labelsStackView = UIStackView(arrangedSubviews: [
            nameLabel, categoryLabel, ratingsLabel
            ])
        labelsStackView.axis = .vertical
        
        let stackView = UIStackView(arrangedSubviews: [
            imageView, labelsStackView, getButton
            ])
        stackView.spacing = 12
        stackView.alignment = .center
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
