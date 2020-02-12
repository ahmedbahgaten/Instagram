 //
//  Extention.swift
//  Instagram
//
//  Created by AHMED on 1/11/20.
//  Copyright © 2020 AHMED. All rights reserved.
//

import Foundation
import UIKit
 
 extension UIColor {
    static func rgb (red:CGFloat, green:CGFloat, blue:CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
 }
 extension Date {
    func timeAgoDisplay () -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        let month = 4 * week
        let quotient:Int
        let unit:String
        if secondsAgo < minute {
            quotient = secondsAgo
            unit = "second"
        } else if secondsAgo < hour {
            quotient = secondsAgo / minute
            unit = "min"
        } else if secondsAgo < day {
            quotient = secondsAgo / hour
            unit = "hour"
        }else if secondsAgo < week {
            unit = "day"
            quotient = secondsAgo / day
        }else if secondsAgo < month {
            quotient = secondsAgo / week
            unit = "week"
        }else {
            quotient = secondsAgo / month
            unit = "month"
        }
        return "\(quotient) \(unit) \(quotient == 1 ? "" : "s") ago"
    }
 }
