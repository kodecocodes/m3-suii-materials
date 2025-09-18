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

struct KeyframeAnimatorDemo: View {
    // State to trigger the animation
    @State private var trigger = false

    var body: some View {
        VStack(spacing: 50) {
            // The KeyframeAnimator wraps the view you want to animate.
            KeyframeAnimator(
                initialValue: AnimationValues(), // Starting values for all animated properties
                trigger: trigger // The animation runs when this value changes
            ) { value in 
                // The view to be animated is returned from this closure.
                Text("🔔")
                    .font(.system(size: 100))
                    .rotationEffect(value.rotation) // Apply rotation
                    .scaleEffect(value.scale)       // Apply scale
                    .offset(x: value.horizontalOffset) // Apply horizontal offset
            } keyframes: { _ in
                // Define the sequence of animations (keyframes) here.
                // The '_' ignores the initialValue passed into this closure.
                
                // 1. Animate Rotation (using Spring)
                KeyframeTrack(\.rotation) {
                    SpringKeyframe(Angle.degrees(0), duration: 0.1)
                    SpringKeyframe(Angle.degrees(-30), duration: 0.2)
                    SpringKeyframe(Angle.degrees(30), duration: 0.2)
                    SpringKeyframe(Angle.degrees(-30), duration: 0.2)
                    
                    // A SpringKeyframe kicks off a spring animation towards a value, but it doesn't guarantee the animation will be perfectly settled at the target value when its duration ends.
                    //SpringKeyframe(Angle.degrees(0), duration: 0.2)
                    CubicKeyframe(Angle.degrees(0), duration: 0.2)
                }

                // 2. Animate Horizontal Offset (using Cubic splines for ease-in/out)
                KeyframeTrack(\.horizontalOffset) {
                    CubicKeyframe(0, duration: 0.1)
                    CubicKeyframe(-20, duration: 0.2)
                    CubicKeyframe(20, duration: 0.2)
                    CubicKeyframe(-20, duration: 0.2)
                    CubicKeyframe(0, duration: 0.2)
                }

                // 3. Animate Scale (using a Linear path)
                KeyframeTrack(\.scale) {
                    LinearKeyframe(1.0, duration: 0.4) // Stay normal size for a bit
                    LinearKeyframe(1.5, duration: 0.2) // Scale up
                    LinearKeyframe(1.0, duration: 0.3) // Scale back down
                }
            }

            // Button to trigger the animation
            Button("Animate Bell") {
                trigger.toggle()
            }
            .fontWeight(.bold)
            .buttonStyle(.borderedProminent)
        }
        .navigationTitle("Keyframe Animator")
    }
}

// A simple struct to hold all the values we want to animate.
struct AnimationValues {
    var scale = 1.0
    var rotation = Angle.zero
    var horizontalOffset = 0.0
}

#Preview {
    KeyframeAnimatorDemo()
}

