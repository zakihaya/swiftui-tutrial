//
//  SwiftUIView.swift
//  swiftui-tutrial
//
//  Created by haayzaki on 2021/10/22.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        Image("sample_image")
            .clipShape(Circle())
            .overlay(Circle()
                .stroke(Color.gray, lineWidth: 10)
                .shadow(radius: 20)
            )
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
