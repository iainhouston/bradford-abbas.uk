Feature: First Feature
  In order to create a new Meeting
  As an Officer
  I need to be able to complete the Meeting creation form

  @api
  Scenario:
     Given I am logged in as a user with the "Officer" role
     Then I should see the text "Add content"
