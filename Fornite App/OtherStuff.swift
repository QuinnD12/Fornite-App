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
            
            Text(commentGenerator(av))
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


func commentGenerator(_ score: Double) -> String {
    let badComments = [
        "Uninstall, please",
        "Bot vibes detected",
        "Bush camper, really?",
        "Lost in Loot Lake?",
        "Storm dodger?",
        "Building basics lacking?",
        "Aim assist off?",
        "Supply drop rookie?",
        "Bush camper?",
        "Barely landed?",
        "Trap victim?",
        "Sniper misfire?",
        "Victory allergic?",
        "Shotgun shyness?",
        "Material mismanagement?",
        "Map clueless?",
        "Medkit mishaps?",
        "Pickaxe practice?",
        "Glider glitches?",
        "Revive reluctance?",
        "Storm circle skeptic?",
        "Elimination evasion?",
        "Noob nerves?"
    ]
    
    let medComments = [
        "Getting there, slowly",
        "Mediocre at its finest",
        "Congrats on mediocrity",
        "Pickaxe warrior",
        "Storm circle straggler?",
        "Building shaky?",
        "Aim in progress?",
        "Supply drop searcher?",
        "Sniper in training?",
        "Glider fumbler?",
        "Revive hesitancy?",
        "Elimination apprentice?",
        "Victory hopeful?",
        "Trap tripper?",
        "Storm circle dabbler?",
        "Building blocks wobbly?",
        "Aim needs tuning?",
        "Supply drop chaser?",
        "Sniper aspirant?",
        "Glider stutterer?",
        "Revive reluctancy?",
        "Elimination trainee?",
        "Victory aspirer?",
        "Trap troubler?"
    ]
    
    let goodComments = [
        "Llama loot luck?",
        "Social skills: 0",
        "Sweat much, tryhard?",
        "Touch grass, you need it",
        "Okay, Mr. 'I Win Always'",
        "How's the view from Victory Mountain?",
        "Leaving scraps for us mere mortals?",
        "Sweating buckets, aren't we?",
        "Ever give out charity wins?",
        "Do you even know what losing feels like?",
        "Fortnite's one-man army, huh?",
        "Someone's been practicing a bit too much...",
        "Making us feel like NPCs!",
        "Alright, big shot, ease up a bit!",
        "Living in Fortnite, huh?",
        "Sleep? What's that?",
        "Do you even see sunlight anymore?",
        "Fortnite's full-time employee!",
        "Is 'victory' your middle name?",
        "Ever heard of taking a break?",
        "Fortnite addict, right?",
        "Do you dream in Fortnite too?",
        "No life outside the game?",
        "Ever consider a life beyond Fortnite?"
    ]
    
    switch score {
    case 0.01...33.33:
        return badComments[Int.random(in: 0..<badComments.count)]
    case 33.34...66.66:
        return medComments[Int.random(in: 0..<medComments.count)]
    case 66.67...100.00:
        return goodComments[Int.random(in: 0..<goodComments.count)]
    default:
        return "-----"
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
        let scoreMatch = Double(ovstats?.scorePerMatch ?? 0)
        let playersOutlived = Double(ovstats?.playersOutlived ?? 0)
        let soloMatch = Double(user.data?.stats?.all?.solo?.matches ?? 0)
        let ltmMatch = Double(user.data?.stats?.all?.ltm?.matches ?? 0)
        let mobileHours = Double((user.data?.stats?.touch?.overall?.minutesPlayed ?? 0) / 60)
        
        var magicNumber = (kd+(2*wr)) * ((hours/3)+matches+(5*mobileHours) - (3*ltmMatch))
        magicNumber += playersOutlived + (soloMatch/10) + (5000*kpm) 
        magicNumber += 1000*scoreMatch
        
        print(magicNumber)
        print(scoreMatch)
        
        return (100*magicNumber) / 3073423.6093333336
    } else {
        return 0
    }
}
