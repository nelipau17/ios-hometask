//
//  ViewController.swift
//  ios-hometask
//
//  Created by Polina Popova on 08/10/2023.
//

import UIKit

class ViewController: UIViewController {
    private var tableView: UITableView = UITableView()
    private var pokemonArray: PokemonDTO?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        setupTableView()
        getImages()
    }
    private func setupTableView()
    {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
    }
    private func getImages()
    {
        let url = URL(string: "https://api.pokemontcg.io/v2/cards")!
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard
                let data = data,
                error == nil
            else {
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            //обработка данных
            let model = try! decoder.decode(PokemonDTO.self, from: data)
            DispatchQueue.main.async {
                self.pokemonArray = model
                self.tableView.reloadData()
            }
            
        }).resume()
    }
    
}
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokemonArray?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pokemonArray else { return UITableViewCell() }
        var cell = UITableViewCell()
        var configuration = cell.defaultContentConfiguration()
        // configuration.image = UIImage()
        configuration.text = pokemonArray.data[indexPath.row].name
        cell.contentConfiguration = configuration
        return cell
        
    }
    
}
struct PokemonDTO: Codable {
    let data: [Datum]
    let page, pageSize, count, totalCount: Int
}
struct Datum: Codable {
    let id: String
    let name: String
    let images: DatumImages
}
struct DatumImages: Codable {
    let small, large: String
}
/*enum CodingKeys: String, CodingKey {
        case id, name, supertype, subtypes, level, hp, types, evolvesFrom, abilities, attacks, weaknesses, resistances, retreatCost, convertedRetreatCost
        case datumSet = "set"
        case number, artist, rarity, flavorText, nationalPokedexNumbers, legalities, images, tcgplayer, cardmarket, evolvesTo, rules, regulationMark
}*/
//"name":"Persimmon","id":52,"family":"Ebenaceae","order":"Rosales","genus":"Diospyros","nutritions":{"calories":81,"fat":0.0,"sugar":18.0,"carbohydrates":18.0,"protein":0.0
