Feature: Doing a Todo

  Scenario: Todo exists
    Given there is a todo
    When I do it
    Then it should no longer show up in the list of todos
