//
//  UITableView+Extensions.swift
//  WForecastUI
//
//  Created by 小苹果 on 2023/10/19.
//

import UIKit

public extension UITableViewCell {
    
    static var defaultReuseIdentifier: String {
        return description()
    }
    
}

public extension UITableViewHeaderFooterView {
    
    static var defaultReuseIdentifier: String {
        return description()
    }
    
    var backgroundViewColor: UIColor? {
        get { backgroundView?.backgroundColor }
        set {
            if backgroundView == nil {
                backgroundView = UIView()
            }
            backgroundView?.backgroundColor = newValue
        }
    }
}

public extension UITableView {
    
    // MARK: - Register cells & views
    
    func register<T: UITableViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.defaultReuseIdentifier)
    }

    func register<T: UITableViewCell>(_ cellClasses: [T.Type]) {
        cellClasses.forEach { register($0) }
    }

    func registerHeaderView<T: UITableViewHeaderFooterView>(_ aClass: T.Type) {
        register(aClass, forHeaderFooterViewReuseIdentifier: aClass.defaultReuseIdentifier)
    }

    func registerHeaderViews<T: UITableViewHeaderFooterView>(_ viewClasses: [T.Type]) {
        viewClasses.forEach { registerHeaderView($0) }
    }

    func registerFooterView<T: UITableViewHeaderFooterView>(_ aClass: T.Type) {
        register(aClass, forHeaderFooterViewReuseIdentifier: aClass.defaultReuseIdentifier)
    }

    func registerFooterViews<T: UITableViewHeaderFooterView>(_ viewClasses: [T.Type]) {
        viewClasses.forEach { registerFooterView($0) }
    }
    
    // MARK: - Dequeue cells & views
    
    func dequeueReusableCell<T: UITableViewCell>(ofType cellType: T.Type,
                                                 for indexPath: IndexPath) -> T {
        guard
            let cell = dequeueReusableCell(withIdentifier: cellType.defaultReuseIdentifier,
                                           for: indexPath) as? T
            else { fatalError("Can't dequeue cell of type: \(cellType)") }
        return cell
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(ofType viewType: T.Type) -> T {
        guard
            let view = dequeueReusableHeaderFooterView(withIdentifier: viewType.defaultReuseIdentifier) as? T
            else { fatalError("Can't dequeue headerFooter of type: \(viewType)") }
        return view
    }
    
}

public extension UITableView {
    func setAndAutoLayoutTableHeaderView(_ headerView: UIView) {
        DispatchQueue.main.async {
            self.tableHeaderView = headerView
            headerView.setNeedsLayout()
            headerView.layoutIfNeeded()
            headerView.frame.size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
            self.tableHeaderView = headerView
        }
    }
}

/// Chat related
public extension UITableView {

    func totalRows() -> Int {
        var index = 0
        var rowCount = 0
        while index < self.numberOfSections {
            rowCount += self.numberOfRows(inSection: index)
            index += 1
        }
        return rowCount
    }
    
    var lastIndexPath: IndexPath? {
        if (self.totalRows() - 1) > 0 {
            return IndexPath(row: self.totalRows() - 1, section: 0)
        } else {
            return nil
        }
    }
    
    func scrollBottomWithoutFlashing() {
        guard let indexPath = self.lastIndexPath else {
            return
        }
        UIView.setAnimationsEnabled(false)
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        self.scrollToRow(at: indexPath, at: .bottom, animated: false)
        CATransaction.commit()
        UIView.setAnimationsEnabled(true)
    }
    
    func scrollBottomToLastRow(_ animated: Bool = false) {
        guard let indexPath = self.lastIndexPath else {
            return
        }
        self.scrollToRow(at: indexPath, at: .bottom, animated: animated)
    }
    
    func scrollToBottom(animated: Bool) {
        let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height)
        self.setContentOffset(bottomOffset, animated: animated)
    }
    
    var isContentInsetBottomZero: Bool {
        return self.contentInset.bottom == 0
    }
    
    func resetContentInsetAndScrollIndicatorInsets() {
        self.contentInset = UIEdgeInsets.zero
        self.scrollIndicatorInsets = UIEdgeInsets.zero
    }
}
