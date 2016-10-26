//
//  ObjectCollectionViewCell.swift
//  BreakJSQ
//
//  Created by Jordan Zucker on 10/25/16.
//  Copyright © 2016 Stanera. All rights reserved.
//

import UIKit

class ObjectCollectionViewCell: UICollectionViewCell {
    
    internal let titleLabel: UILabel
    internal let stackView: UIStackView
    
    override init(frame: CGRect) {
        let title = UILabel(frame: .zero)
        title.textAlignment = .center
        self.stackView = UIStackView(arrangedSubviews: [title])
        self.titleLabel = title
        super.init(frame: frame)
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 1
        titleLabel.textColor = .black
        contentView.addSubview(self.stackView)
        stackView.forceAutoLayout()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        let views = [
            "stackView": stackView
        ]
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[stackView]|", options: [], metrics: nil, views: views)
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[stackView]|", options: [], metrics: nil, views: views)
        NSLayoutConstraint.activate(verticalConstraints)
        NSLayoutConstraint.activate(horizontalConstraints)
        contentView.setNeedsLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(title: String) {
        titleLabel.text = title
        contentView.setNeedsLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        isSelected = false
        isHighlighted = false
        titleLabel.textColor = .black
        contentView.setNeedsLayout()
    }
    
    func update(object: TestObject?) {
        guard let actualObject = object else {
            return
        }
        update(title: actualObject.title!)
    }
    
    class var size: CGSize {
        return CGSize(width: 75.0, height: 75.0)
    }
    
    class func size(collectionViewSize: CGSize) -> CGSize {
        return CGSize(width: 75.0, height: 75.0)
    }
}
