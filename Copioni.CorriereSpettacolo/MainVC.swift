//
//  ViewController.swift
//  Copioni.CorriereSpettacolo
//
//  Created by Fabio Cipriani on 31/08/16.
//  Copyright © 2016 Fabio Cipriani. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    var articolo: Article!
    var articoli: [Article]!
    var articoliFiltrati: [Article]!
    var inSearchMode: Bool = false
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 74
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        articolo = Article()
        articoli = [Article]()
        articoliFiltrati = [Article]()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        articolo.DownloadRecentArticlesDetails { (temp_articoli) in
            self.articoli = temp_articoli
            self.tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            tableView.reloadData()
            view.endEditing(true)
        } else {
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            print(lower)
            
            articoliFiltrati = articoli.filter({
                $0.author.lowercased().contains(lower) || $0.title.lowercased().contains(lower)
            })
            
            tableView.reloadData()
        }

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if inSearchMode {
            return articoliFiltrati.count
        } else {
            return articoli.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Article Cell", for: indexPath) as? ArticleCell {
            let art: Article!
            
            if inSearchMode {
                art = articoliFiltrati[indexPath.row]
            } else {
                art = articoli[indexPath.row]
            }
            print(articoliFiltrati.count)
            cell.configureCell(art)
            return cell
        } else {
            return ArticleCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var articolo: Article!
        
        if inSearchMode {
            articolo = articoliFiltrati[indexPath.row]
        } else {
            articolo = articoli[indexPath.row]
        }
        
        performSegue(withIdentifier: "CopioneVC", sender: articolo.copioneURL)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CopioneVC" {
            if let CopioneVC = segue.destination as? CopioneVC {
                if let copURL = sender as? String {
                    CopioneVC.copURL = copURL
                }
            }
        }
    }
    
}

