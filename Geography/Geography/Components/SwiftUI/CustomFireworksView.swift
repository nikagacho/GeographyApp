//
//  CustomFireworksView.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 11.02.24.
//

import SwiftUI
//MARK: - Single Particle
struct FireworkParticle: Identifiable {
    var id = UUID()
    var position: CGPoint
    var scale: CGFloat
    var color: Color
}
//MARK: -  Fireworks View
struct CustomFireworksView: View {
    //MARK: - Properties
    @State private var particles: [FireworkParticle] = []
    @State private var explode = false
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    //MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(particles) { particle in
                    Circle()
                        .fill(particle.color)
                        .frame(width: 10, height: 10)
                        .scaleEffect(particle.scale)
                        .position(particle.position)
                        .opacity(explode ? 0 : 1)
                }
            }
            .onReceive(timer) { _ in
                explodeFirework(screenSize: geometry.size)
            }
            .onAppear {
                explodeFirework(screenSize: geometry.size)
            }
            .animation(.easeOut(duration: 2.0), value: explode)
        }
    }

    //MARK: - Methods
    func explodeFirework(screenSize: CGSize) {
        particles = (1...100).map { _ in
            FireworkParticle(
                position: CGPoint(x: CGFloat.random(in: 0...screenSize.width), y: CGFloat.random(in: 0...screenSize.height)),
                scale: CGFloat.random(in: 0.1...1),
                color: Color(
                    red: Double.random(in: 0...1),
                    green: Double.random(in: 0...1),
                    blue: Double.random(in: 0...1)
                )
            )
        }
        explode = false
        withAnimation(.easeOut(duration: 2.0)) {
            explode = true
        }
    }

}

