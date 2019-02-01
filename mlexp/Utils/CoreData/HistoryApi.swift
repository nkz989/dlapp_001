//
//  File.swift
//  mlexp
//
//  Created by zxj on 2019/2/1.
//  Copyright © 2019 Yamin Wei. All rights reserved.
//

import UIKit
import CoreData

final class HistoryApi {
    static let shared = HistoryApi()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    private init() {
        
    }
    
    func hasHistory(history: HistoryEntity) -> Bool {
        return false
        //        if (fromCity == nil || toCity == nil) {
        //            return NO;
        //        }
        //
        //        NSManagedObjectContext *context = [self.appDelegate managedObjectContext];
        //        NSFetchRequest *fetchRequest = [TCitySearchHistoryEntity fetchRequest];
        //        fetchRequest.fetchLimit = 1;
        //
        //        NSString *predicateString = [NSString stringWithFormat:@"fromCity like '%@' and toCity like '%@'", fromCity.r, toCity.r];
        //        NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
        //        [fetchRequest setPredicate:predicate];
        //
        //        NSArray *historyArray = [[self.appDelegate managedObjectContext] executeFetchRequest:fetchRequest error:nil];
        //        if (historyArray.count > 0) {
        //            //有数据时，更新修改时间
        //            TCitySearchHistoryEntity *data = [historyArray objectAtIndex:0];
        //            data.insertDate = [NSDate date];
        //            NSError *error = nil;
        //            if(![context save:&error]) {
        //                //DLog(@"coreData update is err ：%@",[error localizedDescription]);
        //            }
        //            return YES;
        //        }else{
        //            return NO;
        //        }
    }
    
    @discardableResult
    func save(trace: TraceData) -> Bool {
        do {
            let history = NSEntityDescription.insertNewObject(forEntityName: "HistoryEntity", into: managedObjectContext) as! HistoryEntity
            history.name = trace.name
            history.type = trace.type
            history.desc = trace.desc
            history.date = trace.date
            
            try managedObjectContext.save()
            return true
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    func loadTraces() -> [TraceData]? {
        let arr = self.load()
        guard let entityArr = arr else {
            return nil
        }
        
        var traceArr = [TraceData]()
        for entity in entityArr {
            let trace = TraceData(history: entity)
            traceArr.append(trace)
        }
        return traceArr
    }
    
    func load() -> [HistoryEntity]? {
        do {
            let request: NSFetchRequest<HistoryEntity> = HistoryEntity.fetchRequest()
            let historyArr = try managedObjectContext.fetch(request) as [HistoryEntity]
            return historyArr
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
    
    func clearHistory() {
        let arr = self.load()
        guard let entityArr = arr else {
            return
        }
        for history in entityArr {
            self.managedObjectContext.delete(history)
        }
        try? self.managedObjectContext.save()
    }
}
