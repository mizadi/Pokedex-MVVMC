//
//  PokedexListViewController.swift
//  Pokedex
//
//  Created by Adi Mizrahi on 04/05/2025.
//

import Foundation
import UIKit

class PokedexListViewController: UIViewController {
    var coordinator: PokedexCoordinator?
    var viewModel: PokedexListViewModel!
    var onPokemonSelected: ((String) -> Void)? = nil

    @IBOutlet weak var cvMain: UICollectionView!

    private var collectionController: PokdexListViewCollectionController!
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Pokedex"

        setupActivityIndicator()
        setCollectionView()

        viewModel.delegate = self
        viewModel.fetchNextPage()
    }

    private func setupActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func setCollectionView() {
        collectionController = PokdexListViewCollectionController(viewModel: viewModel, delegate: self)
        cvMain.delegate = collectionController
        cvMain.dataSource = collectionController
    }
}

extension PokedexListViewController: PokedexListViewModelDelegate {
    func didUpdatePokedexList() {
        cvMain.reloadData()
    }
    
    func didFailWithError(_ error: any Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    func didChangeLoadingState(_ isLoading: Bool) {
        if isLoading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}

extension PokedexListViewController: PokdexListViewCollectionDelegate {
    func loadMoreDataIfNeeded() {
        viewModel.fetchNextPage()
    }

    func didSelectPokemon(_ name: String) {
        coordinator?.showDetails(for: name)
    }
}
