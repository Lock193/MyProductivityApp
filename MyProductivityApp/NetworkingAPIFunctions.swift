//
//  NetworkingAPIFunctions.swift
//  MyProductivityApp
//
//  Created by Yevhenii Shypitsyn on 3/18/22.
//

import Foundation
import Alamofire

//MARK: - Custom Notes Struct
struct Note:Decodable {
    var title: String
    var date: String
    var _id: String
    var note: String
    var folder: String
}

//MARK: - FUnctions that interact with API
class NetworkingAPIFunctions{
    
    //sets our custom data delegate
    var delegate: DataDelegate?
    //Creates an instance of the class so the other files can interact with it
    static let functions = NetworkingAPIFunctions()
    
    // Login request database
    func login(username:String, password:String) {
        AF.request("http://192.168.86.250:8081/login", method: .post, encoding: URLEncoding.httpBody, headers: ["username":username, "password":password]).responseString{
            responce in
            var data = ""
            if responce.data == nil {
                LoginController.serverUnavailable()
            } else {
                data = String(data: responce.data!, encoding: .utf8)!
                if data != "Failed" {
                    //Password correct, assign unique user id
                    DataManager.userId = String(data.dropFirst(1).dropLast(1))
                    LoginController.passwordCorrect()
                } else {
                    LoginController.passwordIncorrect()
                }
                
            }
            
        }
        
    }
    
    // Fetches notes from database
    func fetchNotes(userId:String) {
        AF.request("http://192.168.86.250:8081/fetch", method: .post, encoding:URLEncoding.httpBody, headers:["user_id":userId]).responseString{
            responce in
            let data = String(data: responce.data!, encoding: .utf8)
            print(responce.data)
            //fires off the custom delegate in the view controller
            self.delegate?.updateArray(newArray: data!)
        }
        
    }
    
    // Adds a note to the server, passing the arguments as headers
    func AddNote(date:String, title:String, note:String, folder:String, userId:String){
        AF.request("http://192.168.86.250:8081/create", method: .post, encoding: URLEncoding.httpBody, headers: ["title":title, "date":date, "note":note, "folder":folder, "user_id":userId]).responseString{
            responce in
            
            print(responce)
        }
        
    }
    
    // Updates a note to the server, passing the arguments as headers
    func updateNote(date:String, title:String, note:String, id:String, folder:String, userId:String){
        AF.request("http://192.168.86.250:8081/update", method:.post, encoding: URLEncoding.httpBody, headers: ["title":title, "date":date, "note":note, "id":id, "folder":folder, "user_id":userId]).responseString{
            responce in
            print(responce)
        }
    }
    
    // Deletes a note to the server, passing the note id as header
    func deleteNote(id:String, userId:String){
        AF.request("http://192.168.86.250:8081/delete", method:.post, encoding: URLEncoding.httpBody, headers: ["id":id, "user_id":userId]).responseString{
            responce in
            print(responce)
        }
    }
    
}
