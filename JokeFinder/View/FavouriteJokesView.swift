//
//  FavouriteJokesView.swift
//  JokeFinder
//
//  Created by Thomas Noone on 2025-03-06.
//

import SwiftUI
 
struct FavouriteJokesView: View {
    
    // MARK: Stored properties
     
    // Access the view model from the environment
    @Environment(JokeViewModel.self) var viewModel
     
    // MARK: Computed properties
    var body: some View {
        NavigationStack {
            VStack {
                // When there are no saved jokes...
                if viewModel.favouriteJokes.isEmpty {
                    
                    // ... show an appropriate message
                    ContentUnavailableView(
                        "No favourite jokes",
                        systemImage: "heart.slash",
                        description: Text("See if a new joke might tickle your funny bone!")
                    )
                    
                } else {
                    
                    // Show a scrollable list of saved jokes
                    List(viewModel.favouriteJokes) { currentJoke in
                        VStack(alignment: .leading, spacing: 5) {
                            Text(currentJoke.setup ?? "")
                            Text(currentJoke.punchline ?? "")
                                .italic()
                        }
                    }
                    .listStyle(.plain)
                    
                }
            }
            .navigationTitle("Favourites")
        }
    }
}
 
#Preview {
    FavouriteJokesView()
        .environment(JokeViewModel())
}
