Feature: Annotation
  When visiting a user's expedition page
  As a logged in user
  I should be able to upload a new annotation
  And it should display on the page

  When visiting a user's expedition page
  As a logged in user
  I should be able to view an existing annotation

  Background:
    Given sample users have been created
    And sample expeditions have been created
    And I am logged in as "shaka@zulu.sa"

  Scenario: Uploading an annotation
    Given I am on the "expedition" page
    When I click on "Add an Image"
    Then the page contains "/public/uploads/annotation/image/"

