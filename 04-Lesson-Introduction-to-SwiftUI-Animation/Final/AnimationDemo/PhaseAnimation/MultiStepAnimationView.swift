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

// Define animation phases using an enum
enum Phase: CaseIterable {
    case initial
    case expanded
    case rotated
    case colored
    case final
    
    // Define the animation duration for each phase
    var duration: Double {
        switch self {
        case .initial: return 0.0
        case .expanded: return 0.8
        case .rotated: return 0.6
        case .colored: return 0.5
        case .final: return 0.7
        }
    }
    
    // Define the animation curve for each phase
    var animation: Animation {
        switch self {
        case .initial:
            return .linear(duration: duration)
        case .expanded:
            return .easeInOut(duration: duration)
        case .rotated:
            return .spring(duration: duration, bounce: 0.3)
        case .colored:
            return .easeOut(duration: duration)
        case .final:
            return .bouncy(duration: duration)
        }
    }
}

struct MultiStepAnimationView: View {
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Multi-Step PhaseAnimator Demo")
                .font(.title2)
                .fontWeight(.semibold)
                .padding()
            
            // PhaseAnimator with enum-based phases
            PhaseAnimator(
                Phase.allCases,
                trigger: isAnimating
            ) { phase in
                RoundedRectangle(cornerRadius: cornerRadius(for: phase))
                    .fill(color(for: phase))
                    .frame(
                        width: size(for: phase).width,
                        height: size(for: phase).height
                    )
                    .rotationEffect(rotation(for: phase))
                    .scaleEffect(scale(for: phase))
                    .shadow(
                        color: shadowColor(for: phase),
                        radius: shadowRadius(for: phase),
                        x: 0,
                        y: shadowOffset(for: phase)
                    )
            } animation: { phase in
                phase.animation
            }
            .frame(height: 200)
            
            // Control buttons
            HStack(spacing: 20) {
                Button("Start Animation") {
                    isAnimating.toggle()
                }
                .buttonStyle(.borderedProminent)
                .disabled(isAnimating)
                
                Button("Reset") {
                    if isAnimating {
                        isAnimating = false
                    }
                }
                .buttonStyle(.bordered)
            }
            .padding()
            
            // Phase descriptions
            VStack(alignment: .leading, spacing: 8) {
                Text("Animation Phases:")
                    .font(.headline)
                
                ForEach(Phase.allCases, id: \.self) { phase in
                    HStack {
                        Text("•")
                        Text(phaseDescription(for: phase))
                            .font(.caption)
                    }
                }
            }
            .padding()
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal)
            
            Spacer()
        }
    }
    
    // MARK: - Animation Properties
    
    private func size(for phase: Phase) -> CGSize {
        switch phase {
        case .initial:
            return CGSize(width: 60, height: 60)
        case .expanded:
            return CGSize(width: 120, height: 80)
        case .rotated:
            return CGSize(width: 120, height: 80)
        case .colored:
            return CGSize(width: 100, height: 100)
        case .final:
            return CGSize(width: 80, height: 80)
        }
    }
    
    private func color(for phase: Phase) -> Color {
        switch phase {
        case .initial:
            return .blue
        case .expanded:
            return .green
        case .rotated:
            return .orange
        case .colored:
            return .purple
        case .final:
            return .pink
        }
    }
    
    private func rotation(for phase: Phase) -> Angle {
        switch phase {
        case .initial, .expanded:
            return .degrees(0)
        case .rotated:
            return .degrees(180)
        case .colored:
            return .degrees(270)
        case .final:
            return .degrees(360)
        }
    }
    
    private func scale(for phase: Phase) -> Double {
        switch phase {
        case .initial:
            return 1.0
        case .expanded:
            return 1.2
        case .rotated:
            return 1.0
        case .colored:
            return 1.3
        case .final:
            return 1.0
        }
    }
    
    private func cornerRadius(for phase: Phase) -> Double {
        switch phase {
        case .initial:
            return 8
        case .expanded:
            return 16
        case .rotated:
            return 24
        case .colored:
            return 40
        case .final:
            return 20
        }
    }
    
    private func shadowColor(for phase: Phase) -> Color {
        switch phase {
        case .initial, .expanded:
            return .clear
        case .rotated:
            return .orange.opacity(0.3)
        case .colored:
            return .purple.opacity(0.5)
        case .final:
            return .pink.opacity(0.4)
        }
    }
    
    private func shadowRadius(for phase: Phase) -> Double {
        switch phase {
        case .initial, .expanded:
            return 0
        case .rotated:
            return 8
        case .colored:
            return 12
        case .final:
            return 6
        }
    }
    
    private func shadowOffset(for phase: Phase) -> Double {
        switch phase {
        case .initial, .expanded:
            return 0
        case .rotated:
            return 4
        case .colored:
            return 6
        case .final:
            return 3
        }
    }
    
    private func phaseDescription(for phase: Phase) -> String {
        switch phase {
        case .initial:
            return "Initial state - small blue square"
        case .expanded:
            return "Expands and turns green"
        case .rotated:
            return "Rotates 180° and turns orange with shadow"
        case .colored:
            return "Continues rotation, turns purple, increases shadow"
        case .final:
            return "Completes full rotation, turns pink, settles"
        }
    }
}


#Preview {
    MultiStepAnimationView()
}
