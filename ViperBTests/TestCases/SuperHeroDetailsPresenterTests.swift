//
//  SuperHeroDetailsPresenterTests.swift
//  ViperBTests
//
//  Created by Hossein Asgari Seresht on 21/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import XCTest
@testable import ViperB

class SuperHeroDetailsPresenterTests: XCTestCase {

    var sut: SuperHeroDetailsPresenter?
    let interactorMock = SuperHeroDetailsInteractorMock()
    let routerMock = SuperHeroDetailsRouterMock()
    let mockDelegate = SuperHeroDetailsPresenterDelegateMock()
    override func setUp() {
        super.setUp()
        sut = SuperHeroDetailsPresenter(interactor: interactorMock, router: routerMock)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testViewWillBecomeActiveSucceed() {
        interactorMock.failedError = nil
        sut?.delegate = mockDelegate

        sut?.viewWillBecomeActive()

        XCTAssertFalse((mockDelegate.updatedModel?.isLoading)!)
        XCTAssertEqual(mockDelegate.updatedModel?.heroName, interactorMock.model.name)
    }

    func testViewWillBecomeActiveFailed() {
        interactorMock.failedError = .loadError
        sut?.delegate = mockDelegate

        sut?.viewWillBecomeActive()

        XCTAssertFalse((mockDelegate.updatedModel?.isLoading)!)
        XCTAssertEqual(mockDelegate.updatedModel?.heroName, "")
        XCTAssertNotNil(mockDelegate.updatedModel?.errorText)
    }

    func testDidTapClose() {
        sut?.didTapClose()

        XCTAssertTrue(routerMock.closeCalled!)
    }
}
