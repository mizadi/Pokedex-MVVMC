# 🧢 Pokedex App

A simple Pokedex app built with UIKit + MVVM architecture. It uses Swift, async/await, and demonstrates good separation between View, ViewModel, and networking layers. Pokemons are fetched from the PokéAPI and saved locally using a file-based cache.

## 🔧 Features

- ✅ List of Pokemons
- ✅ Load details per Pokemon (image, types, abilities)
- ✅ File-based caching for offline access
- ✅ Clean MVVM separation
- ✅ Swift async/await + modern code
- ✅ Simple UI with Storyboards
- ✅ Error handling + fallback when network fails

## 💡 How it works

- On launch, the app loads the list of Pokemons from the API.
- When tapping on a Pokemon, the app checks the local cache. If the data is not cached, it fetches it and saves it.
- The ViewModel handles business logic, parsing, and state updates.
- ViewControllers are lightweight, updating only based on bindings.

## 📸 Screenshots

*(Add your screenshots here if you want)*

## 🛠 Requirements

- Xcode 15+
- iOS 16+
- Swift 5.9+

## 🔍 To improve

- Add search
- Replace Storyboards with SwiftUI
- Add pagination
- Switch to Keychain or Core Data for more persistence options

## 👨‍💻 Author

Adi Mizrahi  
Feel free to reach out with feedback or questions.
