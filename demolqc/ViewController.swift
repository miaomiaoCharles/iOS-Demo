//
//  ViewController.swift
//  demolqc
//
//  Created by ByteDance on 2023/11/27.
//

import UIKit
import SnapKit

protocol viewsProtocol {
    var name: String { get set }
}

class ViewController: UIViewController {
    
    lazy var views = makeViews()
    lazy var bottomTab = makeTab()
    
    lazy var viewModel = ViewModel()
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.addObservers()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addObservers()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bottomTab.updateUI(name: "HomePage", isLeftAbandon: true, isRightAbandon: viewModel.currentPageIndex == views.count - 1)
    }
    func setupUI() {
        self.view.addSubview(bottomTab)
        bottomTab.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(70)
            make.bottom.equalToSuperview()
        }
        let view = views[viewModel.currentPageIndex]
        self.view.addSubview(view)
        view.snp.makeConstraints { make in
            make.bottom.equalTo(bottomTab.snp.top)
            make.top.left.right.equalToSuperview()
        }
    }
    func updateUI(view: UIView) {
        view.snp.makeConstraints { make in
            make.bottom.equalTo(bottomTab.snp.top)
            make.top.left.right.equalToSuperview()
        }
        guard let name = getCurrentViewName() else { return }
        bottomTab.updateUI(name: name, isLeftAbandon: viewModel.currentPageIndex == 0, isRightAbandon: viewModel.currentPageIndex == views.count-1)
    }
}

extension ViewController {
    func makeViews () -> [UIView] {
        var views: [UIView] = [HomePage(), ShowView()]
        return views
    }
    func makeTab() -> BottomTab {
        let view: BottomTab = BottomTab()
        view.delegate = self
        return view
    }
}

extension ViewController {
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(changePage(_:)), name: Notification.Name("currentPage"), object: nil)
    }
    @objc func changePage(_ notification: Notification) {
        guard let oldViewIndex = notification.userInfo?[viewModel.currentPageIndex] as? Int else { return }
        //执行翻页效果
        let currentView = views[viewModel.currentPageIndex]
        UIView.transition(from: views[oldViewIndex], to: currentView, duration: 0.3, options: .transitionFlipFromBottom)
        UIView.animate(withDuration: <#T##TimeInterval#>, animations: <#T##() -> Void#>)
        updateUI(view: currentView)
    }
}

extension ViewController: BottomTabDelegate {
    func clickRight() {
        if viewModel.currentPageIndex != views.count - 1 {
            viewModel.currentPageIndex += 1
        }
    }
    
    func clickLeft() {
        if viewModel.currentPageIndex != 0 {
            viewModel.currentPageIndex -= 1
        }
    }
}

extension ViewController {
    func getCurrentViewName() -> String? {
        guard let view = views[viewModel.currentPageIndex] as? viewsProtocol else { return nil }
        return view.name
    }
}
