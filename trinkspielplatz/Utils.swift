//
//  Utils.swift
//  trinkspielplatz
//
//  Created by Charbel Chougourou on 04.05.23.
//

import Foundation
import SwiftUI
import Combine


import Foundation

class MyClass {
    private var timer: Timer?

    func startTask() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5 * 60.0, repeats: false) { [weak self] timer in
            print("halbe Minute")
            self?.timer = nil
        }
    }

    func stopTask() {
        print("Task gestopppt")
        timer?.invalidate()
        timer = nil
    }
}

class Gui {
    let cornerRadius25: CGFloat = 25.0
    let cornerRadius15: CGFloat = 15.0
    let navLinkHeight: CGFloat = 80.0
}


extension Collection where Indices.Iterator.Element == Index {
   public subscript(safe index: Index) -> Iterator.Element? {
     return (startIndex <= index && index < endIndex) ? self[index] : nil
   }
}


extension View {
    func hidden(_ condition: Bool) -> some View {
        condition ? AnyView(self.hidden()) : AnyView(self)
    }
    
//    func hidden(_ binding: Binding<Bool>) -> some View {
//        self.hidden(binding.wrappedValue)
//    }
}

func limitText(_ stringvar: inout String, _ limit: Int) {
    if (stringvar.count > limit) {
        stringvar = String(stringvar.prefix(limit))
    }
}

struct ThreeD: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack(){
            let offset: CGFloat = 5
            
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color("tealdark"))
                .offset(y: offset)
                
            
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color("teal"))
                .offset(y: configuration.isPressed ? offset : 0)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color("bluegray"), lineWidth: 1)
                        .offset(y: configuration.isPressed ? offset : 0)
                )
            
            configuration.label
                .foregroundColor(.black)
                .padding(.all, 5.0)
                .offset(y: configuration.isPressed ? offset : 0)
            
        }
        .compositingGroup()
        .shadow(radius: 5, y: 4)
    }
}

struct ThreeD180: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack(){
            let offset: CGFloat = -5
            
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color("tealdark"))
                .offset(y: offset)
                
            
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color("teal"))
                .offset(y: configuration.isPressed ? offset : 0)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color("bluegray"), lineWidth: 1)
                        .offset(y: configuration.isPressed ? offset : 0)
                )
            
            configuration.label
                .foregroundColor(.black)
                .padding(.all, 5.0)
                .offset(y: configuration.isPressed ? offset : 0)
            
        }
        .compositingGroup()
        .shadow(radius: 5, y: 4)
    }
}

struct ThreeDLight: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack(){
            let offset: CGFloat = 5
            
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color("teallight"))
                .offset(y: offset)
                
            
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color("teal"))
                .offset(y: configuration.isPressed ? offset : 0)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color("bluegray"), lineWidth: 1)
                        .offset(y: configuration.isPressed ? offset : 0)
                )
            
            configuration.label
                .foregroundColor(.black)
                .padding(.all, 5.0)
                .offset(y: configuration.isPressed ? offset : 0)
            
        }
        .compositingGroup()
        .shadow(radius: 5, y: 4)
    }
}

struct ThreeDRed: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack(){
            let offset: CGFloat = 5
            
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color("reddark"))
                .offset(y: offset)
                
            
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color("red"))
                .offset(y: configuration.isPressed ? offset : 0)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color("bluegray"), lineWidth: 1)
                        .offset(y: configuration.isPressed ? offset : 0)
                )
            
            configuration.label
                .foregroundColor(.white)
                .padding(.all, 5.0)
                .offset(y: configuration.isPressed ? offset : 0)
            
        }
        .compositingGroup()
        .shadow(radius: 5, y: 4)
    }
}

struct ThreeDGreen: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack(){
            let offset: CGFloat = 5
            
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color("greendark"))
                .offset(y: offset)
                
            
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color("green"))
                .offset(y: configuration.isPressed ? offset : 0)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color("bluegray"), lineWidth: 1)
                        .offset(y: configuration.isPressed ? offset : 0)
                )
            
            configuration.label
                .foregroundColor(.black)
                .padding(.all, 5.0)
                .offset(y: configuration.isPressed ? offset : 0)
            
        }
        .compositingGroup()
        .shadow(radius: 5, y: 4)
    }
}

struct ThreeDBlueGray: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack(){
            let offset: CGFloat = 5
            
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color("gray"))
                .offset(y: offset)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color("bluegray"), lineWidth: 1)
                        .offset(y: offset)
                )
                
            
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color("bluegray"))
                .offset(y: configuration.isPressed ? offset : 0)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color("bluegray"), lineWidth: 1)
                        .offset(y: configuration.isPressed ? offset : 0)
                )
            
            configuration.label
                .foregroundColor(.white)
                .padding(.all, 5.0)
                .offset(y: configuration.isPressed ? offset : 0)
            
        }
        .compositingGroup()
        .shadow(radius: 5, y: 4)
    }
}

struct ThreeDWhite: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack(){
            let offset: CGFloat = 5
            
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color("gray"))
                .offset(x: offset, y: offset)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color("bluegray"), lineWidth: 1)
                        .offset(x: offset, y: offset)
                )
                
            
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color.white)
                .offset(y: configuration.isPressed ? offset : 0)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color("bluegray"), lineWidth: 1)
                )
            
//            configuration.label
//                .foregroundColor(.black)
//                .padding(.all, 5.0)
            
        }
        .compositingGroup()
        .shadow(radius: 5, y: 4)
    }
}

struct BierButton3D: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack(){
            let offset: CGFloat = 5
            
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color("tealdark"))
                .offset(y: offset)
                
            
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color("teal"))
                .offset(y: configuration.isPressed ? offset : 0)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color("bluegray"), lineWidth: 1)
                        .offset(y: configuration.isPressed ? offset : 0)
                )

                Image("biericon")
                    .resizable()
                    .padding(.all, 5.0)
            
//            configuration.label
//                .foregroundColor(.black)
//                .padding(.all, 5.0)
//                .offset(y: configuration.isPressed ? offset : 0)
            
        }
        .compositingGroup()
        .shadow(radius: 5, y: 4)
    }
}

struct ThreeDButton_Previews: PreviewProvider {
    static var previews: some View {
        
            Button("Button") {
            }
            .frame(width: 300, height: 500)
            .buttonStyle(ThreeDBlueGray())
        
    }
}

