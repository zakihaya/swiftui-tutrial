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
                    NavigationLink(destination: DrugGestureView()) { Text("Move to DrugGestureView")
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    NavigationLink(destination: MagnificationGestueView()) { Text("Move to MagnificationGestueView")
                    }
                    NavigationLink(destination: RotationGestureView()) { Text("Move to RotationGestureView")
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    NavigationLink(destination: StacksView()) { Text("Move to StacksView")
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    NavigationLink(destination: LazyStacksView()) { Text("Move to LazyStacksView")
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

struct LazyStacksView: View {
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .trailing) {
                ForEach(1...1000000000000, id: \.self) {
                    Text("Row \($0)")
                }
            }
        }
        // ????????????????????????????????????Text?????????render??????????????????????????????
        // ScrollView(.vertical) {
        //     LazyVStack {
        //         ForEach(1...1000000000000, id: \.self) {
        //             Text("Row \($0)")
        //         }
        //     }
        // }
    }
}

struct StacksView: View {
    var body: some View {
        VStack {
            Text("Hello world")
            HStack {
                Text("Item1")
                Text("Item2")
            }
            ZStack{
                Circle()
                    .frame(width: 300, height: 100, alignment: .center)
                    .foregroundColor(.orange)
                Text("on the circle")
                    .padding()
            }
        }
    }
}

struct RotationGestureView: View {
    @State var angle = Angle(degrees: 45.0)
    
    var rotation: some Gesture {
        RotationGesture()
            .onChanged { angle in
                self.angle = angle
            }
    }
    
    var body: some View {
        Rectangle()
            .frame(width: 200, height: 300, alignment: .center)
            .rotationEffect(angle)
            .gesture(rotation)
    }
}

struct MagnificationGestueView: View {
    @GestureState var magnifyBy = CGFloat(1.0)
    @State var imageScaleValue: CGFloat = 1.0
    
    var magnification: some Gesture {
        MagnificationGesture()
            .updating($magnifyBy) { currentState, gestureState, transaction in
                gestureState = currentState
            }
    }
    
    var body: some View {
        Circle()
            .frame(width: 100 * magnifyBy, height: 100 * magnifyBy, alignment: .center)
            .gesture(magnification)
            .padding()
        Image("dog1")
            .resizable()
            .scaleEffect(imageScaleValue)
            .frame(width: 200, height: 200)
            .gesture(MagnificationGesture()
                        .onChanged( { value in self.imageScaleValue = value } ))
            .padding()
        Button(action: {
            self.imageScaleValue += 0.2
        }) {
            Text("Button")
        }
        .padding()
    }
}

struct DrugGestureView: View {
    @State var position: CGSize = CGSize(width: 200, height: 300)
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                self.position = CGSize(
                    width: value.startLocation.x + value.translation.width,
                    height: value.startLocation.y + value.translation.height
                )
            }
            .onEnded { value in
                self.position = CGSize(
                    width: value.startLocation.x + value.translation.width,
                    height: value.startLocation.y + value.translation.height
                )
            }
    }

    var body: some View {
        VStack {
            Text("x: \(self.position.width)")
            Text("y: \(self.position.height)")
            Image("dog1")
                .resizable()
                .scaledToFill()
                .frame(width: 100.0, height: 100.0)
                .position(x: position.width, y: position.height)
                .gesture(drag)
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
