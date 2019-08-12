//
//  SuggestionsViewController.swift
//  Hurb
//
//  Created by Alexandre Papanis on 12/08/19.
//  Copyright © 2019 Papanis. All rights reserved.
//

import UIKit

class SuggestionsViewController: UIViewController {

    //MARK: - Properties
    private let suggestionCell = "suggestionCell"
    
    var resultListDelegate: ResultListDelegate!
    
    //O Default Place está como Rio de Janeiro. No desafio não estava claro se o lugar default era Rio de Janeiro ou Búzios. E no exemplo ainda está usando a cidade de Gramado.
    private var searchText: String = Defines.DEFAULT_PLACE
    private var suggestions: [Suggestion] = []
    
    //MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noResultsView: UIView!
    @IBOutlet weak var noInternetConnectionView: UIView!
    @IBOutlet weak var loadingView: UIView!
    
    @IBOutlet weak var animationLoadingView: UIView!
    
    @IBAction func reconnect(_ sender: UIButton) {
        searchPlace() 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.noResultsView.isHidden = true
        self.noInternetConnectionView.isHidden = true
        self.tableView.tableFooterView = UIView(frame: .zero)
        
    }
    
}

extension SuggestionsViewController: UISearchControllerDelegate, UISearchBarDelegate {
 
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.loadingView.isHidden = true
        self.suggestions = []
        self.tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchPlace()
    }
    
    func searchPlace() {
        self.dismissKeyboard()
        
        if self.searchText.count >= 3 {
            
            if !Reachability.isConnectedToNetwork(){
                print("Internet Connection not Available!")
                loadingView.isHidden = true
                noResultsView.isHidden = true
                noInternetConnectionView.isHidden = false
                FirebaseAnalyticsHelper.isNotConnectedEventLogger()
            }else{
                print("Internet Connection Available!")
                loadingView.isHidden = false
                noInternetConnectionView.isHidden = true
                
                searchBar.text = searchText
                
                APIClient.searchSuggestions(by: self.searchText, completion: { [unowned self] result in
                    
                    self.loadingView.isHidden = true
                    switch result {
                    case .success(let suggestionResults):
                        self.suggestions = suggestionResults.suggestions ?? []
                        if suggestionResults.suggestions?.count == 0 {
                            self.noResultsView.isHidden = false
                        } else {
                            self.noResultsView.isHidden = true
                            self.tableView.reloadData()
                        }
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                })
            }
            
        } else {
            self.present(showAlert(mensagem: "Por favor, digite ao menos 3 caracteres"), animated: true, completion: nil)
        }
    }
}

extension SuggestionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - UITableView extension
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: suggestionCell)!
        
        let suggestionViewModel = SuggestionViewModel(suggestions[indexPath.row])
        
        cell.textLabel!.text = suggestionViewModel.name
        cell.detailTextLabel!.text = suggestionViewModel.type
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let suggestionViewModel = SuggestionViewModel(suggestions[indexPath.row])
        resultListDelegate.updateResultList(newPlace: suggestionViewModel)
        
        self.navigationController?.popViewController(animated: true)
    
        
    }
    
}
