//
//  UIImageView+Extension.swift
//  SampleNewsApplication
//
//  Created by Damotharan KG on 11/02/25.
//
import Foundation
import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
class DateFormatChanges {
    func dateFormatChange(value: String) -> String{
        var formattedDateTime = ""
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        inputFormatter.timeZone = TimeZone(abbreviation: "UTC")

        if let date = inputFormatter.date(from: value) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            outputFormatter.timeZone = TimeZone.current
            
            formattedDateTime = outputFormatter.string(from: date)
        }
        return formattedDateTime
    }
}
