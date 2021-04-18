import UIKit
import SwiftUI
import PlaygroundSupport

public struct FlipCoinView: View {
    @State private var side: HeadsORTails = .heads

    public var body: some View {
        ZStack {
            Image(systemName: "bitcoinsign.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .background(Color.white)
                .foregroundColor(.gray)
                .modifier(FlipToTails(side: side))

            Image(systemName: "bitcoinsign.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .background(Color.white)
                .foregroundColor(.yellow)
                .modifier(FlipToHeads(side: side))

        }
        .onTapGesture (perform: handleFlipViewTap)
    }

    private func handleFlipViewTap() -> Void {
        withAnimation(.easeOut(duration: 0.25)) {
            switch side {
            case .heads: side = .tails
            case .tails: side = .heads
            }
        }
    }
}

struct FlipToTails: ViewModifier {
    private(set) var side: HeadsORTails

    func body(content: Content) -> some View {
        content
            .rotation3DEffect(.degrees(side == .heads ? .zero : 180.0), axis: FlipDirection.leftToRight.axis)
            .zIndex(side == .heads ? 1 : 0)
    }
}

struct FlipToHeads: ViewModifier {
    private(set) var side: HeadsORTails

    func body(content: Content) -> some View {
        content
            .rotation3DEffect(.degrees(side == .tails ? .zero : 180.0), axis: FlipDirection.rightToLeft.axis)
            .zIndex(side == .tails ? 1 : 0)
    }
}

enum HeadsORTails {
    case heads
    case tails
}

enum FlipDirection {
    case rightToLeft
    case leftToRight

    var axis: (x: CGFloat, y: CGFloat, z: CGFloat) {
        switch self {
        case .rightToLeft:
            return (x: 0.0, y: -1.0, z: 0.0)
        case .leftToRight:
            return (x: 0.0, y: 1.0, z: 0.0)
        }
    }
}

let view = FlipCoinView()
PlaygroundPage.current.liveView = UIHostingController(rootView: view)
