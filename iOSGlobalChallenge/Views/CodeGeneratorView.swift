//
//  CodeGeneratorView.swift
//  iOSGlobalChallenge
//
//  Created by Ramon Haro Marques on 16/07/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ToastSwiftFramework

class CodeGeneratorView: UIView {
    
    //MARK:- Properties
    //MARK: Constants
    let networkManager:NetworkManager
    
    let disposeBag = DisposeBag()
    let codeGeneratorViewModel = BehaviorRelay(value: CodeGeneratorViewModel())
    
    
    //MARK:- Variables
    //UI
    lazy private (set) var indicator:UIActivityIndicatorView = {
        let rtView = UIActivityIndicatorView()
        
        rtView.color = UIColor.defaultTint
        
        return rtView
    }()
    lazy private (set) var codeLabel:BaseLabel = {
        let rtView = BaseLabel(withConfiguration: .normal)
        
        rtView.accessibilityIdentifier = "CodeLabel"
        rtView.textAlignment = .left
        rtView.text = codeGeneratorViewModel.value.codeFormattedString
        
        return rtView
    }()
    lazy private (set) var counterLabel:BaseLabel = {
        let rtView = BaseLabel(withConfiguration: .normalLight)
        
        rtView.accessibilityIdentifier = "CounterLabel"
        rtView.text = codeGeneratorViewModel.value.counterFormattedString
        
        return rtView
    }()
    lazy private (set) var generateButton:BaseButton = {
        let rtView = BaseButton(withConfiguration: .normal)
        
        rtView.setTitle(NSLocalizedString("messages.generateCode", comment: ""), for: .normal)
        rtView.accessibilityIdentifier = "GenerateButton"
        
        return rtView
    }()
    
    
    //MARK:- Constructor
    init(networkManager:NetworkManager) {
        self.networkManager = networkManager
        super.init(frame: .zero)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//MARK:- Lifecycle methods
extension CodeGeneratorView{
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if superview != nil{
            setupView()
        }
        
    }
    
}


//MARK:- Private methods
private extension CodeGeneratorView{
    
    func setupView(){
        
        accessibilityIdentifier = "CodeGeneratorView"
        backgroundColor = UIColor.primaryViewBackground
        addBorder(borderWidth: Separators.xSmall, radius: BorderRadius.large, color: UIColor.primaryViewBorder)
        
        addSubview(generateButton)
        generateButton.anchor(top: nil,
                              leading: leadingAnchor,
                              bottom: bottomAnchor,
                              trailing: trailingAnchor,
                              padding: .init(padding: Margins.medium),
                              size: .init(width: 0, height: Heights.button))
        
        //OBS -> It can be done also using Constarints for both UILabels. StackView can be define as property too.
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Margins.medium
        stackView.distribution = .fill
        
        stackView.addArrangedSubview(codeLabel)
        stackView.addArrangedSubview(counterLabel)
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor,
                         leading: leadingAnchor,
                         bottom: nil,
                         trailing: trailingAnchor,
                         padding: .init(top: Margins.xLarge, left: Margins.medium, bottom: Margins.medium, right: Margins.medium))
        
        addSubview(indicator)
        indicator.anchor(top: nil,
                         leading: nil,
                         bottom: nil,
                         trailing: nil,
                         centerX: centerXAnchor,
                         centerY: centerYAnchor)
        
        setupBinder()
        
    }
    
    func setupBinder(){
        
        codeGeneratorViewModel.value.counter
            .asObservable()
            .observeOn(MainScheduler.instance)
            .map({ [unowned self] (_) -> String in
                self.codeGeneratorViewModel.value.counterFormattedString
            })
            .bind(to: counterLabel.rx.text)
            .disposed(by: disposeBag)
        
        codeGeneratorViewModel.value.code
            .asObservable()
            .observeOn(MainScheduler.instance)
            .map({ [unowned self]_ -> String in
                return self.codeGeneratorViewModel.value.codeFormattedString
            })
            .bind(to: codeLabel.rx.text)
            .disposed(by: disposeBag)
        
        codeGeneratorViewModel.value.isFetching
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] (isFetching) in
                
                self.generateButton.isEnabled = !isFetching
                if isFetching{
                    self.indicator.startAnimating()
                }
                else{
                    self.indicator.stopAnimating()
                }
                
            })
            .disposed(by: disposeBag)
        
        generateButton.rx.tap
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                
                guard let strongSelf = self else{ return }
                print(strongSelf.logClassName, "Fetching data ...")
                
                strongSelf.codeGeneratorViewModel.value.isFetching.accept(true)
  
                let codeResponseObservable = strongSelf.networkManager.generateCode()
                
                codeResponseObservable
                    .observeOn(MainScheduler.instance)
                    .subscribe(onNext: { (codeResponse) in
                        print(strongSelf.logClassName,"Code response next value = ", codeResponse.responseCode ?? "")
                        strongSelf.updateView(codeResponse: codeResponse)
                    }, onError: { (error) in
                        print(strongSelf.logClassName,"ERROR fetching data: ", error.localizedDescription)
                        strongSelf.updateView(codeResponse: nil)
                        
                    })
                    .disposed(by: strongSelf.disposeBag)
                
            })
            .disposed(by: disposeBag)
        
    }
    
    func updateView(codeResponse:CodeResponse?){
        
        codeGeneratorViewModel.value.isFetching.accept(false)
        codeGeneratorViewModel.value.counter.accept(codeGeneratorViewModel.value.counter.value + 1)
        codeGeneratorViewModel.value.code.accept(codeResponse?.responseCode)
        
        if codeResponse == nil{
            makeToast(NSLocalizedString("messages.error.tryAgain", comment: ""), duration: 2)
        }
        
    }
    
}
