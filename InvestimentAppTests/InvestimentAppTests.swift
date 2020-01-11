//
//  InvestimentAppTests.swift
//  InvestimentAppTests
//
//  Created by Israel on 07/12/19.
//  Copyright © 2019 israel3D. All rights reserved.
//

import XCTest
@testable import InvestimentApp

class InvestimentAppTests: XCTestCase {

    var sut: InvestimentFormViewController?
    var investiment: Investiment?

    override func setUp() {
        let sboard = UIStoryboard(name: "Main", bundle: nil)
        sut = sboard.instantiateViewController(withIdentifier: "InvestimentFormViewController")
                as? InvestimentFormViewController
        investiment = getAPIInvestimentData()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testToggleViewLoading() {
        guard sut != nil else { return }
        sut!.loadView()
        sut!.toggleLoading(false)
        XCTAssertFalse(sut!.viewLoading.isHidden)
    }

    func testMaturityTotalDays() {
        guard investiment != nil else { return }
        XCTAssertEqual(investiment?.investmentParameter?.maturityTotalDays, 1981)
    }

    func testTaxesRate() {
        guard investiment != nil else { return }
        XCTAssertEqual(investiment?.taxesRate, 15.0)
    }

    func testTaxFreeReturnsDefaultFalse() {
        guard investiment != nil else { return }
        XCTAssertEqual(investiment?.investmentParameter?.isTaxFree, false)
    }

    private func getAPIInvestimentData() -> Investiment? {

        if let path = Bundle.main.path(forResource: "Investiment", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                if let result = try? decoder.decode(Investiment.self, from: data) {
                    return result
                }
            } catch let error {
                print("Error: \(error.localizedDescription)")
            }
        }
        return nil
    }

}
