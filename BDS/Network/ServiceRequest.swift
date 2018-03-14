//
//  ServiceRequest.swift
//  CallDocter
//
//  Created by DevOminext on 6/5/17.
//  Copyright © 2017 HuyDuy. All rights reserved.
//

import UIKit

class ServiceRequest: NSObject {

    class func sendRequest(urlStr: String, completion: @escaping (Bool, AnyObject) -> ()) {
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: urlStr)!

        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in

            if error != nil {

                print(error!.localizedDescription)
                completion(false, error as AnyObject)

            } else {
                do {

                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
                        {
                        //Implement your logic
                        print(json)
                        completion(true, json as AnyObject)
                    }

                } catch {

                    print("error in JSONSerialization")
                    completion(false, "error in JSONSerialization" as AnyObject)
                }
            }

        })
        task.resume()

    }

    class func sendPostRequest(urlStr: String, params: Dictionary<String, Any>?, completion: @escaping (Bool, AnyObject?, String?) -> ()) {


        let url = URL(string: urlStr)!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        //add user token for post offline message
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        //add params
        var paramString = ""
        if let params = params {

            for (key, value) in params {

                paramString = "\(paramString)&\(key)=\(value)"

            }

        }

        request.httpBody = paramString.data(using: String.Encoding.utf8)

        // send request
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in

            guard let data = data, error == nil else {
                completion(false, nil, error?.localizedDescription)
                return
            }

            completion(true, data as AnyObject, nil)

        }

        task.resume()

    }

    class func sendPostUserRequest(urlStr: String, params: Dictionary<String, Any>?, completion: @escaping (Bool, AnyObject?, String?) -> ()) {

        let url = URL(string: urlStr)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        //add user token for post offline message
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //add params
        var paramString = ""
        if let params = params {
            for (key, value) in params {
                paramString = "\(paramString)&\(key)=\(value)"
            }
        }

        request.httpBody = paramString.data(using: String.Encoding.utf8)

        // send request
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in

            guard let data = data, error == nil else {
                completion(false, nil, error?.localizedDescription)
                return
            }
            completion(true, data as AnyObject, nil)
        }
        task.resume()
    }


    class func sendGetRequest(urlStr: String, params: Dictionary<String, Any>?, completion: @escaping (Bool, AnyObject?, String?) -> ()) {

        //add params
        var url: URL
        var paramString = ""
        if let params = params {
            for (key, value) in params {
                paramString = "\(paramString)&\(key)=\(value)"
            }
            url = URL(string: urlStr + "?" + paramString)!
        } else {
            url = URL(string: urlStr)!
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        //add header

        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in

            guard let data = data, error == nil else {
                completion(false, nil, error?.localizedDescription)
                return
            }
            completion(true, data as AnyObject, nil)
        }
        task.resume()
    }

    class func uploadRequest(urlString: String, image: UIImage, completion: @escaping (Bool, AnyObject?, String?) -> ())
    {
        let url = URL(string: urlString)

        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(NSUUID().uuidString)"

        //define the multipart request type

        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        let image_data = UIImagePNGRepresentation(image)


        if(image_data == nil)
        {
            completion(false, nil, "nil image")
            return
        }

        var body = Data()

        let fname = "imageName"
        let mimetype = "image/png"

        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"photo\"; filename=\"\(fname)\"\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append(image_data!)

        body.append("\r\n".data(using: String.Encoding.utf8)!)

        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)

        request.httpBody = body

        let session = URLSession.shared

        let task = session.dataTask(with: request) {
            (
                data, response, error) in

            guard let data = data, error == nil else {
                completion(false, nil, error?.localizedDescription)
                return
            }

            completion(true, data as AnyObject, nil)

        }
        task.resume()
    }
    
    class func uploadRequestImage(urlString: String,filename:String, image: UIImage?, params: Dictionary<String, Any>, completion: @escaping (Bool, AnyObject?, String?) -> ())
    {
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
    
        let boundary = "Boundary-\(NSUUID().uuidString)"
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let image_data = UIImagePNGRepresentation(image!)
        if(image_data == nil)
        {
            completion(false, nil, "nil image")
            return
        }
        
        
        var body = Data()
        
        let fname = "file.png"
        let mimetype = "image/png"
        
        //define the data post parameter
        
        for (key, value) in params {
            
            body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
            body.append("Content-Disposition:form-data; name=\"\(key)\"\r\n\r\n".data(using: String.Encoding.utf8)!)
            body.append("\(value)\r\n".data(using: String.Encoding.utf8)!)
        }
        
        //params for image
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"\(filename)\"; filename=\"\(fname)\"\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append(image_data!)
        
        body.append("\r\n".data(using: String.Encoding.utf8)!)
        
        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
        
        request.httpBody = body
        
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) {
            (
            data, response, error) in
            
            guard let data = data, error == nil else {
                completion(false, nil, error?.localizedDescription)
                return
            }
            
            completion(true, data as AnyObject, nil)
            
        }
        task.resume()
    }

}

