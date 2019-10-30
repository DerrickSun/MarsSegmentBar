//
//  MarsSegmentBarViewController.swift
//  MarsSegmentBar
//
//  Created by sunxin on 2019/10/29.
//

import UIKit

public enum MarsSegmentBarPosition {
    case top;
    case navigation;
    case bottom;
}

open class MarsSegmentBarViewController: UIViewController {
    
    public func setup(items: Array<String>, childVCs: Array<UIViewController>, barHeight: CGFloat = 60, barPosition: MarsSegmentBarPosition = .top) {
        assert(items.count != 0 || items.count == childVCs.count, "个数不一致")
        self.barPosition = barPosition
        self.barHeight = barHeight
        segmentBar.items = items
        childViewControllers.forEach{ $0.removeFromParentViewController() }
        childVCs.forEach{ addChildViewController($0) }
        contentView.contentSize = CGSize(width: CGFloat(items.count) * self.view.width, height: 0)
        segmentBar.selectIndex = 0
    }
    
    var barPosition: MarsSegmentBarPosition = .top
    var barHeight: CGFloat = 60
    lazy var segmentBar: MarsSegmentBar = {
        let segmentBar = MarsSegmentBar()
        segmentBar.delegate = self
        return segmentBar
    }()
    
    lazy var contentView: UIScrollView = {
        let contentView: UIScrollView = UIScrollView()
        contentView.delegate = self
        contentView.isPagingEnabled = true
        return contentView
    }()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.edgesForExtendedLayout = UIRectEdge(rawValue: UIRectEdge.left.rawValue | UIRectEdge.bottom.rawValue | UIRectEdge.right.rawValue)
        view.backgroundColor = .white
        automaticallyAdjustsScrollViewInsets = false
        
        view.addSubview(contentView)
        var segmentBarY: CGFloat = 0
        switch barPosition {
        case .top:
            view.addSubview(segmentBar)
            if let navigation = self.navigationController {
                if ((self.navigationController != nil) && navigation.navigationBar.isTranslucent) {
                    segmentBarY = navigation.navigationBar.height + UIApplication.shared.statusBarFrame.height
                }
            }
        case .navigation:
            if let navigation = self.navigationController {
                navigation.navigationItem.titleView = segmentBar
                segmentBarY = 0
            } else {
                assertionFailure("当前控制器没有navigation")
            }
        case .bottom:
            view.addSubview(segmentBar)
            segmentBarY = view.height - barHeight
        }
        segmentBar.frame = CGRect(x: 0, y: segmentBarY, width: self.view.width, height: barHeight)
        let contentViewY = self.segmentBar.y + self.segmentBar.height
        let contentFrame = CGRect(x: 0, y: contentViewY, width: self.view.width, height: self.view.height - contentViewY)
        self.contentView.frame = contentFrame
        scrollViewDidEndDecelerating(self.contentView)
    }
    
    
    func showChildVCViews(AtIndex index: NSInteger) {
        if (self.childViewControllers.count == 0 || index < 0 || index > self.childViewControllers.count - 1) {
            return
        }
        let vc = childViewControllers[index]
        if vc.view.superview != contentView {
            contentView.setNeedsLayout()
            contentView.layoutIfNeeded()
            vc.view.frame = CGRect(x: CGFloat(index) * self.contentView.width, y: 0, width: self.contentView.width, height: self.contentView.height)
            contentView.addSubview(vc.view)
        }
        contentView.setContentOffset(CGPoint(x: CGFloat(index) * self.contentView.width, y: 0), animated: true)
    }
    
}

extension MarsSegmentBarViewController: MarsSegmentBarDelegate, UIScrollViewDelegate {
    
    //MARK: - Segment Delegate
    
    func marsSegmentBar(_ segmentBar: MarsSegmentBar, didSelectIndex index: NSInteger, fromIndex lastIndex: NSInteger) {
        showChildVCViews(AtIndex: index)
    }
    
    
    //MARK: - UIScrollViewDelegate
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = NSInteger(floor(contentView.contentOffset.x / contentView.width))
        self.segmentBar.selectIndex = index
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        scrollViewDidEndDecelerating(scrollView)
    }
    
}
