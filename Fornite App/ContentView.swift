//
//  ContentView.swift
//  Fornite App
//
//  Created by Quinn B. Davis on 11/17/23.
//

import SwiftUI

struct ContentView: View {
    @State private var input = ""
    @State private var id: String = ""
    @State private var user: FortniteUser?
    @State private var alert = false
    @State private var errorAlert = ""
    @State private var done = false
    @State private var selection = "Select Platform"
    private let platforms = ["Select Platform", "Epic", "PlayStation", "Xbox", "Steam"]
    
    var body: some View {
        VStack {
            VStack(spacing: -50) {
                TextField("Enter Username", text: $input)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .font(.custom("Trebuchet MS", size: 30))
                    .padding(50)
                    .multilineTextAlignment(.center)
                    .onChange(of: input) {
                        done = false
                    }

                
                Picker("Please choose a color", selection: $selection) {
                   ForEach(platforms, id: \.self) {
                       Text($0)
                   }
               }.tint(.black)
            }.padding()
            
            Button("Load") {
                var plat = ""
                
                switch selection {
                    case "PlayStation":
                        plat = "psn"
                    case "Xbox":
                        plat = "xbl"
                    case "Steam":
                        plat = "steam"
                    default:
                        plat = "epic"
                }
                
                Task {
                    do {
                        id = try await getID(input, platform: plat)
                        user = try await getUser(id)
                        
                        done = true
                    } catch NetworkError.invalidURL {
                        alert = true
                        errorAlert = "Invalid URL"
                    } catch NetworkError.invalidResponse {
                        alert = true
                        errorAlert = "Invalid Response\nAccount Not Found?"
                    } catch NetworkError.invalidData {
                        alert = true
                        errorAlert = "Invalid Data"
                    } catch {
                        alert = true
                        errorAlert = "Unkown Error"
                    }
                }
            }.font(.custom("Trebuchet MS", size: 40))
            .foregroundStyle(.black)
            
            Spacer()

            if done {
                RatingView(rating: superSecretFortniteAlgorithim(user))
            }
            
        }.alert(errorAlert, isPresented: $alert) {
            Button("OK", role: .cancel) {}
        }
    }
}

#Preview {
    ContentView()
}
