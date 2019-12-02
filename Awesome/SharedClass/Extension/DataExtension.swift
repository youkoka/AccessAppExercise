//
//  DataExtension.swift
//  Awesome
//
//  Created by colt on 2019/12/2.
//  Copyright © 2019 colt. All rights reserved.
//

import Foundation

public extension Data {
    
    func dataToDictionary()->Dictionary<String, Any> {
        do{
            let json = try JSONSerialization.jsonObject(with: self, options: .mutableContainers)
            let dic = json as! Dictionary<String, Any>
            return dic;
        }catch _ {
            
            return [:];
        }
    }
    
    func dataToArray()->Array<Any> {
        
        do{
            let json = try JSONSerialization.jsonObject(with: self, options: .mutableContainers)
            let array = json as! Array<Any>
            return array;
        }catch _ {
            
            return [];
        }
    }
}
