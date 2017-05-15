//
//  GetHealthData.swift
//  Together
//
//  Created by Yang Li on 28/04/2017.
//  Copyright © 2017 Yang Li. All rights reserved.
//

import Foundation
import HealthKit
import Alamofire

func getHealthData() {
//  var healthTime = UserDefaults.standard
//  let uploadComponents = NSCalendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: <#T##Date#>)
//  let uploadTime = NSCalendar.current.date(from: <#T##DateComponents#>)
  
  var healthStore: HKHealthStore?
  if HKHealthStore.isHealthDataAvailable() {
    healthStore = HKHealthStore()
    let heartRateType: HKQuantityType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
    var heartRateQuery: HKSampleQuery?
    let heartRateUnit: HKUnit = HKUnit(from: "count/min")
    let stepsType: HKQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
    
    let readingTypes: Set = Set([heartRateType, stepsType])
    healthStore?.requestAuthorization(toShare: nil, read: readingTypes, completion: { (success, error) -> Void in
      if !success {
        print("error")
      }
    })
    
    let calender = NSCalendar.current
    let now = Date()
    let components = calender.dateComponents([.year, .month, .day], from: now)
    guard let startDate = calender.date(from: components) else { return }
    let endDate = calender.date(byAdding: .day, value: 1, to: startDate)
    let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: [])
    let sortDescriptor = [NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)]
    heartRateQuery = HKSampleQuery(sampleType: heartRateType, predicate: predicate, limit: 1000, sortDescriptors: sortDescriptor, resultsHandler: { (query:HKSampleQuery, result:[HKSample]?, error:Error?) -> Void in
      guard error == nil else { print("error"); return }
      var arrDict = [Dictionary<String, Any>]()
      for iter in 0 ..< result!.count {
        guard let currData:HKQuantitySample = result![iter] as? HKQuantitySample else { return }
        let dict = ["number":Double(currData.quantity.doubleValue(for: heartRateUnit)), "date": String(describing: currData.startDate)] as [String : Any]
        print(dict)
        arrDict.append(dict)
        
      }
      let patameters : Parameters = ["heartbeat":arrDict, "step": []]
      _ = Alamofire.request("http://10.0.1.8:3000/api/healthy?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhY2NvdW50IjoidGVzdCIsInBhc3N3b3JkIjoicSIsImRhdGUiOiIxNDkzMjA1MDgyNDI2IiwiaWF0IjoxNDkzMjA1MDgyfQ.LII_SHxwoQ0lTiTu-bVnF2hZLxhVMHmR3XtwN6v4ELs", method: .post, parameters: patameters, encoding: JSONEncoding.default)
    })
    healthStore?.execute(heartRateQuery!)
    
    let interval:NSDateComponents = NSDateComponents()
    interval.day = 1
    let stepsQuery = HKStatisticsCollectionQuery(quantityType: stepsType, quantitySamplePredicate: predicate, options: [.cumulativeSum], anchorDate: startDate as Date, intervalComponents: interval as DateComponents)
    stepsQuery.initialResultsHandler = { query, result, error in
      if error != nil {
        print(error!)
        return
      }
      result?.enumerateStatistics(from: startDate as Date, to: endDate!, with: { (statistics, stop) in
        if let quantity = statistics.sumQuantity() {
          let steps = quantity.doubleValue(for: HKUnit.count())

          print("Steps = \(steps)")
        }
      })
    }
    healthStore?.execute(stepsQuery)
  }
}
