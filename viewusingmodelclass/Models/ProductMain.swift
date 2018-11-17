//
//	ProductMain.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class ProductMain : NSObject {

	var productList : [Product]!
	
	init(fromDictionary dictionary: [String:Any]){
		productList = [Product]()
		if let arrArray = dictionary["product"] as? [[String:Any]]{
			for dic in arrArray{
				let value = Product(fromDictionary: dic)
				productList.append(value)
			}
		}
	}

}
