  Feature: Red_test_positive

    It will be testing of all basic features
    of http://demo.redmine.org

  Background:
    Given Register random user

  Scenario: Test registration
    Then Add new user

  Scenario: Test login-logout
    When Logout-login
    Then New user is login

  Scenario: Test changing password
    When Change user password
    Then User password was changed

  Scenario: Test Creating Project
    When Creating project and project version
    Then Project version is created

  Scenario: Test editing users roles in project
    When Add random user to the project and edit his roles
    Then User's role was edited from manager to developer

  Scenario: Test creating all types of issues
    When Creating bug, feature and support issue
    Then All types of issues are visible on Issues_ tab