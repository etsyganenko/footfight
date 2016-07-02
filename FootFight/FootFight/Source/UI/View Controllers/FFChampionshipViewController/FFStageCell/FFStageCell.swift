//
//  FFStageCell.swift
//  FootFight
//
//  Created by Artem on 6/23/16.
//  Copyright © 2016 Genek. All rights reserved.
//

import UIKit
import CoreData

class FFStageCell: UICollectionViewCell,
                    UITableViewDataSource,
                    UITableViewDelegate,
                    NSFetchedResultsControllerDelegate
{
    
    // MARK: - Accessors
    
    var model: FFStage? {
        willSet(newValue) {
            
        }
        didSet(oldValue) {
            do {
                try self.fetchedResultsController.performFetch()
            } catch {}
        }
    }

    @IBOutlet var tableView: UITableView?
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        let fetchRequest = NSFetchRequest(entityName: kFFMatchEntityName)

        fetchRequest.predicate = NSPredicate(format: "stage == %@", argumentArray: [self.model!])
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: kFFMatchDateKey, ascending: true),
                                        NSSortDescriptor(key: kFFMatchIDKey, ascending: true)]

        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: NSManagedObjectContext.MR_defaultContext(),
                                                                  sectionNameKeyPath: nil,
                                                                  cacheName: nil)
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    // MARK: - View Lifecycle
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = self.fetchedResultsController.sections?[section] else {
            return 0
        }
        
        return section.numberOfObjects
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("FFMatchCell") as? FFMatchCell
        if nil == cell {
            cell = NSBundle.mainBundle().loadNibNamed("FFMatchCell", owner: nil, options: nil).first as? FFMatchCell
        }
        
        if let model = self.model?.matches?[indexPath.row] as? FFMatch {
            cell!.fillWithModel(model)
            cell!.predictionButtonHandler = { () -> () in
                let rootViewController = UIApplication.sharedApplication().delegate?.window??.rootViewController
                
                FFPredictionAlertViewController.showPredictionAlertOnController(rootViewController!, with: model)
            }
        }
        
        return cell!
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //        tableView.estimatedRowHeight = 50.0
        //
        //        return UITableViewAutomaticDimension
        return 120.0
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func        controller(controller: NSFetchedResultsController,
                           didChangeSection sectionInfo: NSFetchedResultsSectionInfo,
                                            atIndex sectionIndex: Int,
                                                    forChangeType type: NSFetchedResultsChangeType)
    {
        guard let tableView = self.tableView else {
            return
        }
        
        switch(type) {
        case .Insert:
            tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
            
        case .Delete:
            tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
            
        default:
            break
        }
    }
    
    func        controller(controller: NSFetchedResultsController,
                           didChangeObject anObject: AnyObject,
                                           atIndexPath indexPath: NSIndexPath?,
                                                       forChangeType type: NSFetchedResultsChangeType,
                                                                     newIndexPath: NSIndexPath?)
    {
        guard let tableView = self.tableView else {
            return
        }
        
        switch(type) {
        case .Insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Fade)
            }
            
        case .Delete:
            if let indexPath = indexPath {
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
            
        case .Update:
            if let indexPath = indexPath {
                guard let cell = tableView.cellForRowAtIndexPath(indexPath) as? FFMatchCell else {
                    return
                }
                
                let sections = self.fetchedResultsController.sections
                let section = sections![indexPath.section] as NSFetchedResultsSectionInfo
                //                    let model = section.objects![indexPath.row] as! FFMatch
                //
                //                    cell.fillWithModel(model)
            }
            
        case .Move:
            if let indexPath = indexPath {
                if let newIndexPath = newIndexPath {
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                    tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Fade)
                }
            }
        }
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView?.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView?.endUpdates()
    }

}
