//
//  ContentView.swift
//  Fornite App
//
//  Created by Quinn B. Davis on 11/17/23.
//

import SwiftUI

struct ContentView: View {
    @State private var id: String = ""
    @State private var user: FortniteUser?
    @State private var alert = false
    @State private var errorAlert = ""
    
    var body: some View {
        VStack {
            Text(String(user?.data?.stats?.all?.overall?.wins ?? 0))
            Button("Load") {
                Task {
                    do {
                        id = try await getID("cart_.")
                        user = try await getUser(id)
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
