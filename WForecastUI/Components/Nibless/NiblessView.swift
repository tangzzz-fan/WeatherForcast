//
//  NiblessView.swift
//  WForecastUI
//
//  Created by 小苹果 on 2023/10/19.
//

import UIKit.UIView

open class NiblessView: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable, message: "Instantiating this view from a nib is not supported.")
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Instantiating this view from a nib is not supported.")
    }
    
}
