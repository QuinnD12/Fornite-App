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
    
    var body: some View {
        VStack {
            TextField("Enter Username", text: $input)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .font(.custom("Trebuchet MS", size: 40))
                .padding(50)
                .multilineTextAlignment(.center)
            
            Button("Load") {
                Task {
                    do {
                        id = try await getID(input)
                        user = try await getUser(id)
                        
                        done.toggle()
                    } catch NetworkError.invalidURL {
                        alert = true
                        errorAlert = "Invalid URL"
                    } catch NetworkError.invalidResponse {
                        alert = true
                        errorAlert = "Invalid Response"
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
            Button("OK", role: .cancel) {
                //Todo Recall View
            }
        }
    }
}

#Preview {
    ContentView()
}
