//
//  MeasuredButton.swift
//  PopoverSwiftUI
//
//  Created by Adam Overholtzer on 5/25/20.
//  Copyright © 2020 Overdesigned, LLC. All rights reserved.
//

import SwiftUI

struct MeasuredButton<Content: View>: View {
    typealias Action = (CGRect) -> Void
    @State private var frame: CGRect = .zero
    let callback: Action
    let content: Content
    
    init(action:@escaping Action, @ViewBuilder content: () -> Content) {
        self.callback = action
        self.content = content()
    }
    
    var body: some View {
        return Button(action: {
            self.callback(self.frame)
        }) {
            content
        }
        .background(
            GeometryReader { geo in
                Color.clear
                    .preference(key: FramePreferenceKey.self,
                                value: geo.frame(in: CoordinateSpace.global))
            }
        )
        .onPreferenceChange(FramePreferenceKey.self) { value in
            self.frame = value
        }
    }
}

struct FramePreferenceKey: PreferenceKey {
    typealias Value = CGRect
    static var defaultValue: Value = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
