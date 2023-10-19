//
//  NiblessTableViewCell.swift
//  WForecastUI
//
//  Created by 小苹果 on 2023/10/19.
//

import UIKit.UITableViewCell
import UIKit.UITableViewHeaderFooterView

open class NiblessTableViewCell: UITableViewCell {
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    @available(*, unavailable, message: "Instantiating this view from a nib is not supported.")
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Instantiating this view from a nib is not supported.")
    }
    
}

open class NiblessTableViewHeaderFooterView: UITableViewHeaderFooterView {
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    @available(*, unavailable, message: "Instantiating this view from a nib is not supported.")
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Instantiating this view from a nib is not supported.")
    }
    
}
