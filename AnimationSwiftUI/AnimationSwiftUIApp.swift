//
//  AnimationSwiftUIApp.swift
//  AnimationSwiftUI
//
//  Created by Akash on 15/10/21.
//

import SwiftUI

@main
struct AnimationSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ProgressIndicator1(degrees: Binding.constant(0.0), animate: Binding.constant(false))
        }
    }
}
