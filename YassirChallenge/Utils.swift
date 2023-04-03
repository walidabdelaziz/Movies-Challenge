//
//  Utils.swift
//  YassirChallenge
//
//  Created by Walid Ahmed on 03/04/2023.
//

import Foundation
import SDWebImage
import NVActivityIndicatorView

class Utils{
    static var indicator: NVActivityIndicatorView?
    static func showLoader(_ view: UIView) {
        if indicator == nil {
            let width = view.frame.width * 0.2
            let frame = CGRect(origin: CGPoint(x: view.frame.midX - width / 2, y: view.frame.midY - width / 2),
                               size: CGSize(width: width, height: width))
            indicator = NVActivityIndicatorView(frame: frame, type: .ballSpinFadeLoader, color: .black, padding: 8)
            view.addSubview(indicator!)
        }

        indicator!.startAnimating()
    }
    
    static func hideLoader() {
        if indicator != nil {
            indicator?.stopAnimating()
            indicator = nil
        }
    }
    
    static func StringToDateThenToString(dateStr: String,oldFormat: String,newFormat: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = oldFormat
        let myDate = dateFormatter.date(from: dateStr) ?? Date()

        dateFormatter.dateFormat = newFormat
        let newdateString = dateFormatter.string(from: myDate)
        return newdateString
    }
}
