//
//  ContentView.swift
//  swiftui-tutrial
//
//  Created by haayzaki on 2021/10/18.
//

import SwiftUI

struct ContentView: View {
    
    @State var buttonText = "Button"
    @State var isTapped = false
    @State var imageFile = "dog1"
    
    @State private var userName = ""
    @State private var isEditing = false
    
    var body: some View {
        VStack {
            Text("Hello, world!!!!!")
                .font(.largeTitle)
                .foregroundColor(Color.green)
            .padding()
            
            Button(
                action: {
                    isTapped.toggle()
                    if (isTapped) {
                        buttonText = "Tapped"
                        imageFile = "dog2"
                    } else {
                        buttonText = "Button"
                        imageFile = "dog1"
                    }
                }, label: {
                    Text(buttonText).font(.largeTitle).padding(.all)
                    
                }
            ).overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
            Image(imageFile)
                .resizable()
                .scaledToFill()
                .frame(width: 150.0, height: 150.0)

            TextField(
                "User name (email)",
                text: $userName
            ) {
                isEditing in
                    self.isEditing = isEditing
            } onCommit: {
                // validate(name)
            }
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .border(Color(UIColor.separator))
            Text("Hello \(userName)")
                .foregroundColor(isEditing ? .red : .blue)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
