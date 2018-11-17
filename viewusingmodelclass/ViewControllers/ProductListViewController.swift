//
//  ProductListViewController.swift
//  viewusingmodelclass
//
//  Created by Kush on 23/09/17.
//  Copyright © 2017 bansi. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Variables 
    var productList:[Product]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestForProductList()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func requestForProductList() {
        
        let url = URL(string: "http://192.168.1.15:8080/Android_2_WS/SelectProduct.php")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "contentType")
        
        let task = URLSession.shared.dataTask(with: request) { (result, response, error) in
            
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            let resultDict = try! JSONSerialization.jsonObject(with: result!, options: .allowFragments)
            
            DispatchQueue.main.async {
                self.parseData(result: resultDict as! [String : Any])
            }
            
            print(resultDict)
        }
        
        task.resume()
        
    }
    
    private func parseData(result:[String:Any]) {
        let productMain = ProductMain(fromDictionary: result)
        productList = productMain.productList
        tableView.reloadData()
    }
    
    //MARK:- Tableview datasource methods 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let list = productList {
            return list.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "identifier")
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "identifier")
        }
        
        let product = productList![indexPath.row]
        cell?.textLabel?.text = product.name
        cell?.detailTextLabel?.text = product.price
        return cell!
        
    }
}
