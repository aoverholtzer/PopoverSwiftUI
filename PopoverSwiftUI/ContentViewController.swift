//
//  ContentViewController.swift
//  PopoverSwiftUI
//
//  Created by Adam Overholtzer on 5/25/20.
//  Copyright © 2020 Overdesigned, LLC. All rights reserved.
//

import UIKit
import SwiftUI

class ContentViewController: UIHostingController<AnyView> {
        
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        // need to call super.init(rootView:) with _something_ before we create closures
        // that refer to self... maybe there is a better way to do this?
        super.init(rootView: AnyView(EmptyView()))
        
        // popover presentation closure — takes the given content, wraps it in
        // a UIHostingController, and then presents it from the given frame
        let popoverHandler:ContentView.PopoverPresenter = { (frame, content) in
            let hostingViewController = UIHostingController(rootView: content)
            
            // force popover style and set sourceView
            hostingViewController.modalPresentationStyle = .popover
            hostingViewController.popoverPresentationController?.delegate = self
            hostingViewController.popoverPresentationController?.sourceView = self.view
            hostingViewController.popoverPresentationController?.sourceRect = frame
            
            // need to nil out the UIHostingController's background or popover will be opaque
            hostingViewController.view.backgroundColor = nil
            
            // need to manually set preferredContentSize for the popover
            // but thankfully we can use sizeThatFits(:) to force the SwiftUI view to size itself
            let popoverMaxSize = CGSize(width: 250, height: 500)
            hostingViewController.preferredContentSize = hostingViewController.sizeThatFits(in: popoverMaxSize)
            
            // present the popover
            self.present(hostingViewController, animated: true, completion: nil)
        }
        
        // create ContentView with our closures and set as rootView
        let contentView = ContentView(showPopover: popoverHandler)
        self.rootView = AnyView(contentView)
    }
}

extension ContentViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none // this is what forces popovers on iPhone
    }
}
