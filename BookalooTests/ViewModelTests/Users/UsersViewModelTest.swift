//
//  UsersViewModelTest.swift
//  BookalooTests
//
//  Created by Joyce Rosario Batista on 26/2/23.
//

import XCTest
@testable import Bookaloo

@MainActor
final class UsersViewModelTest: XCTestCase {
    var mockDependenciesResolver = MockUsersDependenciesResolver()
    var viewModel: UsersViewModel?
    
    override func setUp() {
        viewModel = mockDependenciesResolver.resolve()
    }

    override func tearDown() {
        viewModel = nil
    }
    
    func test_get_user_data_with_success() {
        // When
        viewModel?.getUserData()
        // Then
        wait(self.viewModel?.userFound.email == "joyce.usertest@bookaloo.com")
    }
    
    func test_find_user_by_email_with_success() {
        // When
        viewModel?.findUser(by: "joyce.usertest@bookaloo.com")
        // Then
        wait(self.viewModel?.userFound.email == "joyce.usertest@bookaloo.com")
    }
    
    func test_modify_user_with_success() {
        // Given
        let user = UserData(email: "joyce.usertest@bookaloo.com", name: "Joyce", location: "House", role: .user)
        // When
        viewModel?.modify(user)
        // Then
        wait(self.viewModel?.showModifiedUserAlert == true)
    }
    
    func test_save_user_with_success() {
        // Given
        viewModel?.newUser.email = "joyce.usertest@bookaloo.com"
        viewModel?.newUser.name = "Joyce"
        viewModel?.newUser.location = "House"
        // When
        viewModel?.save()
        // Then
        wait(self.viewModel?.validEmail == true)
        wait(self.viewModel?.validName == true)
        wait(self.viewModel?.validLocation == true)
        wait(self.viewModel?.showCreatedUserAlert == true)
    }
    
    func test_save_user_empty_data_should_fail() {
        // Given
        viewModel?.newUser.email = ""
        viewModel?.newUser.name = ""
        viewModel?.newUser.location = ""
        // When
        viewModel?.save()
        // Then
        wait(self.viewModel?.validEmail == false)
        wait(self.viewModel?.validName == false)
        wait(self.viewModel?.validLocation == false)
        wait(self.viewModel?.showCreatedUserAlert == false)
    }
    
    func test_save_user_empty_name_and_location_should_fail() {
        // Given
        viewModel?.newUser.email = "joyce.usertest@bookaloo.com"
        viewModel?.newUser.name = ""
        viewModel?.newUser.location = ""
        // When
        viewModel?.save()
        // Then
        wait(self.viewModel?.validEmail == true)
        wait(self.viewModel?.validName == false)
        wait(self.viewModel?.validLocation == false)
        wait(self.viewModel?.showCreatedUserAlert == false)
    }
    
    func test_save_user_empty_location_should_fail() {
        // Given
        viewModel?.newUser.email = "joyce.usertest@bookaloo.com"
        viewModel?.newUser.name = "Joyce"
        viewModel?.newUser.location = ""
        // When
        viewModel?.save()
        // Then
        wait(self.viewModel?.validEmail == true)
        wait(self.viewModel?.validName == true)
        wait(self.viewModel?.validLocation == false)
        wait(self.viewModel?.showCreatedUserAlert == false)
    }
}
