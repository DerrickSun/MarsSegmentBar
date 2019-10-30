//
//  MarsSegmentBar.swift
//  MarsSegmentBar
//
//  Created by sunxin on 2019/10/28.
//

import UIKit

protocol MarsSegmentBarDelegate: class {
    func marsSegmentBar(_ segmentBar: MarsSegmentBar, didSelectIndex index: NSInteger, fromIndex lastIndex: NSInteger)
}

private let kMinMargin: CGFloat = 30

class MarsSegmentBar: UIView {
    
    public weak var delegate: MarsSegmentBarDelegate?
    
    public var items: Array<String>? {
        didSet {
            self.updateItems()
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
   
    var selectIndex: NSInteger {
        set(newIndex) {
            if (self.itemBtns.count == 0 || selectIndex < 0 || selectIndex > self.itemBtns.count - 1) {
                return;
            }
            _selectIndex = newIndex
            let btn = itemBtns[self.selectIndex]
            buttonClick(sender: btn)
        }
        get {
            return _selectIndex
        }
    }
    private var _selectIndex: NSInteger = 0
    private var lastBtn: UIButton?
    
    lazy var contentView: UIScrollView = {
        let contentView = UIScrollView()
        contentView.showsHorizontalScrollIndicator = false
        addSubview(contentView)
        return contentView
    }()
    
    lazy var indicatorView: UIView = {
        let indicatorHeight = self.config.indicatorHeight
        let indicatorView = UIView.init(frame: CGRect(x: 0, y: self.height - indicatorHeight, width: 0, height: indicatorHeight))
        indicatorView.backgroundColor = self.config.indicatorColor;
        addSubview(indicatorView)
        return indicatorView;
    }()

    lazy var config: MarsSegmentConfig = {
        let config = MarsSegmentConfig.defaultConfig
        return config
    }()
    private var itemBtns: Array<UIButton> = []
    
    @objc func buttonClick(sender: UIButton) {
        self.delegate?.marsSegmentBar(self, didSelectIndex: sender.tag, fromIndex: lastBtn?.tag ?? 0)
        _selectIndex = sender.tag
        lastBtn?.isSelected = false
        sender.isSelected = true
        lastBtn = sender
        UIView.animate(withDuration: 0.1) {
            self.indicatorView.width = sender.width + self.config.indicatorExtraW * 2
            self.indicatorView.centerX = sender.centerX
        }
        // 1. 滚动到btn的位置
        var scrollX: CGFloat = sender.centerX - self.contentView.width * 0.5;
        if (scrollX < 0) {
            scrollX = 0
        }
        if (scrollX > self.contentView.contentSize.width - self.contentView.width) {
            scrollX = self.contentView.contentSize.width - self.contentView.width
        }
        self.contentView.setContentOffset(CGPoint(x: scrollX, y: 0), animated: true)

    }

}

extension MarsSegmentBar: UITableViewDelegate{
    
    func updateItems(){
        for item in itemBtns {
            item.removeFromSuperview()
        }
        self.itemBtns = []
        
        guard let items = self.items else { return }
        for index in 0..<items.count {
            let btn = UIButton()
            btn.tag = index
            btn.setTitle(items[index], for: .normal)
            btn.setTitleColor(self.config.itemNormalColor, for: .normal)
            btn.setTitleColor(self.config.itemSelectColor, for: .selected)
            btn.addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
            self.contentView.addSubview(btn)
            self.itemBtns.append(btn)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = self.bounds
        var totalBtnWidth: CGFloat = 0
        for btn in itemBtns {
            btn.sizeToFit()
            totalBtnWidth += btn.width
        }
        let totalMargin = self.width - totalBtnWidth
        var caculateMargin: CGFloat = totalMargin / (CGFloat((items?.count ?? 0)) + 1);
        if (caculateMargin < kMinMargin) {
            caculateMargin = kMinMargin;
        }
        var lastX = caculateMargin
        for btn in itemBtns {
            btn.sizeToFit()
            btn.y = height - btn.height - indicatorView.height
            btn.x = lastX
            lastX += (btn.width + caculateMargin)
        }
        self.contentView.contentSize = CGSize(width: lastX, height: 0)
        if itemBtns.count == 0 {
            return
        }
        let btn = itemBtns[selectIndex];
        self.indicatorView.width = btn.width + self.config.indicatorExtraW * 2;
        self.indicatorView.centerX = btn.centerX;
        self.indicatorView.height = self.config.indicatorHeight;
        self.indicatorView.y = self.height - self.indicatorView.height;
    }
    
   
    
}

extension MarsSegmentBarDelegate {
    func marsSegmentBar(_ segmentBar: MarsSegmentBar, didSelectIndex index: NSInteger, fromIndex lastIndex: NSInteger) {
        
    }
}
