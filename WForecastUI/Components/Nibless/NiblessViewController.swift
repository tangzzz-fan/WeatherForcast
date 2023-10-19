//
//  NiblessViewController.swift
//  WForecastUI
//
//  Created by 小苹果 on 2023/10/19.
//

import UIKit.UIViewController

open class NiblessViewController: UIViewController {
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable, message: "Instantiating this view controller from a nib is not supported.")
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable, message: "Instantiating this view controller from a nib is not supported.")
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Instantiating this view controller from a nib is not supported.")
    }
    
}
