Feature:
  <Some interesting description here>
  
  @SmokeTest
  Scenario:
    Given I take a coffee
    When I dont fill in beans tank
    And message "Fill beans" should be displayed
    Then coffee should not be served