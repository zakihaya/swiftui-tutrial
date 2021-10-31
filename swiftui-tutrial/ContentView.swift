//
//  ContentView.swift
//  swiftui-tutrial
//
//  Created by haayzaki on 2021/10/18.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Text("Hello World")
                    .padding()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: PreviousView()){
                        Text("Previous")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: NextView()){
                        Text("Next")
                    }
                }
            }
            
//            NavigationLink(destination: SecondView(info: "This is param")) { Text("Move to SecondView") }
//            .navigationTitle("Main Screen")
//            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct PreviousView: View {
    var body: some View {
        VStack{
        }
        .navigationTitle("PreviousView")
    }
}
 
struct NextView: View {
    var body: some View {
        VStack{
        }
        .navigationTitle("NextView")
    }
}

struct SecondView: View {
    @State var buttonText = "Button"
    @State var isTapped = false
    @State var imageFile = "dog1"
    
    @State private var userName = ""
    @State private var isEditing = false
    
    let info: String

    var body: some View {
        VStack {
            Text("SecondView")
                .padding()
            
            Text(info)
                .padding()

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
        .navigationTitle("Second Screen")
        .navigationBarTitleDisplayMode(.automatic)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
