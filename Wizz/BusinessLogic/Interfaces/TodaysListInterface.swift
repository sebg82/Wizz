//
//  TodaysListInterface.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import Foundation

protocol TodaysListInterface {

    func fetchTodaysList(_ completion: @escaping (Result<[PhotoEntity], Error>) -> Void)
}
