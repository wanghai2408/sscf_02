

import UIKit

class YYCycleScrollView: UIView,UIScrollViewDelegate {

    var _totalPagesCount:(()->Int)!
    var totalPagesCount:(()->Int)!{
    set{
        self._totalPagesCount = newValue
        self.totalPageCount = _totalPagesCount()
        self.pageControl.numberOfPages = newValue()
        self.configContentViews()
    }
    get{
        return self._totalPagesCount
    }
    }
    
    var fetchContentViewAtIndex:((pageIndex:Int)->UIView)!
    
    var TapActionBlock:((pageIndex:Int)->())!
    
    var _currentPageIndex:Int!
    var currentPageIndex:Int!{
    set{
        self._currentPageIndex = newValue
        if (self.pageControl != nil){
            self.pageControl.currentPage = newValue
        }
    }
    get{
        return self._currentPageIndex
    }
    }
    
    var totalPageCount:Int!
    var contentViews:NSMutableArray!
    var animationTimer:NSTimer!
    var animationDuration:NSTimeInterval!
    
    var _showPageControl:Bool!
    var showPageControl:Bool!{
    set{
        self._showPageControl = newValue
        self.pageControl.hidden = !newValue
    }
    get{
        return self._showPageControl
    }
    }
    
    var pageControl:UIPageControl!
    var scrollView:UIScrollView!
    
    init(frame:CGRect,animationDuration:NSTimeInterval){
        super.init(frame: frame)
        if animationDuration>0.0 {
            self.animationTimer = NSTimer.scheduledTimerWithTimeInterval(animationDuration, target: self, selector: Selector("animationTimerDidFired:"), userInfo: nil, repeats: true)
        }
        
        self.autoresizesSubviews = true
        self.scrollView = UIScrollView(frame:self.bounds)
        //self.scrollView.autoresizingMask = 0xFF
        self.scrollView.contentMode = UIViewContentMode.Center
        self.scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        self.scrollView.delegate = self
        self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0)
        self.scrollView.pagingEnabled = true
        self.addSubview(self.scrollView)
        self.currentPageIndex = 0
        
        self.pageControl = UIPageControl()
        self.pageControl.center = CGPointMake(frame.size.width/2,frame.size.height-15)
        self.addSubview(pageControl)
        
        self.showPageControl = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configContentViews(){
        for view:AnyObject in self.scrollView.subviews{
            (view  as! UIView).removeFromSuperview()
        }
        self.setScrollViewContentDataSource()
        var counter:Int = 0
        for i in 0 ..< self.contentViews.count {
            var contentView = self.contentViews.objectAtIndex(i) as! UIView
            contentView.userInteractionEnabled = true
            var tapGesture = UITapGestureRecognizer(target:self,action:"contentViewTapAction:")
            contentView.addGestureRecognizer(tapGesture)
            var rightRect = contentView.frame;
//            rightRect.origin = CGPointMake(CGRectGetWidth(self.scrollView.frame) * Float(i), 0)
            rightRect.origin = CGPointMake(CGRectGetWidth(self.scrollView.frame) * CGFloat(i) , 0)
            contentView.frame = rightRect
            self.scrollView.addSubview(contentView)
        }
        self.scrollView.setContentOffset(CGPointMake(self.scrollView.frame.size.width,0), animated: false)
    }
    
    func setScrollViewContentDataSource(){
        var previousPageIndex = self.getValidNextPageIndexWithPageIndex(self.currentPageIndex - 1)
        var rearPageIndex = self.getValidNextPageIndexWithPageIndex(self.currentPageIndex + 1)
        if self.contentViews == nil {
            self.contentViews = NSMutableArray()
        }
        self.contentViews.removeAllObjects()
        //NSLog("contentViews.removeAllObjects()")
        if (self.fetchContentViewAtIndex != nil) {
            self.contentViews.addObject(self.fetchContentViewAtIndex(pageIndex: previousPageIndex))
            self.contentViews.addObject(self.fetchContentViewAtIndex(pageIndex: self.currentPageIndex))
            self.contentViews.addObject(self.fetchContentViewAtIndex(pageIndex:rearPageIndex))
        }	
    }
    
    func getValidNextPageIndexWithPageIndex(currentPageIndex:Int)->Int{
        if currentPageIndex == -1{
            return self.totalPageCount - 1
        }else if currentPageIndex == self.totalPageCount{
            return 0
        }else {
            return currentPageIndex
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView){
        var contentOffsetX = scrollView.contentOffset.x
        if contentOffsetX >= 2.0 * CGRectGetWidth(scrollView.frame) {
            self.currentPageIndex = self.getValidNextPageIndexWithPageIndex(self.currentPageIndex + 1)
            self.configContentViews()
        }
        if contentOffsetX <= 0 {
            self.currentPageIndex = self.getValidNextPageIndexWithPageIndex(self.currentPageIndex - 1)
            self.configContentViews()
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView){
        scrollView.setContentOffset(CGPointMake(CGRectGetWidth(scrollView.frame), 0),animated:true)
    }
    
    
    func animationTimerDidFired(timer:NSTimer){
        var newOffset = CGPointMake(self.scrollView.contentOffset.x + CGRectGetWidth(self.scrollView.frame), self.scrollView.contentOffset.y)
        self.scrollView.setContentOffset(newOffset,animated:true)
    }
    
    func contentViewTapAction(tap:UITapGestureRecognizer){
        if (self.TapActionBlock != nil){
            self.TapActionBlock(pageIndex: self.currentPageIndex)
        }
    }
}

