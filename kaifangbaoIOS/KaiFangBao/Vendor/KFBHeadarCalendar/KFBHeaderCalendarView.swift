//
//  KFBHeaderCalendarView.swift
//  KFBHeaderCalendarView
//
//  Created by wuhongshuai on 16/4/12.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

protocol KFBHeaderCalendarViewDelegate:NSObjectProtocol {
    func didClickHeaderCalendarViewItem(item:String) -> Void
    func didScrollToDate(date:NSDate) -> Void
}

class KFBHeaderCalendarView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    weak var delegate:KFBHeaderCalendarViewDelegate?
    private let collectionViewLayout: KFBHorizontalLinearFlowLayout = {
        let layout = KFBHorizontalLinearFlowLayout()
        layout.scrollDirection = .Horizontal
        layout.minimumLineSpacing = (UIScreen.mainScreen().bounds.width-274)/2
        layout.itemSize = CGSizeMake(102, 112)
        return layout
    }()
    private let DaysFromMininumDate:Int = {
        let component:NSDateComponents = NSCalendar.fs_sharedCalendar().components(NSCalendarUnit.Day, fromDate: KFBUtility.KFBMinimumDate, toDate: NSDate(), options:[])
        return component.day+1
    }()
    private var currentPage = 0
    private var collectionView:UICollectionView!
    private var pageWidth: CGFloat {
        return self.collectionViewLayout.itemSize.width + self.collectionViewLayout.minimumLineSpacing
    }
    
    private var contentOffset: CGFloat {
        return self.collectionView.contentOffset.x + self.collectionView.contentInset.left
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.configureCollectioView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("error occurred in creating KFBHeaderCalendarView within init?(coder aDecoder: NSCoder)")
    }
    
    private func configureCollectioView() ->Void{
        self.collectionView = UICollectionView(frame: CGRectMake(0, 0, self.width, self.height), collectionViewLayout: self.collectionViewLayout)
        self.collectionView.directionalLockEnabled = true
        self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast
        self.collectionView.registerClass(KFBHeaderCalendarCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        self.collectionView.backgroundColor = UIColor.clearColor()
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.addSubview(self.collectionView)
    }
    
    func scrollToPage(page: Int, animated: Bool) {
        if animated {
            self.collectionView.userInteractionEnabled = false
        }else{
            self.collectionView.userInteractionEnabled = true
        }
        let pageOffset = CGFloat(page) * self.pageWidth - self.collectionView.contentInset.left
        self.collectionView.setContentOffset(CGPointMake(pageOffset, 0), animated: animated)
        self.currentPage = page
    }
    func scrollToToday() -> Void{
        self.scrollToPage(self.DaysFromMininumDate-1, animated: false)
    }
    
    func scrollToDate(date:NSDate, animated:Bool) ->Void{
        let component:NSDateComponents = NSCalendar.fs_sharedCalendar().components(NSCalendarUnit.Day, fromDate: KFBUtility.KFBMinimumDate, toDate: date, options:[])
        self.scrollToPage(component.day, animated: animated)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.DaysFromMininumDate
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! KFBHeaderCalendarCell
        return collectionViewCell
    }
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let tempCell = cell as! KFBHeaderCalendarCell
        tempCell.date = KFBUtility.KFBMinimumDate.fs_dateByAddingDays(indexPath.row)
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if collectionView.dragging || collectionView.decelerating || collectionView.tracking {
            return
        }
        let selectedPage = indexPath.row
        if selectedPage == self.currentPage {
            self.delegate?.didClickHeaderCalendarViewItem("sucks")
            NSLog("Did select center item")
        }
        else {
            self.scrollToPage(selectedPage, animated: true)
        }
    }
    //不使用动画是就不会触发，如直接设置contentoffsetx
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.collectionView.userInteractionEnabled = true
        self.currentPage = Int(self.contentOffset / self.pageWidth)
        let date = KFBUtility.KFBMinimumDate.fs_dateByAddingDays(self.currentPage)
//        print(self.currentPage)
//        print(date)
        self.delegate?.didScrollToDate(date)
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        self.collectionView.userInteractionEnabled = true
        let date = KFBUtility.KFBMinimumDate.fs_dateByAddingDays(self.currentPage)
//        print(self.currentPage)
//        print(date)
        self.delegate?.didScrollToDate(date)
    }
    //滚动结束时，获取当前cell， 可以改变当前cell的所有属性
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//        for cell in self.collectionView.visibleCells() as! [KFBHeaderCalendarCell] {
//            let indexPath = self.collectionView.indexPathForCell(cell)!
//            let attributes = self.collectionView.layoutAttributesForItemAtIndexPath(indexPath)!
//            let cellRect = attributes.frame
//            let cellFrameInSuperview = self.collectionView.convertRect(cellRect, toView: self.collectionView.superview)
//            let centerOffset = cellFrameInSuperview.origin.x - self.collectionView.contentInset.left
//            if centerOffset > UIScreen.mainScreen().bounds.width/4 || centerOffset < 0{
//                cell.backgroundColor = UIColor.redColor()
//            }else{
//                cell.backgroundColor = UIColor.yellowColor()
//            }
//        }
//    }
}
