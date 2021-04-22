Feature: Different result types
  In order to differentiate feature statuses
  As a feature writer
  I need to be able to see different types of test results

  Scenario: Undefined steps
    Given a file named "features/coffee.feature" with:
      """
      Feature: Undefined coffee machine actions
        In order to make clients happy
        As a coffee machine factory
        We need to be able to tell customers
        about what coffee type is supported
        Background:
          Given I have magically created 10$
        Scenario: Buy incredible coffee
          When I have chose "coffee with turkey" in coffee machine
          Then I should have "turkey with coffee sauce"
        Scenario: Buy incredible tea
          When I have chose "pizza tea" in coffee machine
          Then I should have "pizza tea"
