//
//  ImageUploader.swift
//  KILLFISH
//
//  Created by Матвей Кравцов on 10.02.16.
//  Copyright © 2016 Матвей Кравцов. All rights reserved.
//

import Foundation
import Alamofire

class ImageUploader{
    
    
    static func getOCR(image: UIImage, onCompletion: (NSDictionary) -> Void) {
        
        let str = "https://killfish.ru/app/"
        let imageData = UIImageJPEGRepresentation(image, 1)
        
        Alamofire.upload(.POST, str, multipartFormData: { multipartFormData in
            multipartFormData.appendBodyPart(
                data: "\(App.user.id)".dataUsingEncoding(NSUTF8StringEncoding)!,
                name: "id"
            )
            multipartFormData.appendBodyPart(
                data: App.user.authtoken.dataUsingEncoding(NSUTF8StringEncoding)!,
                name: "authtoken"
            )
            multipartFormData.appendBodyPart(
                data: "user.photo".dataUsingEncoding(NSUTF8StringEncoding)!,
                name: "action"
            )
            multipartFormData.appendBodyPart(
                data: imageData!,
                name: "photo",
                fileName: "photo.jpeg",
                mimeType: "image/jpeg"
            )
            }) { encodingResult in
                switch encodingResult {
                case .Success(let upload, _, _):
                    upload.responseJSON { JSON in
                        print(JSON)
                        
                        guard let responseData = JSON.data else {
                            print("Error: did not receive data")
                            return
                        }
                        
                        
                        let result: NSDictionary
                        do {
                            result = try NSJSONSerialization.JSONObjectWithData(responseData,
                                options: []) as! NSDictionary
                        } catch  {
                            print("error parsing response")
                            return
                        }
                        dispatch_async(dispatch_get_main_queue(),{
                            onCompletion(result)
                        } )
                        
                        
                        
                    }
                    
                case .Failure(let encodingError):
                    print(encodingError)
                }
        }
        
    }
    /*
    
    static func myImageUploadRequest(img: UIImage, onCompletion: (NSDictionary) -> Void)
    {
        let str = "https://killfish.ru/app/"
        
        let myUrl = NSURL(string: str);
        
        let request = NSMutableURLRequest(URL:myUrl!);
        request.HTTPMethod = "POST";
        
        let param = [
            "id"  : "\(App.user.id)",
            "authtoken"    : "\(App.user.authtoken)",
            "action" : "user.photo"
        ]
        
        let boundary = generateBoundaryString()
        
        //request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        let imageData = UIImageJPEGRepresentation(img, 1)
        
        if(imageData==nil)  { return; }
        
        request.HTTPBody = createBodyWithParameters(param, filePathKey: "photo", imageDataKey: imageData!, boundary: boundary)
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            guard error == nil else {
                print("error calling GET or POST")
                print(error)
                return
            }
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
            print("responseString = \(responseString)")
            
            let result: NSDictionary
            do {
                result = try NSJSONSerialization.JSONObjectWithData(responseData,
                    options: []) as! NSDictionary
            } catch  {
                print("error parsing response")
                return
            }
            dispatch_async(dispatch_get_main_queue(),{
                onCompletion(result)
            } )
        }
        
        task.resume()
        
    }
    
    
    static func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        let filename = "user-profile.jpg"
        
        let mimetype = "image/jpg"
        
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.appendData(imageDataKey)
        body.appendString("\r\n")
        
        
        
        body.appendString("--\(boundary)--\r\n")
        
        return body
    }
    
    
    
    
    static func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().UUIDString)"
    }
    
    */
 
    
}

extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
    }
}