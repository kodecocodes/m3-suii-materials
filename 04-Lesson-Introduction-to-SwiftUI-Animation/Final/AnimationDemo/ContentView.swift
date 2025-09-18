//
//  ContentView.swift
//  AnimationDemo
//
//  Created by Eric Jenkinson on 6/30/24.
//

import SwiftUI

struct ContentView: View {
    @State private var scale: CGFloat = 1.0

    var body: some View {
        VStack {
            Text("Tap Me!")
                .font(.largeTitle)
                .scaleEffect(scale)
                .onTapGesture {
                    scale += 1.0 // Implicit animation applied automatically
                }
        }
        .animation(.easeInOut(duration: 1), value: scale) // Define the animation
    }
}


#Preview {
    ContentView()
}
