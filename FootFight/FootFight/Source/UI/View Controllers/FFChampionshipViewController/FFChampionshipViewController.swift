//
//  FFChampionshipViewController.swift
//  FootFight
//
//  Created by Genek on 6/6/16.
//  Copyright © 2016 Genek. All rights reserved.
//

import UIKit
import CoreData
import ICSPullToRefresh

class FFChampionshipViewController: FFViewController,
                                    NSFetchedResultsControllerDelegate,
                                    UICollectionViewDataSource,
                                    UICollectionViewDelegate
{
    
    // MARK: - Accessors
    
    var mainView: FFChampionshipView? {
        guard let stagesView = self.view else {
            return nil
        }
        
        return stagesView as? FFChampionshipView
    }
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        let fetchRequest = NSFetchRequest(entityName: kFFStageEntityName)

        fetchRequest.predicate = NSPredicate(format: "championship == %@", argumentArray: [self.model!])
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: kFFStageIDKey, ascending: true)]
        
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
            return { [weak collectionView = self.mainView?.collectionView] in
                collectionView?.pullToRefreshView?.stopAnimating()
                collectionView?.infiniteScrollingView?.stopAnimating()
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
        
        self.setupCollectionView()
        
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            print("Fetch Error")
        }
        
        self.context = FFMatchesContext(model: self.model)
        
        self.updateTotalScore()
        
        guard let collectionView = self.mainView?.collectionView else {
            return
        }
        
        collectionView.addPullToRefreshHandler({ [weak self] in
            self?.context = FFMatchesContext(model: self?.model)
        })
        
        collectionView.addInfiniteScrollingWithHandler({ [weak self] in
            self?.context = FFMatchesContext(model: self?.model)
        })
    }
    
    // MARK: - User Interaction
    
    // MARK: - Public
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = self.fetchedResultsController.sections?[section] else {
            return 0
        }
        
        return section.numberOfObjects
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FFStageCell", forIndexPath: indexPath) as! FFStageCell
        
        let sections = self.fetchedResultsController.sections
        let section = sections![indexPath.section] as NSFetchedResultsSectionInfo
        let model = section.objects![indexPath.row] as! FFStage
        
        cell.model = model
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        guard let frame = self.mainView?.collectionView?.frame as CGRect? else {
            return CGSizeZero
        }
        
        return frame.size
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func        controller(controller: NSFetchedResultsController,
         didChangeSection sectionInfo: NSFetchedResultsSectionInfo,
                 atIndex sectionIndex: Int,
                   forChangeType type: NSFetchedResultsChangeType)
    {
        guard let collectionView = self.mainView?.collectionView else {
            return
        }
        
        switch(type) {
            case .Insert:
                collectionView.insertSections(NSIndexSet(index: sectionIndex))
            
            case .Delete:
                collectionView.deleteSections(NSIndexSet(index: sectionIndex))
            
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
        guard let collectionView = self.mainView?.collectionView else {
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
    
    func fillWithModel(model: FFUser!) -> () {
        self.mainView?.totalScoreLabel?.text = String(format: "Total score: %d", model.totalScore())
    }
    
    // MARK: - Private
    
    private func setupCollectionView() -> () {
        guard let mainView = self.mainView as FFChampionshipView? else {
            return
        }
        
        mainView.collectionView?.registerNib(UINib(nibName: "FFStageCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: "FFStageCell")
    }
    
    private func updateTotalScore() -> () {
        let user = FFUser.MR_findFirstOrCreateByAttribute(kFFUserIDKey, withValue: kFFUserID) as FFUser
        
        self.fillWithModel(user)
    }
}
