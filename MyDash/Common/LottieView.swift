//
//  LottieView.swift
//  MyDash
//
//  Created by Abhishek on 09/04/25.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    
    let animationname: String
    let animationView = LottieAnimationView()
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        
        /// load animation from files
        let animation = LottieAnimation.named(animationname)
        animationView.animation = animation
        
        /// set the animation properties
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        /// add the lotie animation as a subview
        view.addSubview(animationView)
        
        /// set up the constraints to make animationview match the size of the parent view
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])

        return view
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
    }
}
