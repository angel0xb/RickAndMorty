//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Angel Rodriguez on 9/15/20.
//  Copyright © 2020 AngelRodriguez. All rights reserved.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let viewModel = ListViewModel()
    var subscriptions = [AnyCancellable]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: PeopleCell.reuseId, bundle: nil), forCellReuseIdentifier: PeopleCell.reuseId)
        
        viewModel.$people
            .receive(on: DispatchQueue.main)
            .sink { people in
                self.tableView.reloadData()
        }
        .store(in: &subscriptions)
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if let peopleCell = tableView.dequeueReusableCell(withIdentifier: PeopleCell.reuseId, for: indexPath) as? PeopleCell {
            let person = viewModel.people[indexPath.row]
            peopleCell.configureCell(person: person)
            cell = peopleCell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 330
    }
}

