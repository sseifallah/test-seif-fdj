//
//  Test_SeifTests.swift
//  Test SeifTests
//
//  Created by  Seif on 19/05/2022.
//

import XCTest
@testable import Test_Seif

class Test_SeifTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //Testing the API of getting the leagues
    //One promise to fulfill: Code status == 200
    func testValidCallToAPI() async {
        let serviceURL = URL(string: APIEndpoints.getLeaguesURL)!
        let promiseStatus = expectation(description: "Status code: 200")
        let (_, response, _) = await URLSession.shared.dataTask(with: serviceURL)
        if let httpResponse = response as? HTTPURLResponse{
            if httpResponse.statusCode == 200 {
                promiseStatus.fulfill()
            } else {
                XCTFail("Status code: \(httpResponse.statusCode)")
            }
        }
        wait(for: [promiseStatus], timeout: 5)
    }
    
    //Testing the API of getting the teams by league
    //Two promises to fulfill: Code status == 200 and Teams number in English Premier League is 20
    func testValidCountOfTeams() async {
        let league = "English Premier League"
        let numberOfTeams = 20
        let promiseStatus = expectation(description: "Status code: 200")
        let promiseNumber = expectation(description: "League Teams Number = \(numberOfTeams)")
        var serviceURL = URLComponents(string: APIEndpoints.getTeamsURL)!
        serviceURL.queryItems = [URLQueryItem(name: "l", value: league)]
        let (data, response, _) = await URLSession.shared.dataTask(with: serviceURL.url!)
        if let httpResponse = response as? HTTPURLResponse{
            if httpResponse.statusCode == 200 {
                promiseStatus.fulfill()
            }else{
                XCTFail("Status code: \(httpResponse.statusCode)")
            }
        }
        if let data = data {
            let teams = try? JSONDecoder().decode(LeagueTeams.self, from: data)
            if teams?.teams?.count == numberOfTeams{
                promiseNumber.fulfill()
            }else{
                XCTFail("League Teams Number: \(teams?.teams?.count ?? 0)")
            }
        }
        wait(for: [promiseStatus, promiseNumber], timeout: 5)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
