//
//  RatingView.swift
//  Fornite App
//
//  Created by Quinn B. Davis on 11/21/23.
//

import SwiftUI

struct RatingView: View {
    @State private var av = 0
    var rating: Int
    
    let comments = [
        "a",//worst
        "b",
        "c",
        "d",
        "e",
        "f",
        "g",
        "h",
        "i",
        "j",
        "k" //best
    ]
    
    var body: some View {
        VStack(spacing: -50) {
            ZStack {
                Circle()
                    .trim(from: 0.45, to: 1)
                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [Color(white: 0.8), .black]), startPoint: .leading, endPoint: .trailing)
                    )
                    .frame(width: 300)
                    .rotationEffect(.degrees(10))
                
                Image(systemName: "line.diagonal.arrow")
                    .imageScale(.large)
                    .scaleEffect(9)
                    .rotationEffect(.degrees(Double((av*190)/100) + 225))
            }
            
            Text(String(av == 0 ? "--" : String(av)))
                .font(.custom("Trebuchet MS", size: 90))
            
            Text(rating == 0 ? "----" : comments[Int(av/10)])
                .font(.custom("Trebuchet MS", size: 40))
                .foregroundStyle(Color(white: 0.4))
                .padding(40)
            
        }.onAppear {
            withAnimation(.bouncy(duration: 1)) {
                av = rating
            }
        }

    }
}

#Preview {
    RatingView(rating: 11)
}
