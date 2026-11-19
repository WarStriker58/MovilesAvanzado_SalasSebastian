//
//  User.swift
//  Semana13_MetodosAPI
//
// Utilizando los métodos POST - PUT - DELETE

import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let email: String
}
