//
//  TrailingIconLabelStyle.swift
//  Scrumdinger (iOS)
//
//  Created by Alessa De Leon Chavez on 2022-04-03.
//

import SwiftUI

struct TrailingIconLabelStyle: LabelStyle{
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}
extension LabelStyle where Self == TrailingIconLabelStyle {
    static var trailingIcon: Self { Self() }
}
