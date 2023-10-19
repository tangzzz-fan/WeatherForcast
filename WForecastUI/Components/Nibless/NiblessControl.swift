//
//  NiblessControl.swift
//  WForecastUI
//
//  Created by 小苹果 on 2023/10/19.
//

import UIKit.UIControl

open class NiblessControl: UIControl {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable, message: "Instantiating this view from a nib is not supported.")
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Instantiating this view from a nib is not supported.")
    }
    
}
