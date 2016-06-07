//
//  FFMatchesViewController.swift
//  FootFight
//
//  Created by Artem on 6/6/16.
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

        fetchRequest.sortDescriptors = [NSSortDescriptor(key: kFFDateKey, ascending: true)]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: NSManagedObjectContext.MR_defaultContext(),
                                                                  sectionNameKeyPath: nil,
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
        
        self.context = FFMatchesContext()
        
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            print("Error")
        }
    }
    
    // MARK: - User Interaction
    
    // MARK: - Public
    
    // MARK: - UITableViewDataSource
    
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
    
}
