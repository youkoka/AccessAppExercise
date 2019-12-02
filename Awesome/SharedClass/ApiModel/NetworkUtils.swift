//
//  NetworkUtils.swift
//  Awesome
//
//  Copyright © 2019 Awesome. All rights reserved.
//

import UIKit
import Alamofire

struct CustomPATCHEncoding: ParameterEncoding {
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        let mutableRequest = try! URLEncoding().encode(urlRequest, with: parameters) as? NSMutableURLRequest
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters!, options: .prettyPrinted)
            mutableRequest?.httpBody = jsonData
        } catch {
            print(error.localizedDescription)
        }
        
        return mutableRequest! as URLRequest
    }
}

class NetworkUtils: NSObject {
    
    /// get request method
    ///
    /// - Parameters:
    ///   - url: url descriptionurl
    ///   - headers: http header
    ///   - parameters: http body
    ///   - complete: callback(isSuccess, responseData)
    class func requestGet(_ url:String, _ headers:[String:String]? = nil, _ parameters:[String:Any]? = nil, _ complete: @escaping (_ success:Bool, _ statusCode:Int, _ responseData:Data?, _ error:String?) -> Void) {
    
        if !url.isEmpty {
            
            Alamofire.request(url, method: .get, parameters: parameters, encoding:URLEncoding.default , headers: headers).responseJSON { (dataResponse) in
                
                let statusCode = dataResponse.response?.statusCode ?? -1;
                
                switch statusCode {
                case 200:
                    complete(true, statusCode, dataResponse.data ?? nil, nil);
                case 400, 401:
                    complete(false, statusCode, dataResponse.data ?? nil, dataResponse.error?.localizedDescription);
                default:
                    let error = dataResponse.error;
                    complete(false, statusCode, dataResponse.data ?? nil, error?.localizedDescription);
                }
            }
        }
        else {
            
            complete(false, -1, nil, "format error");
        }
    }
    
    /// post request method
    ///
    /// - Parameters:
    ///   - url: url descriptionurl
    ///   - headers: http header
    ///   - parameters: http body
    ///   - complete: callback(isSuccess, responseData)
    class func requestPost(_ url:String, _ headers:[String:String]? = nil, _ parameters:[String:Any]? = nil, encoding:ParameterEncoding = JSONEncoding.default, _ complete: @escaping (_ success:Bool, _ statusCode:Int, _ response:NSDictionary, _ error:String?) -> Void) {
        if !url.isEmpty {
            Alamofire.request(url, method: .post, parameters: parameters, encoding:encoding , headers: headers).validate().responseJSON { (dataResponse) in
                
                let statusCode = dataResponse.response?.statusCode ?? -1;
                
                var responseData:NSDictionary?;
                var tokenInvalid:String?;
                if let data = dataResponse.data {
                    responseData = data.dataToDictionary() as NSDictionary;
                    tokenInvalid = String(decoding: data, as: UTF8.self);
                }
                switch statusCode {
                case 200:
                    complete(true, statusCode, responseData ?? [:], nil);
                case 400,401:
                    complete(false, statusCode, responseData ?? [:], tokenInvalid ?? dataResponse.error?.localizedDescription);
                default:
                    let error = dataResponse.error;
                    complete(false, statusCode, responseData ?? [:], error?.localizedDescription);
                }
                
                /*
                switch dataResponse.result {
                    
                case .success(let value):
                    
                    if statusCode == 200 ||  statusCode == 400 {
                        
                        let responseData = value as? NSDictionary ?? [:];
                        
                        complete(true, statusCode, responseData, nil);
                    }
                    else {
                        
                        let errorMsg = value as? String ?? "";
                        complete(false, statusCode, [:], errorMsg);
                    }
                    
                case .failure(let error):
                    
                    if statusCode == 400{
                        if let data = dataResponse.data {
                            let responseData = data.dataToDictionary() as NSDictionary;
                            print(responseData);
                            complete(false, statusCode, responseData, error.localizedDescription);
                        }
                    }else{
                        complete(false, statusCode, [:], error.localizedDescription);
                    }
                }*/
            }
        }
        else {
            
            complete(false, -1, [:], "format error");
        }
    }
    class func requestPatch(_ url:String, _ headers:[String:String]? = nil, _ parameters:[String:Any]? = nil, _ complete: @escaping (_ success:Bool, _ statusCode:Int, _ response:NSDictionary, _ error:String?) -> Void) {
        
        if !url.isEmpty {
            
            Alamofire.request(url, method: .patch, parameters: parameters, encoding:JSONEncoding.default , headers: headers).validate().responseJSON { (dataResponse) in
                
                let statusCode = dataResponse.response?.statusCode ?? -1;
                var responseData:NSDictionary?;
                var tokenInvalid:String?;
                if let data = dataResponse.data {
                    responseData = data.dataToDictionary() as NSDictionary;
                    tokenInvalid = String(decoding: data, as: UTF8.self);
                }
                switch statusCode {
                case 200:
                    complete(true, statusCode, responseData ?? [:], nil);
                case 400,401:
                    complete(false, statusCode, responseData ?? [:], tokenInvalid ?? dataResponse.error?.localizedDescription);
                default:
                    let error = dataResponse.error;
                    complete(false, statusCode, responseData ?? [:], error?.localizedDescription);
                }
            }
        }
        else {
            
            complete(false, -1, [:], "format error");
        }
    }
}
