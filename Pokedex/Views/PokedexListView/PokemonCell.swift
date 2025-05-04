//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Adi Mizrahi on 04/05/2025.
//
import Foundation
import UIKit
import SDWebImage

class PokemonCell: UICollectionViewCell {
    @IBOutlet weak var ivMain: UIImageView!
    @IBOutlet weak var lbMain: UILabel!

    func configure(item: PokemonListItem) {
        lbMain.text = item.name
        if let id = item.url.split(separator: "/").last(where: { !$0.isEmpty }) {
            let imageURL = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")
            ivMain.sd_setImage(with: imageURL)
        }
    }
}
