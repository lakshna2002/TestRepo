Feature:
  Test Feature
 @SmokeTest
  Scenario:
    Given I take a coffee
    When I dont fill in the coffee tank
    And message "Fill tank" should be displayed
    Then should not be served
    Then should      not be served
    
    
