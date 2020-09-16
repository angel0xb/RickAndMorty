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
    var subscriptions = [AnyCancellable]()//defined here to keep subcription alive
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpSubcriptions()
    }
    
    /// Sets data source, delegate and registers cell for UITableView
    func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: PeopleCell.reuseId, bundle: nil), forCellReuseIdentifier: PeopleCell.reuseId)
    }
    
    
    /// Sets up subscription to View models data
    func setUpSubcriptions() {
        viewModel.$people
            .receive(on: DispatchQueue.main)
            .sink { [weak self ] people in
                guard let self = self else { return }
                // every time 'people' from our viewmodel is updated we will reload our tablview
                self.tableView.reloadData()
        }
            // stor our subcription
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = viewModel.people[indexPath.row]
        //create an alert view which tells us where the person is located
        let alert = UIAlertController(title: "\(person.name) is located on", message: "\(person.location.name)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 330
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //when we get to our last element use our viewmodel to load our next batch of characters
        let lastElement = viewModel.people.count - 1
        if  indexPath.row == lastElement {
            viewModel.loadNext()
        }
    }
}

