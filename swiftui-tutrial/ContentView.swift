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
                VStack {
                    NavigationLink(destination: SecondView(info: "This is param")) { Text("Move to SecondView")
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    NavigationLink(destination: GestureRecognizeView()) { Text("Move to GestureRecognizeView")
                    }
                    .navigationBarTitleDisplayMode(.inline)
                }
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
            .navigationTitle("Main Screen")
        }
    }
}

struct GestureRecognizeView: View {
    @State var flg = false
    @State var flg2 = false
    @State var flgLongPress = false
    
    var body: some View {
        VStack {
            Text("GestureRecognizeView")
                .padding()
            textElement(tapText: "tap me", targetFlg: flg)
                .onTapGesture {
                    flg.toggle()
                }
            textElement(tapText: "tap me 2 times", targetFlg: flg2)
                .onTapGesture(count: 2) {
                    flg2.toggle()
                }
            textElement(tapText: "long tap", targetFlg: flgLongPress)
                .onLongPressGesture(minimumDuration: 2,
                                    maximumDistance: 1000,
                                    pressing: { pressed in
                    print("pressed: \(pressed)")
                }) {
                    flgLongPress.toggle()
                }
            
        }
        .navigationTitle("GestureRecognizeView")
    }
    
    func textElement(tapText: String, targetFlg: Bool) -> Text {
        if (targetFlg) {
            return Text("on")
        }
        return Text(tapText)
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
