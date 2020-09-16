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
    
    //makes it easier when trying registering Cell
    static let reuseId: String = "PeopleCell"
    
    
    /// Sets up cell ui elements with properties from person
    /// - Parameter person: contains properties from which you like to populate cell with
    func configureCell(person: Person) {
        nameLabel.text = person.name
        speciesLabel.text = "Species: \(person.species)"
        statusLabel.text = "Status: \(person.status)"
        //using url extension to populate our UIImageView
        peopleImage.getImage(for: person.imageURL)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        //Rounding corners because sharp corners are ugly
        peopleImage.layer.cornerRadius = 8.0
        peopleImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
