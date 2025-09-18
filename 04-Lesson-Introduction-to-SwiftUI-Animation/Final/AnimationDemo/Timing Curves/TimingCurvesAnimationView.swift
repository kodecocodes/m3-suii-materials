/// Copyright (c) 2024 Kodeco Inc.
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

struct TimingCurvesAnimationView: View {
    @State private var move = false
    @State private var scale = false
    @State private var rotate = false

    var body: some View {
        VStack(spacing: 40) {
            // EaseIn Animation
            Circle()
                .fill(Color.blue)
                .frame(width: 100, height: 100)
                .offset(x: move ? 150 : -150)
                .animation(.easeIn(duration: 2), value: move)
                .onTapGesture {
                    move.toggle()
                }

            // EaseOut Animation
            Circle()
                .fill(Color.red)
                .frame(width: 100, height: 100)
                .offset(x: move ? 150 : -150)
                .animation(.easeOut(duration: 2), value: move)
                .onTapGesture {
                    move.toggle()
                }

            // EaseInOut Animation
            Circle()
                .fill(Color.green)
                .frame(width: 100, height: 100)
                .offset(x: move ? 150 : -150)
                .animation(.easeInOut(duration: 2), value: move)
                .onTapGesture {
                    move.toggle()
                }

            // Linear Animation
            Circle()
                .fill(Color.orange)
                .frame(width: 100, height: 100)
                .offset(x: move ? 150 : -150)
                .animation(.linear(duration: 2), value: move)
                .onTapGesture {
                    move.toggle()
                }

            // Custom Timing Curve Animation
            Circle()
                .fill(Color.purple)
                .frame(width: 100, height: 100)
                .offset(x: move ? 150 : -150)
                .animation(
                    Animation.timingCurve(0.68, -0.55, 0.27, 1.55, duration: 2),
                    value: move
                )
                .onTapGesture {
                    move.toggle()
                }

            // Combined Timing Curves
            Circle()
                .fill(Color.blue)
                .frame(width: 100, height: 100)
                .scaleEffect(scale ? 1.5 : 1.0)
                .rotationEffect(.degrees(rotate ? 360 : 0))
                .animation(.easeInOut(duration: 2), value: scale)
                .animation(.easeIn(duration: 1), value: rotate)
                .onTapGesture {
                    scale.toggle()
                    rotate.toggle()
                }
        }
    }
}

#Preview {
    TimingCurvesAnimationView()
}
