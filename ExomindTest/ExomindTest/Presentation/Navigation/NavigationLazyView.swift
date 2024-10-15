//
//  NavigationLazyView.swift
//  ExomindTest
//
//  Created by Lucas CHEN on 15/10/2024.
//

import SwiftUI

/// Using a Lazy View to avoid that NavigationLink immediately loads the view

/**
    # Example Use-case
 
    - NavigationLink(destination: NavigationLazyView(DetailView(data: DataModel))) { Text("Item") }
 */

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
