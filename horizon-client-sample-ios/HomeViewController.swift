//
//  HomeViewController.swift
//  HorizonClientSample
//
//  Created by alessandro on 30/11/22.
//  Copyright © 2022 globo.com. All rights reserved.
//

import UIKit
import HorizonClient
import AdSupport
import AppTrackingTransparency

enum TypeButtons {
    case top
    case middle
    case botton
}

class HomeViewController: UIViewController {
    //MARK: ViewModel
    
    var viewModel: HomeViewModelType
    
    //MARK: Content
    private lazy var topButton = Layout.Constraint(topAnchor: 35, leadingAnchor: 20, trailingAnchor: -20, height: 60)
    private lazy var middleButton = Layout.Constraint(topAnchor: 30, leadingAnchor: 20, trailingAnchor: -20, height: 60)
    private lazy var bottonButton = Layout.Constraint(topAnchor: 30, leadingAnchor: 20, trailingAnchor: -20, bottomAnchor: -10, height: 60)
    private lazy var contentViewLayout = Layout.Constraint(topAnchor: 20)
    
    
    private lazy var scrollView:  UIScrollView = {
        var scroll = UIScrollView()
        scroll.backgroundColor = .gray
        return scroll
    }()
    
    private lazy var contentView:  UIView = {
        var content = UIView()
        content.backgroundColor = .gray
        return content
    }()
    
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: contentViewLayout.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    //MARK: buttons
    private lazy var profileButton = makeButton(target: #selector(sendProfileTeamChoose),
                                         name: "profile-ge-team-choose-1.0")
    private lazy var genericClickButton = makeButton(target: #selector(sendGenericClick),
                                              name: "generic-click-1.0")
    private lazy var relationedEventsButton = makeButton(target: #selector(sendRelationedEvents),
                                                  name: "Relationed Events")
    private lazy var liveCoverageTimelineViewButton = makeButton(target: #selector(sendLineCoverageTimelineView),
                                                          name: "live-coverage-timeline-view-1.0")
    
    private lazy var invalidGenericClickButton = makeButton(target: #selector(sendInvalidEvent),
                                                     name: "Invalid generic-click")
    private lazy var getAnonymousButton = makeButton(target: #selector(showAnonymousUser),
                                              name: "Get Anonymous")
    private lazy var showNewContextIDButton = makeButton(target: #selector(getNewContextID),
                                            name: "Show Context ID")
    private lazy var setExternalIdButton = makeButton(target: #selector(setExternalId),
                                            name: "Set External ID")
    private lazy var showHsidButton = makeButton(target: #selector(showHsid),
                                            name: "Show hsid")
    private lazy var userLoginButton = makeButton(target: #selector(userLogin),
                                           name: "User Login")
    private lazy var userLogoutButton = makeButton(target: #selector(userLogout),
                                            name: "User Logout")
    //MARK: setup
    
    private func setupElements() {
        setupScrollView()
        self.contentView.addSubview(profileButton)
        self.contentView.addSubview(genericClickButton)
        self.contentView.addSubview(relationedEventsButton)
        self.contentView.addSubview(liveCoverageTimelineViewButton)
        self.contentView.addSubview(invalidGenericClickButton)
        self.contentView.addSubview(getAnonymousButton)
        self.contentView.addSubview(showNewContextIDButton)
        self.contentView.addSubview(setExternalIdButton)
        self.contentView.addSubview(showHsidButton)
        self.contentView.addSubview(userLoginButton)
        self.contentView.addSubview(userLogoutButton)
    }
    
    private func setupButtonConstraints() {
        
        makeButtonConstraints(button: profileButton, typeButton: .top)
        makeButtonConstraints(button: genericClickButton,fatherButton: profileButton)
        makeButtonConstraints(button: relationedEventsButton,fatherButton: genericClickButton)
        makeButtonConstraints(button: liveCoverageTimelineViewButton,fatherButton: relationedEventsButton)
        makeButtonConstraints(button: invalidGenericClickButton,fatherButton: liveCoverageTimelineViewButton)
        makeButtonConstraints(button: getAnonymousButton,fatherButton: invalidGenericClickButton)
        makeButtonConstraints(button: showNewContextIDButton,fatherButton: getAnonymousButton)
        makeButtonConstraints(button: setExternalIdButton,fatherButton: showNewContextIDButton)
        makeButtonConstraints(button: showHsidButton,fatherButton: setExternalIdButton)
        makeButtonConstraints(button: userLoginButton,fatherButton: showHsidButton)
        makeButtonConstraints(button: userLogoutButton,fatherButton: userLoginButton, typeButton: .botton)
    }
    
    //MARK: Life Circle
    
    init(viewModel: HomeViewModelType){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupElements()
        setupButtonConstraints()
        
        print("Is Horizon client ready:", HorizonClient.isReady)
        
        try? HorizonClient.get() { error in
            print("Is Horizon client ready? ", HorizonClient.isReady)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.requestAdvertisingIdPermission()
    }
    
    //MARK: helpers
    
    private func makeButton(color: UIColor = UIColor(red: 1, green: 165/255, blue: 0, alpha: 1),
                             target: Selector,
                             name: String)-> UIButton {
        
        let button: UIButton = {
            let color = color
            let button = createBaseButton(name: name, buttonColor: color)
            button.addTarget(self, action: target, for: .touchUpInside)
            return button
        }()
        
        return button
    }
    
    private func makeButtonConstraints(button: UIButton,
                                       fatherButton: UIButton = UIButton(),
                                       typeButton: TypeButtons = .middle){
        
        switch typeButton {
            
            
            
        case .top:
            button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topButton.topAnchor).isActive = true
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: topButton.leadingAnchor).isActive = true
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: topButton.trailingAnchor).isActive = true
            button.heightAnchor.constraint(equalToConstant: topButton.height).isActive = true
            
        case .middle:
            
            button.topAnchor.constraint(equalTo: fatherButton.bottomAnchor, constant: middleButton.topAnchor).isActive = true
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: middleButton.leadingAnchor).isActive = true
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: middleButton.trailingAnchor).isActive = true
            button.heightAnchor.constraint(equalToConstant: middleButton.height).isActive = true
            
        case .botton:
            button.topAnchor.constraint(equalTo: fatherButton.bottomAnchor, constant: bottonButton.topAnchor).isActive = true
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: bottonButton.leadingAnchor).isActive = true
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: bottonButton.trailingAnchor).isActive = true
            button.heightAnchor.constraint(equalToConstant: bottonButton.height).isActive = true
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: bottonButton.bottomAnchor).isActive = true
            
        }
        
    }
    
    private func createBaseButton(name: String, buttonColor: UIColor) -> UIButton{
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(name, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true //arredondar botão
        button.layer.cornerRadius = 7.5
        button.backgroundColor = buttonColor
        return button
    }
    
    //MARK: Actions
    
    @objc private func sendProfileTeamChoose() {
        
        _ = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        
        try? HorizonClient.get() { error in
            print("Is Horizon client ready? ", HorizonClient.isReady)
        }
        
        try? HorizonClient.get().send(schemaId: "profile-ge-team-choose",
                                      schemaVersion: "1.0",
                                      contentType: "multicontent",
                                      url: self,
                                      referer: self,
                                      properties: [ "team": "Anguilas",
                                                    "source": "aSource"
                                                  ]) { event, error in
            if error != nil {
                print("Error:", error!)
                return
            }
            
            print("Queued event: \(event.schemaId)")
        }
    }
    
    @objc private func sendGenericClick() {
        
        try? HorizonClient.get().send(schemaId: "generic-click",
                                      schemaVersion: "1.0",
                                      contentType: "sad-type",
                                      url: self,
                                      referer: self,
                                      properties: ["element": "link", "href": "http://aUrl.com"]) { event, error in
            if error != nil {
                print("Error:", error!)
                return
            }
            
            print("Queued event: \(event.schemaId)")
        }
    }
    
    @objc private func sendLineCoverageTimelineView() {
        try? HorizonClient.get().send(schemaId: "live-coverage-timeline-view",
                                      schemaVersion: "1.0",
                                      contentType: "sad-type",
                                      url: self,
                                      referer: self,
                                      properties: ["coverageId": "12345", "viewTimeMs": 5000]) { event, error in
            
            if error != nil {
                print("Error:", error!)
                return
            }
            
            print("Queued event: \(event.schemaId)")
        }
    }
    
    @objc private func sendInvalidEvent() {
        try? HorizonClient.get().send(schemaId: "generic-click",
                                      schemaVersion: "1.0",
                                      contentType: "invalid-type",
                                      url: self,
                                      referer: self,
                                      properties: ["not-a-valid-field": "not valid field"]) { event, error in
            if error != nil {
                print("Error:", error!)
                return
            }
            
            print("Queued event: \(event.schemaId)")
        }
    }
    
    @objc private func showAnonymousUser() {
        try? HorizonClient.get().getAnonymousUser { type, value, publicValue in
            guard let pubValue = publicValue else {
                print("Null return from GetAnonymous", type, value)
                return
            }
            
            print("Valid return from GetAnonymous", type, value, pubValue)
        }
        
    }
    
    @objc private func getNewContextID() {
        
        if let oldContext = try? HorizonClient.get().getContextId() {
            print("old ContextId is: ",oldContext)
        }
        try? HorizonClient.get().newContextId()
        
        if let newContext = try? HorizonClient.get().getContextId() {
            print("new ContextId is: ",newContext)
        }
    }
    
    @objc private func setExternalId() {
        do {
            try HorizonClient.setLoggedUser(tokenType: UserTokenType.ext_id, token: "dummy-ext_id")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
    
    @objc private func userLogin() {
        do {
            try HorizonClient.setLoggedUser(tokenType: UserTokenType.glbid, token: "dummy-id")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
    
    @objc private func userLogout() {
        do {
            try HorizonClient.removeLoggedUser()
        } catch {
            print("Unexpected error: \(error)")
        }
    }
    
    @objc private func showHsid() {
        do {
            print("Current hsid is: ", try HorizonClient.get().getHsid())
        } catch {
            print("Unexpected error: \(error)")
        }
    }

    @objc private func sendRelationedEvents() {
        
        let eventsBoundid = UUID().uuidString.lowercased()
        
        let clickEventA = HorizonClient.createEvent(schemaId: "live-coverage-timeline-view",
                                                    schemaVersion: "1.0",
                                                    contentType: "sad-type",
                                                    url: self,
                                                    referer: self,
                                                    properties: ["coverageId": "12345", "viewTimeMs": 5000])
        
        let clickEventB = HorizonClient.createEvent(schemaId: "live-coverage-timeline-view",
                                                    schemaVersion: "1.0",
                                                    contentType: "sad-type",
                                                    url: self,
                                                    referer: self,
                                                    properties: ["coverageId": "12345", "viewTimeMs": 5000])
        
        try? HorizonClient.get().send(events: [clickEventA, clickEventB], relationId: eventsBoundid) { event, error in
            if error != nil {
                print("Error:", error!)
                return
            }
            
            print("Queued event:\(event.schemaId)-\(event.schemaVersion)")
        }
    }
    
}
