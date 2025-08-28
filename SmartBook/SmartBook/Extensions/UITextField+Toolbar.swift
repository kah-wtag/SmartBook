//
//  UITextField+Toolbar.swift
//  WelldevTraining CalendarSchedule
//
//  Created by Md. Kamrul Hasan on 28/8/25.
//

import UIKit

extension UITextField {

    typealias ToolbarItem = (title: String, target: Any, selector: Selector)

    func addToolbar(leadingItems: [UIBarButtonItem] = [], trailingItems: [UIBarButtonItem] = []) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        var items = leadingItems
        items.append(flexibleSpace)
        items.append(contentsOf: trailingItems)
        
        toolbar.setItems(items, animated: false)
        
        self.inputAccessoryView = toolbar
    }

}
