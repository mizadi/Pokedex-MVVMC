//
//  PokemonDetailsViewController.swift
//  Pokedex
//
//  Created by Adi Mizrahi on 04/05/2025.
//

import UIKit

class PokemonDetailsViewController: UIViewController {
    var viewModel: PokemonDetailsViewModel!
    @IBOutlet weak var ivMain: UIImageView!
    @IBOutlet weak var lbMain: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Details"

        viewModel.onDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.updateUI()
            }
        }

        viewModel.onError = { error in
            print("Failed to fetch details: \(error)")
        }

        viewModel.fetchDetails()
    }

    func updateUI() {
        guard let pokemon = viewModel.pokemon else { return }
        lbMain.text = pokemon.name.capitalized

        if let spriteURLString = pokemon.sprites.front_default,
           let spriteURL = URL(string: spriteURLString) {
            ivMain.sd_setImage(with: spriteURL)
        } else {
            ivMain.image = UIImage(named: "placeholder")
        }
    }
}
