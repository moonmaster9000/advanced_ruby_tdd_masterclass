Feature: Add Todo Item

  Scenario: Add item to empty list
    Given an empty todo list
    When I add an item to the list
    Then I should see it in the list
