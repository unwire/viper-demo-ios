//
//  SuperHeroListPresenterTests.swift
//  ViperBTests
//
//  Created by Hossein Asgari Seresht on 20/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import XCTest
@testable import ViperB

class SuperHeroListPresenterTests: XCTestCase {

    let expectationTimeout = 1.0
    var sut: SuperHeroListPresenter?
    let interactorMock = SuperHeroListInteractorMock()
    let routerMock = SuperHeroListRouterMock()
    let mockDelegate = SuperHeroListPresenterDelegateMock()
    override func setUp() {
        sut = SuperHeroListPresenter(interactor: interactorMock, router: routerMock)
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testViewWillBecomeActiveSucceed() {
        interactorMock.failedError = nil
        sut?.delegate = mockDelegate

        sut?.viewWillBecomeActive()

        XCTAssertTrue((sut?.numberOfListItems())! > 0)
        XCTAssertTrue(interactorMock.loadAllSortedAlphabeticallyCalled!)
        XCTAssertNotNil(mockDelegate.updatedModel)
        XCTAssertNil(mockDelegate.updatedModel?.statusText)
        XCTAssertFalse((mockDelegate.updatedModel?.showLoadingIndicator)!)
    }

    func testViewWillBecomeActiveInteractorFailedWithLoadError() {
        interactorMock.failedError = .loadError
        sut?.delegate = mockDelegate

        sut?.viewWillBecomeActive()

        XCTAssertTrue((sut?.numberOfListItems())! == 0)
        XCTAssertTrue(interactorMock.loadAllSortedAlphabeticallyCalled!)
        XCTAssertNotNil(mockDelegate.updatedModel)
        XCTAssertTrue(mockDelegate.updatedModel?.statusText == "No heroes...")
        XCTAssertFalse((mockDelegate.updatedModel?.showLoadingIndicator)!)
    }

    func testListOptionChangedToZeroSucceed() {
        interactorMock.failedError = nil
        sut?.delegate = mockDelegate

        sut?.listOptionChanged(option: 0)

        XCTAssertTrue((sut?.numberOfListItems())! > 0)
        XCTAssertTrue(interactorMock.loadAllSortedAlphabeticallyCalled!)
        XCTAssertNotNil(mockDelegate.updatedModel)
        XCTAssertNil(mockDelegate.updatedModel?.statusText)
        XCTAssertFalse((mockDelegate.updatedModel?.showLoadingIndicator)!)
    }

    func testListOptionChangedToOneSucceed() {
        interactorMock.failedError = nil
        sut?.delegate = mockDelegate

        sut?.listOptionChanged(option: 1)

        XCTAssertTrue((sut?.numberOfListItems())! > 0)
        XCTAssertTrue(interactorMock.loadTop10Called!)
        XCTAssertNotNil(mockDelegate.updatedModel)
        XCTAssertNil(mockDelegate.updatedModel?.statusText)
        XCTAssertFalse((mockDelegate.updatedModel?.showLoadingIndicator)!)
    }

    func testListOptionChangedToZeroInteractorFailedWithLoadError() {
        interactorMock.failedError = .loadError
        sut?.delegate = mockDelegate

        sut?.listOptionChanged(option: 0)

        XCTAssertTrue((sut?.numberOfListItems())! == 0)
        XCTAssertTrue(interactorMock.loadAllSortedAlphabeticallyCalled!)
        XCTAssertNotNil(mockDelegate.updatedModel)
        XCTAssertTrue(mockDelegate.updatedModel?.statusText == "No heroes...")
        XCTAssertFalse((mockDelegate.updatedModel?.showLoadingIndicator)!)
    }

    func testListOptionChangedToOneInteractorFailedWithLoadError() {
        interactorMock.failedError = .loadError
        sut?.delegate = mockDelegate

        sut?.listOptionChanged(option: 1)

        XCTAssertTrue((sut?.numberOfListItems())! == 0)
        XCTAssertTrue(interactorMock.loadTop10Called!)
        XCTAssertNotNil(mockDelegate.updatedModel)
        XCTAssertTrue(mockDelegate.updatedModel?.statusText == "No heroes...")
        XCTAssertFalse((mockDelegate.updatedModel?.showLoadingIndicator)!)
    }

    func testListItemViewModel() {
        interactorMock.failedError = nil
        sut?.delegate = mockDelegate
        sut?.viewWillBecomeActive()

        let model = sut?.listItemViewModel(at: 0)

        XCTAssertNotNil(model)
        XCTAssertTrue(interactorMock.loadImageCalled!)
    }

    func testDidTapListItemViewModelWithCorrectIndex() {
        interactorMock.failedError = nil
        sut?.delegate = mockDelegate
        sut?.viewWillBecomeActive()

        sut?.didTapListItemViewModel(at: 0)

        XCTAssertTrue(routerMock.openCalled!)
    }

    func testDidTapListItemViewModelWithWrongIndex() {
        interactorMock.failedError = .loadError
        sut?.delegate = mockDelegate
        sut?.viewWillBecomeActive()

        sut?.didTapListItemViewModel(at: 0)

        XCTAssertNil(routerMock.openCalled)
    }

}
