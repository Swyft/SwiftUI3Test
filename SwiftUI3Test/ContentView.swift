//
//  ContentView.swift
//  SwiftUI3Test
//
//  Created by David Fekke on 6/9/21.
//

import SwiftUI

// ``ContentView``
// # SW Ships
// This is the main struct view for listing the ships
struct ContentView: View {
    
    @State var ships: [Ship] = []
    var body: some View {
        NavigationView {
            VStack {
                List(ships) { ship in
                    Text(ship.name)
                }
                .navigationTitle("Star Ships")
                Button("Get more Data") {
                    //
                    getMoreData()
                }
            }
            
        }
        .refreshable {
            async {
                try await getResults()
                
            }
        }
        .onAppear {
            async {
                try await getResults()
            }
        }
        .navigationTitle("This is a my title")
    }
    
    
    func getResults() async throws -> Void {
        let url = URL(string: "https://swapi.dev/api/starships/?page=1")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let myResult = try JSONDecoder().decode(StarshipServiceResponse.self, from: data)
        if let starships = myResult.results {
            ships = starships.map { Ship(name: $0.name!) }
        }
    }
    
    func getMoreData() -> Void {
        if let url = URL(string: "https://swapi.dev/api/starships/?page=2") {
        
            let task = URLSession.shared.dataTask(with: url) { data, response, err in
                if let error = err {
                    print("\(error)")
                    return
                }
                
                do {
                    if let data = data {
                        let myResult = try JSONDecoder().decode(StarshipServiceResponse.self, from: data)
                        if let starships = myResult.results {
                            let ships2 = starships.map { Ship(name: $0.name!) }
                            ships.append(contentsOf: ships2)
                        }
                    }
                } catch {
                    print("\(error.localizedDescription)")
                }
                
            }
            task.resume()
            
        }
    }
}

struct Ship : Identifiable {
    var id = UUID()
    var name: String
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
