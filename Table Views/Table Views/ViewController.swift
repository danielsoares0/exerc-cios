//
//  ViewController.swift
//  Table Views
//
//  Created by Daniel Soares on 10/09/20.
//  Copyright © 2020 Daniel Soares. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    let cellIdentifier = "CellIdentifier"
    var fruits: [String] = []
    var alphabetizedFruits = [String: [String]]() //dicionário
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fruits = ["Apple", "Pineapple", "Orange", "Blackberry", "Banana", "Pear", "Kiwi", "Strawberry"]
        //Alphabetize Fruits
        alphabetizedFruits = alphabetizeArray(array: fruits)
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
        
        //como estamos utilizando dicionários, vamos criar uma seção para cada letra
        let keys = alphabetizedFruits.keys
        return keys.count
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let numberOfRows = fruits.count
//        return numberOfRows
        
        let keys = alphabetizedFruits.keys
        
        //Sort Keys -- buscamos a chave que corresponde à section
        let sortedKeys = keys.sorted(by: { (a,b) -> Bool in
            a.lowecaseString < b.lowercaseString
        })
        
        //Fetch Fruits --
        let key = sortedKeys[section]
        
        if let fruits = alphabetizedFruits[key] {
            return fruits.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        //dequeueReusableCell é um método pra reusar célular assim que saem da tela, pra não usar muita memória
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath)
//
//        //o indexPath vai percorrer todos os elementos da row, fazendo a row 0 assumir a posição 0 do array
//        let fruit = fruits[indexPath.row]
//
//        //aqui você vai atribuir para cada cell, como um textLabel, o valor dos itens de fruit
//        cell.textLabel?.text = fruit
//
//        return cell
        
        //Fetch and Sort Keys
        let keys = alphabetizedFruits.keys.sorted(by: {(a,b) -> Bool in
            a.lowercaseString < b.lowercaseString
        })
        
        //Fetch Fruits for Section
        let key = keys[indexPath.section]
        
        if let fruits = alphabetizedFruits[key] {
            //Fetch Fruits
            let fruit = fruits[indexPath.row]
            
            //Configure cell
            cell.textLabel?.text = fruit
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        
        let keys = alphabetizedFruits.keys.sorted(by: {(a,b) ->Bool in
            a.lowercaseString < b.lowercaseString
        })
        
        return keys[section]
    }
    
    private func alphabetizeArray(array: [String]) -> [String: [String]] {
        
        //criando um dicinário "result" para armazenar um array de arrays (frutas pelo alfabeto)
        var result = [String: [String]]()
        
        for item in array {
            let index = item.startIndex.advancedBy(1)
            let firstLetter = item.substringToIndex(index).uppercaseString //retirando a primeira letra do nome do item e transformando em maiúscula
            
            
            if result[firstLetter] != nil { //adicionando o item do array num array por primeira letra
                result[firstLetter]!.append(item)
            } else {
                result[firstLetter] = [item] //criando e adicionando o item do array num array por primeira letra, caso ainda não exista um array por primeira letra criado
            }
        }
        
        //os itens estão agrupados por letra e esse laço vai ordenar por ordem alfabética
        for (key,value) in result {
            result[key] = value.sorted(by: {(a,b) -> Bool in
                a.lowercaseString < b.lowercaseString
            })
        }
        
        return result
    }
    
}

