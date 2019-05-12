//
//  VerticalStackView.swift
//  AppStore
//
//  Created by Donald McAllister on 5/12/19.
//  Copyright © 2019 Donald McAllister. All rights reserved.
//

import UIKit

class VerticalStackView: UIStackView {
    
    init(arrangedSubviews: [UIView], spacing: CGFloat = 0) {
        super.init(frame: .zero) //should be ignored since using auto layout anyways
        
        //for arranged subviews:
        arrangedSubviews.forEach({addArrangedSubview($0)})
        
        self.spacing = spacing 
        self.axis = .vertical
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
