//
//  User.swift
//  MVVM
//
//  Created by Ravi Kumar on 29/08/23.
//

import Foundation

struct UserData : Codable {
    let users: [User]
}

struct User : Codable {
    let id:Int
    let firstName:String
    let lastName:String
    let maidenName:String
    let age:Int
    let gender:String
    let email:String
    let phone:String
    let username:String
    let password:String
    let birthDate:String
    let image:String
    let bloodGroup:String
    let height:Int
    let weight:Float
    let eyeColor:String
    let hair:Hair
    let domain:String
    let ip:String
    let address:Address
    let macAddress:String
    let university:String
    let bank:Bank
    let company:Company
    let ein:String
    let ssn:String
    let userAgent:String
}

struct Hair : Codable {
    let color:String
    let type:String
}

struct Bank: Codable {
    let cardExpire:String
    let cardNumber:String
    let cardType:String
    let currency:String
    let iban:String
}

struct Address : Codable {
    let address:String
    let city:String
    let coordinates:Coordinate
    let postalCode:String
    let state:String
    
}

struct Coordinate: Codable{
    let lat:Double
    let lng:Double
}

struct Company: Codable{
//    let address:Address
    let department:String
    let name:String
    let title:String
}
