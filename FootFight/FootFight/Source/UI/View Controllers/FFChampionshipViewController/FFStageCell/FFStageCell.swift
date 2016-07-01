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
    
    var model: FFStage?

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
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.model?.matches?.count)!
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
                collectionView.insertItemsAtIndexPaths([newIndexPath])
            }
            
        case .Delete:
            if let indexPath = indexPath {
                collectionView.deleteItemsAtIndexPaths([indexPath])
            }
            
        case .Update:
            if let indexPath = indexPath {
                guard let cell = collectionView.cellForItemAtIndexPath(indexPath) as? FFStageCell else {
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
                    collectionView.deleteItemsAtIndexPaths([indexPath])
                    collectionView.insertItemsAtIndexPaths([newIndexPath])
                }
            }
        }
        
        //        self.updateTotalScore()
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        
    }

}
