//
//  ContentView.swift
//  AnimationSwiftUI
//
//  Created by Akash on 15/10/21.
//

import SwiftUI

struct SimpleAnimationContentView: View {
    @State private var scaleFactor: CGFloat = 1
    
    var body: some View {
        VStack{
            ScrollView{
                buttonWithOpacity
                spinnerButton
                rotation3DEffect
                Button(action: {
                }) {
                    Text("Confirm")
                        .bold()
                }
                .onAppear(perform: {
                    self.scaleFactor = 2.5
                })
                .padding(40)
                .background(Color.green)
                .foregroundColor(.white)
                .clipShape(Circle())
                .scaleEffect(scaleFactor)
                //.animation(.default)
                //            .animation(.easeInOut(duration: 2))
                //            .animation(.easeOut(duration: 2))
                //            .animation(Animation.easeInOut(duration: 2) .repeatCount(2, autoreverses: true))
                .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true))
            }
        }
    }
    
    @State private var opacity:Double = 1.0
    var buttonWithOpacity: some View {
        Button(action: {
        })
        {
            Text("Click Me")
                .fontWeight(.bold)
                .font(.caption)
                .foregroundColor(.blue)
                .padding()
                .background(Color.yellow)
                .overlay(
                    Rectangle()
                        .stroke(Color.blue, lineWidth: 5)
                )
                .opacity(opacity)
                .onAppear() {
                    let baseAnimation =
                    Animation.linear(duration: 1)
                    withAnimation (
                        baseAnimation.repeatForever(
                            autoreverses: true))
                    {
                        self.opacity = 0.2
                    }
                }
        }
    }
    
    
    
    @State private var degrees = 0.0
    var spinnerButton: some View {
        VStack{
            Image("apple-icon-120x120")
                .resizable()
                .frame(width: 400.0, height: 400.0)
                .rotationEffect(.degrees(degrees))
            
            Button("Spin") {
                let d = Double.random(in: 720...7200)
                let baseAnimation =
                Animation.easeInOut(duration: d / 360)
                withAnimation (baseAnimation) {
                    self.degrees += d
                }
            }
        }
    }
    
    @State private var rotation3DDegrees = 45.0
    var rotation3DEffect: some View {
        Text("SwiftUI for Dummies")
            .font(.largeTitle)
            .rotation3DEffect(.degrees(rotation3DDegrees),
                              axis: (x: 1, y: 1, z: 1))
    }
    
    
    @Binding var progressIndidegrees: Double
    @Binding var animate:Bool
    var ProgressIndicator1: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(Color.green)
            
            Circle()
                .trim(from: 0, to: 0.001)
                .stroke(style: StrokeStyle(
                    lineWidth: 20.0,
                    lineCap: .round,
                    lineJoin: .round))
                .foregroundColor(Color.green)
                .rotationEffect(Angle(degrees: -90))
                .rotationEffect(Angle(degrees:
                                        self.progressIndidegrees))
                .animation(
                    self.animate ?
                    Animation.linear(
                        duration: 2)
                        .repeatForever(
                            autoreverses: false) :
                        Animation.default
                )
        }
    }
    
}

struct ProgressIndicator1: View {
    @Binding var degrees: Double
    @Binding var animate:Bool
    @State var proportion:CGFloat = 0.0
    @State var buttonCaption2 = "Start"
    @State var startProgressIndicator2 = false
    
    var body: some View {
        VStack {
                        ProgressIndicator2(trim: self.$proportion)
                            .frame(width: 100.0, height: 100.0)
                            .padding(40.0)
            HStack{
                Button(action: {
                    self.proportion += 0.1
                    self.proportion =
                    min(self.proportion,1)
                })
                {
                    Text("+")
                        .padding()
                        .border(Color.black)
                }
                Button(action: {
                    self.proportion -= 0.1
                    self.proportion =
                    max(self.proportion,0)
                })
                {
                    Text("-")
                        .padding()
                        .border(Color.black)
                }
            }
            
            Button(action: {
                switch self.buttonCaption2 {
                case "Start":
                    self.startProgressIndicator2 =
                    true
                case "Stop" :
                    self.startProgressIndicator2 =
                    false
                default: break
                }
                self.buttonCaption2 =
                self.buttonCaption2 == "Start"
                ? "Stop" : "Start"
                
                Timer.scheduledTimer(
                    withTimeInterval: 0.1,
                    repeats: true) {
                        timer in
                        self.proportion += 0.01
                        if self.proportion>1 {
                            self.proportion = 0
                        }
                        if !self.startProgressIndicator2 {
                            timer.invalidate()
                        }
                    }
            })
            {
                Text(self.buttonCaption2)
            }
        }
    }
}

struct ProgressIndicator2: View {
    @Binding var trim: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(Color.green)
            
            Circle()
                .trim(from: 0, to: self.trim)
                .stroke(style: StrokeStyle(
                    lineWidth: 20.0,
                    lineCap: .round,
                    lineJoin: .round))
                .foregroundColor(Color.green)
                .rotationEffect(Angle(degrees: -90))
            
            Text(String(format: "%.0f %%",
                        min(self.trim, 1.0) * 100.0))
                .font(.headline)
                .bold()
        }
    }
}
