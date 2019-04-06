//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import Foundation

extension Date
{
    func toString(dateFormat format: String,timeZone: TimeZone? = nil,local: Locale? = nil)-> String?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        if let t = timeZone {
            dateFormatter.timeZone = t
        }
        
        if let l = local {
            dateFormatter.locale = l
        }
        
        return dateFormatter.string(from: self)
    }
    
    func getNextDate(byAdding dateComponent: Calendar.Component, value: Int)-> Date?{
        let nexDate = Calendar.current.date(byAdding: dateComponent, value: value, to: self)
        return nexDate
    }
    
    func getDayDifference(estimate day: Int)-> DateComponents?{
        let calendar = Calendar(identifier: .gregorian)
        guard let nextDay = calendar.date(byAdding: .day, value: day, to: self) else {
            return nil
        }
        
        let today = Date()
        let components = calendar.dateComponents([.hour,.minute,.month,.year,.day], from: today)
        let finishDateComponents = calendar.dateComponents([.hour,.minute,.month,.year,.day], from: nextDay)
        let dayDifference = calendar.dateComponents([.day, .hour, .minute], from: components, to: finishDateComponents)
        return dayDifference
    }
}
