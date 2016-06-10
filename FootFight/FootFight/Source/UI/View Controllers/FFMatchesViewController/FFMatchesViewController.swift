//
//  FFMatchesViewController.swift
//  FootFight
//
//  Created by Genek on 6/6/16.
//  Copyright © 2016 Genek. All rights reserved.
//

import UIKit

class FFMatchesViewController: FFViewController,
                                NSFetchedResultsControllerDelegate,
                                UITableViewDataSource,
                                UITableViewDelegate
{
    
    // MARK: - Accessors
    
    var mainView: FFMatchesView? {
        guard let matchesView = self.view else {
            return nil
        }
        
        return matchesView as? FFMatchesView
    }
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        let fetchRequest = NSFetchRequest(entityName: kFFMatchEntityName)

        fetchRequest.sortDescriptors = [NSSortDescriptor(key: kFFMatchDateKey, ascending: true)]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: NSManagedObjectContext.MR_defaultContext(),
                                                                  sectionNameKeyPath: kFFMatchdayKey,
                                                                  cacheName: nil)
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    override var contextWillLoadHandler: FFNotificationHandler! {
        get {
            return {
                print("context Will Load")
            }
        }
        set(newValue) {}
    }
    
    override var contextDidLoadHandler: FFNotificationHandler! {
        get {
            return {
                
            }
        }
        set(newValue) {}
    }
    
    override var contextDidFailHandler: FFNotificationHandler! {
        get {
            return {
                print("context Did Fail")
            }
        }
        set(newValue) {}
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            print("Error")
        }
        
//        self.context = FFMatchesContext()
    }
    
    // MARK: - User Interaction
    
    // MARK: - Public
    
    // MARK: - UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let sections = self.fetchedResultsController.sections {
            return sections.count
        }
        
        return 0;
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sectionInfo = self.fetchedResultsController.sections?[section] else {
            return nil
        }
        
        let model = sectionInfo.objects?.first as! FFMatch        
        let title = model.matchType as String
        
        return title
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = self.fetchedResultsController.sections?[section] else {
            return 0
        }
        
        return section.numberOfObjects
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let matchCell = tableView.dequeueReusableCellWithIdentifier("FFMatchCell") as! FFMatchCell
        
        let sections = self.fetchedResultsController.sections
        let section = sections![indexPath.section] as NSFetchedResultsSectionInfo
        let model = section.objects![indexPath.row] as! FFMatch

        matchCell.fillWithModel(model)
        
        return matchCell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func        controller(controller: NSFetchedResultsController,
         didChangeSection sectionInfo: NSFetchedResultsSectionInfo,
                 atIndex sectionIndex: Int,
                   forChangeType type: NSFetchedResultsChangeType)
    {
        guard let tableView = self.mainView?.tableView else {
            return
        }
        
        switch(type) {
            case .Insert:
                tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: UITableViewRowAnimation.Fade)
            
            case .Delete:
                tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: UITableViewRowAnimation.Fade)
            
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
        guard let tableView = self.mainView?.tableView else {
            return
        }
        
        switch(type) {
            case .Insert:
                if let newIndexPath = newIndexPath {
                    tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation:UITableViewRowAnimation.Fade)
                }
            
            case .Delete:
                if let indexPath = indexPath {
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                }
            
            case .Update:
                if let indexPath = indexPath {
                    guard let cell = tableView.cellForRowAtIndexPath(indexPath) as? FFMatchCell else {
                        return
                    }
                    
                    let sections = self.fetchedResultsController.sections
                    let section = sections![indexPath.section] as NSFetchedResultsSectionInfo
                    let model = section.objects![indexPath.row] as! FFMatch
                    
                    cell.fillWithModel(model)
                }
            
            case .Move:
                if let indexPath = indexPath {
                    if let newIndexPath = newIndexPath {
                        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                        tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                    }
                }
        }
        
        let user = FFUser.MR_findFirstOrCreateByAttribute(kFFMatchIDKey, withValue: kFFUserID) as FFUser
        
        self.fillWithModel(user)
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.mainView?.tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.mainView?.tableView.endUpdates()
    }
    
    func fillWithModel(model: FFUser!) -> () {
        self.mainView?.totalScoreLabel?.text = String(format: "Total score: %d", model.totalScore())
    }
}
