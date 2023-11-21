//
//  ContentView.swift
//  Fornite App
//
//  Created by Quinn B. Davis on 11/17/23.
//

import SwiftUI

struct ContentView: View {
    @State var data: String = ""
    
    var body: some View {
        VStack {
            Text(data)
            Button("Load") {
                Task {
                    do {
                        data = try await getUser("SypherPK")
                    } catch NetworkError.invalidURL {
                        print("Invalid URL")
                    } catch NetworkError.invalidResponse {
                        print("Invalid Response")
                    } catch NetworkError.invalidData {
                        print("Invalid Data")
                    } catch {
                        print("Unkown Error")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
