//
//  ViewController.swift
//  viewusingmodelclass
//
//  Created by Kush on 13/07/17.
//  Copyright © 2017 bansi. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource {
    //   var productList = [[String:Any]]()
    var personlist = [Product]()
    
    @IBOutlet weak var tableview: UITableView!
    // @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        requestForList()
        
    }
    
    var productList:[Product]? {
        didSet {
            tableview.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- UITableview Datasource methdos
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let list = productList {
            return list.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "identifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: identifier)
        }
        
        let product = productList![indexPath.row]
        cell?.textLabel?.text = product.name
        //cell?.detailTextLabel?.text = "\(product["price"]!)"
        cell?.detailTextLabel?.text = product.price
        return cell!
    }
    
    //MARK:- Request methods
    private func requestForList() {
        let reqUrl = URL(string: "http://192.168.1.15:8080/Android_2_WS/SelectProduct.php")
        
        do {
            
            var request = URLRequest(url: reqUrl!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let session = URLSession.shared
            
            let task = session.dataTask(with: request, completionHandler: { (resData, response, error) in
                if (error != nil){
                    print(error.debugDescription)
                }else{
                    do {
                        
                        let resDict = try JSONSerialization.jsonObject(with: resData!, options: .allowFragments)
                        print(resDict)
                        DispatchQueue.main.async(execute: {
                            self.parseData(result: resDict as! [String : Any])
                        })
                        
                    }catch{
                        print(exception())
                    }
                }
            })
            task.resume()
        }
    }
    
    
    private func parseData(result:[String:Any]) {
        
        productList = ProductMain(fromDictionary: result).productList
    }
}

