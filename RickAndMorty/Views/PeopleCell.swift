//
//  PeopleCell.swift
//  RickAndMorty
//
//  Created by Angel Rodriguez on 9/15/20.
//  Copyright © 2020 AngelRodriguez. All rights reserved.
//

import UIKit

class PeopleCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var speciesLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet weak var peopleImage: UIImageView!
    
    static let reuseId: String = "PeopleCell"
    
    func configureCell(person: Person) {
        nameLabel.text = person.name
        speciesLabel.text = person.species
        statusLabel.text = person.status
        
        let networkManager = NetworkManager()
        networkManager.getImage(for: person.image) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let uiImage):
                DispatchQueue.main.async {
                    self.peopleImage.image = uiImage
                }
            case .failure(_):
                //no image
                return
            }
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
