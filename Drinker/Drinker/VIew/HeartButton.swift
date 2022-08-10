//
//  HeartButton.swift
//  Drinker
//
//  Created by Dmitry Zasenko on 08.08.22.
//

import SwiftUI

struct HeartButton: View {
    @Binding var isLiked: Bool
    
    var animationDuration: Double = 0.1
    var animationScale: CGFloat = 1.3
    
    @State private var animate = false
    
    var body: some View {
        Button {
            self.animate = true
            DispatchQueue.main.asyncAfter(deadline: .now() + self.animationDuration) {
                self.animate = false
                self.isLiked.toggle()
            }
            
            
        } label: {
            Image(systemName: isLiked ? "heart.fill" : "heart")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30)
                .foregroundColor(isLiked ? .red : .gray)
                .padding()
        }
        .scaleEffect(animate ? animationScale : 1)
        .animation(.easeIn(duration: animationDuration), value: animate)

    }
}

struct HeartButton_Previews: PreviewProvider {
    static var previews: some View {
        HeartButton(isLiked: .constant(true))
    }
}
