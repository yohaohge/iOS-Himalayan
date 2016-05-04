//
//  UITableView+EmptySet.swift
//  KaiFangBao
//
//  Created by ysjjchh on 16/3/24.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import Foundation

extension UITableView: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    private static var hasInitializedKey = "kHasInitializedKey".cStringUsingEncoding(NSUTF8StringEncoding)!
    
    func setupEmptyView() {
        self.emptyDataSetSource = self
        self.emptyDataSetDelegate = self
        
        objc_setAssociatedObject(self, UITableView.hasInitializedKey, false, .OBJC_ASSOCIATION_ASSIGN)
    }
    
    public func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "暂无数据",
                                  attributes: [NSFontAttributeName: UIFont.systemFontOfSize(16)])
    }
    
    public func verticalOffsetForEmptyDataSet(scrollView: UIScrollView!) -> CGFloat {
        return -20
    }
    
    public func emptyDataSetShouldAllowScroll(scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    public func emptyDataSetShouldDisplay(scrollView: UIScrollView!) -> Bool {
        let hasInit = objc_getAssociatedObject(self, UITableView.hasInitializedKey) as? Bool
        if (hasInit != nil) {
            
            guard hasInit! else {
                objc_setAssociatedObject(self, UITableView.hasInitializedKey, true, .OBJC_ASSOCIATION_ASSIGN)
                return false
            }
        }
        
        return true
    }
    
    public func imageForEmptyDataSet(scrollView:UIScrollView) -> UIImage
    {
        return UIImage.init(named:"ic_nodata")!
    }
}