//
//	Arr.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class Product : NSObject{

	var name : String!
	var pid : String!
	var price : String!

    init(fromDictionary dictionary: [String:Any]){
		name = dictionary["name"] as? String
		pid = dictionary["pid"] as? String
		price = dictionary["price"] as? String
	}
}
