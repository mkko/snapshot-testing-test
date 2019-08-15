//
//  ImageLabel.swift
//  SnapshotExample
//
//  Created by Mikko Välimäki on 2019-08-15.
//  Copyright © 2019 Mikko Välimäki. All rights reserved.
//

import UIKit
import Stevia

@IBDesignable
public class ImageLabel: UIView {

    let label = UILabel()
    let emoji = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override public func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    func setup() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.cornerRadius = 8

        emoji.text = "🤷‍♂️"
        label.text = "Default"

        sv(
            label,
            emoji
        )

        layout(
            4,
            |-emoji-8-label-|,
            4
        )
    }
}

