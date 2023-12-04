//
//  RatingView.swift
//  Fornite App
//
//  Created by Quinn B. Davis on 11/21/23.
//

import SwiftUI

struct RatingView: View {
    @State private var av = 0.0
    var rating: Double
    
    let comments = [
        "Uninstall, please",//worst
        "Bot vibes detected",
        "Bush camper, really?",
        "Getting there, slowly",
        "Mediocre at its finest",
        "Congrats on mediocrity",
        "Pickaxe warrior",
        "Llama loot luck?",
        "Social skills: 0",
        "Sweat much, tryhard?",
        "Touch grass, you need it" //best
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
                    .scaleEffect(8)
                    .rotationEffect(.degrees(Double((av*190)/100) + 225))
            }
            
            Text(String(av == 0 ? "--" : String((av*100).rounded()/100)))
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

func superSecretFortniteAlgorithim(_ user: FortniteUser?) -> Double {
    if let user = user {
        let ovstats = user.data?.stats?.all?.overall
        
        let kd = Double(ovstats?.kd ?? 0)
        let kpm = Double(ovstats?.killsPerMatch ??  0)
        let matches = Double(ovstats?.matches ?? 0)
        let hours = Double((ovstats?.minutesPlayed ?? 0) / 60)
        let wr = Double(ovstats?.winRate ?? 0)
        let playersOutlived = Double(ovstats?.playersOutlived ?? 0)
        let soloMatch = Double(user.data?.stats?.all?.solo?.matches ?? 0)
        let ltmMatch = Double(user.data?.stats?.all?.ltm?.matches ?? 0)
        let mobileHours = Double((user.data?.stats?.touch?.overall?.minutesPlayed ?? 0) / 60)
        
        var magicNumber/*up to around 10,000 to 20,000*/ = (kd+(2*wr)) * (hours+matches+(5*mobileHours) - (3*ltmMatch))
        magicNumber += playersOutlived + (soloMatch/10) + (5000*kpm)
        
        return (100*magicNumber) / 2990785.26
    } else {
        return 0
    }
}
