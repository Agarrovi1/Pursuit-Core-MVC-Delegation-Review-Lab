//
//  ViewController.swift
//  MVC+Delegation-Review-Lab
//
//  Created by Benjamin Stone on 8/19/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let movies = Movie.allMovies
    private func changeFont(to font: Double) {
        let fontCGFloat = CGFloat(font)
        let subtitleFont = CGFloat(font - 5)
        let cells = tableView.visibleCells
        for aCell in cells {
            aCell.textLabel?.font = UIFont.systemFont(ofSize: fontCGFloat)
            aCell.detailTextLabel?.font = UIFont.systemFont(ofSize: subtitleFont)
        }
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellOne") else {return}
//        cell.textLabel?.font = UIFont.systemFont(ofSize: fontCGFloat)
//        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: subtitleFont)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? FontSettingViewController else {return}
        let cells = tableView.visibleCells
        guard let fontSize = cells[0].textLabel?.font.pointSize else {return}
        let sizeAsDouble = Double(fontSize)
        let sizeAsFloat = Float(fontSize)
        destination.newSliderValue = sizeAsFloat
        destination.newStepperValue = sizeAsDouble
        destination.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
}

extension MainViewController: UITableViewDelegate {
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellOne", for: indexPath)
        let theMovie = movies[indexPath.row]
        cell.textLabel?.text = theMovie.name
        cell.detailTextLabel?.text = theMovie.year.description
        return cell
    }
}

extension MainViewController: FontSettings {
    func fontDidChange(to font: Double) {
        changeFont(to: font)
    }
    
    
}
