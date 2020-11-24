//
//  SearchGroupsTable.swift
//  VKApp
//
//  Created by Алексей Виноградов on 23.08.2020.
//  Copyright © 2020 Алексей Виноградов. All rights reserved.
//

import UIKit

class SearchGroupsTable: UITableViewController, UISearchBarDelegate {
    
    var newGroups = [
        GroupsData(name: "Писатели", pic: "writers"),
        GroupsData(name: "Актеры", pic: "actress"),
        GroupsData(name: "Научные гении", pic: "scientist"),
        GroupsData(name: "Сотрудники Apple", pic: "apple_company")
    ]
    
    var searchedGroups: [GroupsData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchedGroups = newGroups
        let searchBar: UISearchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Поиск..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        tableView.addSubview(searchBar)
        tableView.tableHeaderView = searchBar
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newGroupsCell", for: indexPath) as! SearchGroupTableCell
        cell.newGroupLabel.text = searchedGroups[indexPath.row].name
        cell.newGroupIcon.image = UIImage(named: searchedGroups[indexPath.row].pic!)
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard let text = searchBar.text else { return }
        
        if text.isEmpty {
            searchedGroups = newGroups
        } else {
            
            searchedGroups = newGroups.filter({ (group) -> Bool in
                return group.name.contains(text)
            })
        }
        
        tableView.reloadData()
    }
}
