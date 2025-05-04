//
//  PokdexListViewCollectionController.swift
//  Pokedex
//
//  Created by Adi Mizrahi on 04/05/2025.
//

import Foundation
import UIKit

protocol PokdexListViewCollectionDelegate: AnyObject {
    func loadMoreDataIfNeeded()
    func didSelectPokemon(_ name: String)
}

class PokdexListViewCollectionController: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let viewModel: PokedexListViewModel

    weak var delegate: PokdexListViewCollectionDelegate?

    init(viewModel: PokedexListViewModel, delegate: PokdexListViewCollectionDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfPokemons
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCell", for: indexPath) as? PokemonCell, let pokemon = viewModel.pokemon(at: indexPath.row) else {
            return UICollectionViewCell()
        }
        cell.configure(item: pokemon)
        return cell
    }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let padding: CGFloat = 32  // total horizontal padding: left + right (8 + 8) + inter-item spacing (8 * 2)
            let availableWidth = collectionView.frame.width - padding
            let width = availableWidth / 3
            return CGSize(width: floor(width), height: floor(width * 1.2)) // slightly taller than wide
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 8
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 8
        }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY > contentHeight - height - 100 {
            delegate?.loadMoreDataIfNeeded()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let pokemon = viewModel.pokemon(at: indexPath.row) {
            delegate?.didSelectPokemon(pokemon.name)
        }
    }
}
