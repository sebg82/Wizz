//
//  SavePhotosInterface.swift
//  Wizz
//
//  Created by Sebastien Gohier on 31/12/2021.
//

import Foundation

protocol SavePhotosInterface {
    func savePhotos(_ photos: [PhotoEntity]) throws
    func saveUserPhotos(_ photos: [PhotoEntity]) throws
    func savePhotoStatistics(_ statistics: PhotoStatisticsEntity) throws
    func saveSearchPhotos(_ photos: [PhotoEntity]) throws
}
