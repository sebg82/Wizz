//
//  TodaysListUseCase.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import Foundation

final class TodaysListUseCase {

    private let todaysList: TodaysListInterface

    init(_ todaysList: TodaysListInterface) {
        self.todaysList = todaysList
    }
    
    func fetch(_ completion: @escaping (Result<[PhotoEntity], Error>) -> Void) {
        todaysList.fetchTodaysList(completion)
    }
}
