//
//  ContentView.swift
//  PopoverSwiftUI
//
//  Created by Adam Overholtzer on 5/25/20.
//  Copyright © 2020 Overdesigned, LLC. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    typealias PopoverPresenter = (CGRect, AnyView) -> Void
    
    var showPopover: PopoverPresenter?
    
    var body: some View {
        VStack {
            Spacer()
            
            MeasuredButton(action: { frame in
                let view = PopoverView(text: "This popover has determined its size based on its content and appears to be presented from a SwiftUI button.")
                self.showPopover?(frame, AnyView(view))
            }) {
                Text("Show Popover")
            }
            
        }.padding()
    }
}

struct PopoverView: View {
    @State var text:String
    
    var body: some View {
        Text(text)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
