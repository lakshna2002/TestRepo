Feature: Customer Module

  Background: 
    Given "Customer" rest service is running
    Given "CustomerAuth" rest service is running
    Given "Customer" SOAP service is running


 @tag=AmendCustomer @tag=BasicCustomer
 Scenario: Create a basic customer, amend all other details and validate the customer information
    When user creates a "basic" customer
    And user amends all other customer information
    And search for the customer
    Then customer details should match against information used while customer creation
 
 @tag=MinorCustomer
Scenario Outline: Create a minor customer with KNIF legal document for different activity types, country of birth as Spain , Physical Address as Spain and validate the customer information
  	 When user creates a "minor" customer with "<ActivityType>" legal document as "NIF" country of birth as "Spain" and physical address as "Spain"
  And user activates the created customer
  And search for the customer
  Then customer details should match against information used while customer creation
  		 Examples:
  			 |ActivityType|
  			 |PROFESSIONAL_LIBERAL_OR_AUTONOMOUS|
  			 |SALARIED|
  			 |RENTIER|
  			 |WITHOUT_ECONOMIC_ACTIVITY|
  			 |PENSIONER|
  
  @tag=MajorCustomer
  Scenario Outline: Create a major customer with different legal document for different activity types, country of birth as Spain , Physical Address as Spain and validate the customer information
    When user creates a "major" customer with '<ActivityType>' legal document as '<LegalDocument>' country of birth as "Spain" and physical address as "Spain"
    And user activates the created customer
    And search for the customer
    Then customer details should match against information used while customer creation

    Examples: 
      | ActivityType                       | LegalDocument |
      | PROFESSIONAL_LIBERAL_OR_AUTONOMOUS | DNI           |
      | SALARIED                           | PASSPORT      |
      | RENTIER                            | NIE           |
      | WITHOUT_ECONOMIC_ACTIVITY          | REDCARD       |
      | PENSIONER                          | DNI           |

   @tag=MinorCustomer  
   Scenario Outline: Create a minor customer with KNIF legal document for different activity types, country of birth as Non Spain , Physical Address as Spain and validate the customer information
  	 When user creates a "minor" customer with "<ActivityType>" legal document as "NIF" country of birth as "Non_Spain" and physical address as "Spain"
  	 And user activates the created customer
  	 And search for the customer
  	 Then customer details should match against information used while customer creation
  
  		 Examples:
  			 |ActivityType|
  			 |PROFESSIONAL_LIBERAL_OR_AUTONOMOUS|
  			 |SALARIED|
  			 |RENTIER|
  			 |WITHOUT_ECONOMIC_ACTIVITY|
  			 |PENSIONER|
 
  @tag=MajorCustomer
  Scenario Outline: Create a major customer with different legal document for different activity types, country of birth as Non Spain , Physical Address as Spain and validate the customer information
    When user creates a "major" customer with '<ActivityType>' legal document as '<LegalDocument>' country of birth as "Non_Spain" and physical address as "Spain"
    And user activates the created customer
    And search for the customer
    Then customer details should match against information used while customer creation

    Examples: 
      | ActivityType                       | LegalDocument |
      | PROFESSIONAL_LIBERAL_OR_AUTONOMOUS | REDCARD       |
      | SALARIED                           | PASSPORT      |
      | RENTIER                            | DNI           |
      | WITHOUT_ECONOMIC_ACTIVITY          | PASSPORT      |
      | PENSIONER                          | DNI           |

@tag=MinorCustomer
Scenario Outline: Create a minor customer with KNIF legal document for different activity types, country of birth as Non Spain , Physical Address as Non - Spain and validate the customer information
  	 When user creates a "minor" customer with "<ActivityType>" legal document as "NIF" country of birth as "Non_Spain" and physical address as "Non_Spain"
  	 And user activates the created customer
  	 And search for the customer
  	 Then customer details should match against information used while customer creation
  
  		 Examples:
  			 |ActivityType|
  			 |PROFESSIONAL_LIBERAL_OR_AUTONOMOUS|
  			 |SALARIED|
  			 |RENTIER|
  			 |WITHOUT_ECONOMIC_ACTIVITY|
  			 |PENSIONER|
  
  @tag=MajorCustomer  
  Scenario Outline: Create a major customer with different legal document for different activity types, country of birth as Non Spain , Physical Address as Non Spain and validate the customer information
    When user creates a "major" customer with '<ActivityType>' legal document as '<LegalDocument>' country of birth as "Non_Spain" and physical address as "Non_Spain"
    And user activates the created customer
    And search for the customer
    Then customer details should match against information used while customer creation

    Examples: 
      | ActivityType                       | LegalDocument |
      | PROFESSIONAL_LIBERAL_OR_AUTONOMOUS | REDCARD       |
      | SALARIED                           | PASSPORT      |
      | RENTIER                            | NIE           |
      | WITHOUT_ECONOMIC_ACTIVITY          | DNI           |
      | PENSIONER                          | NIE           |

	@tag=MinorCustomer
  Scenario Outline: Create a customer aged between 14 to 18 with activity type as "PROFESSIONAL LIBERAL OR AUTONOMOUS" , country of birth as spain, different national physical address and validate the customer information
    When user creates a "minor_14_to_18" customer with "PROFESSIONAL_LIBERAL_OR_AUTONOMOUS" legal document as '<LegalDocument>' country of birth as "Spain" and physical address as '<NationalAddress>'
    And user activates the created customer
    And search for the customer
    Then customer details should match against information used while customer creation

    Examples: 
      | LegalDocument | NationalAddress |
      | DNI           | Spain           |
      | PASSPORT      | Spain           |
      | REDCARD       | Non_Spain       |
      | NIE           | Non_Spain       |

 
  @tag=MinorCustomer 
  Scenario Outline: Create a customer aged between 14 to 18 with activity type as "PROFESSIONAL LIBERAL OR AUTONOMOUS" , country of birth as Non Spain, physical address as Non Spain and validate the customer information
    When user creates a "minor_14_to_18" customer with "PROFESSIONAL_LIBERAL_OR_AUTONOMOUS" legal document as '<LegalDocument>' country of birth as "Non_Spain" and physical address as "Non_Spain"
    And user activates the created customer
    And search for the customer
    Then customer details should match against information used while customer creation

    Examples: 
      | LegalDocument |
      | NIE           |
      | PASSPORT      |
      | DNI           |
      | REDCARD       |

  @tag=SearchCustomer
  Scenario Outline: Search for the customer with different parameters i.e firstSurName, secondSurName,  customer DOB, customer Legal ID, etc.
    Given there is an active customer
    When user searches for the customer with different parameters 
    Then the user should see the search results of the customer corresponding to the search query

  

   # Negative Scenario for customer amendment 
   @tag=NegativeScenarios
  Scenario Outline: Validate if correct validation message is generated when user tries to amend customer with incorrect input details i.e. invalid DOB, LegalDocument, etc.
  Given there is a basic customer
  When user amends the customer '<detail>' with invalid data
  Then the valid validation code and message should be returned
  
  Examples:
  | detail              |
  | dateOfBirth         |
  | residenceTCode      |
  | activityTypeTCode   |
  | educationLevelTCode |
 
  # Negative Scenario for customer creation
  @tag=NegativeScenarios 
  Scenario Outline: Validating if correct validation message is generated when user tries to create customer with incorrect input details i.e. invalid DOB, LegalDocument, etc.
    When user creates a customer with invalid '<details>'
    Then the valid validation message should be returned should be returned

    Examples: 
      | details       |
      | KNIF          |
      | DNI           |
      | NIE           |
      | DateOfBirth   |
      | NationalTCode |
   
     @tag=NegativeScenarios
     Scenario Outline: Validating if correct validation message is generated when user tries to create customer with duplicate details i.e. invalid Passport, DNI, NIE etc.
    When user creates a customer with duplicate '<details>'
    Then the valid validation code and message should be returned

    Examples: 
      | details  |
      | Passport |
      | DNI      |
      | NIE      |
      | KNIF     |
      
    #Negative - Searching the customer with Invalid Params 
    @tag=NegativeScenarios
  Scenario Outline: Validate if correct validation message is generated when user tries to search customer with invalid search details i.e. invalid date for DOB, InvalidLegalDocument, etc.,
    When user search for the customer with '<invalidDetail>'
    Then the valid validation code and message should be returned

    Examples: 
      | invalidDetail                     |
      | customer.invalidDOB               |
      | customer.invalidLegalDocumentID   |
      | customer.invalidLegalDocumentType |

 
 @tag=UpdateCustomer
 Scenario: Create a basic customer, amend all other details and validate the customer information
    When user creates a "basic" customer
    And user amends all other customer information
    And search for the customer
    Then customer details should match against information used while customer creation
 
 @tag=MinorCustomer
Scenario Outline: Create a minor customer with KNIF legal document for different activity types, country of birth as Spain , Physical Address as Spain and validate the customer information
  	 When user creates a "minor" customer with "<ActivityType>" legal document as "NIF" country of birth as "Spain" and physical address as "Spain"
  And user activates the created customer
  And search for the customer
  Then customer details should match against information used while customer creation
  		 Examples:
  			 |ActivityType|
  			 |PROFESSIONAL_LIBERAL_OR_AUTONOMOUS|
  			 |SALARIED|
  			 |RENTIER|
  			 |WITHOUT_ECONOMIC_ACTIVITY|
  			 |PENSIONER|
  
  @tag=MajorCustomer
  Scenario Outline: Create a major customer with different legal document for different activity types, country of birth as Spain , Physical Address as Spain and validate the customer information
    When user creates a "major" customer with '<ActivityType>' legal document as '<LegalDocument>' country of birth as "Spain" and physical address as "Spain"
    And user activates the created customer
    And search for the customer
    Then customer details should match against information used while customer creation

    Examples: 
      | ActivityType                       | LegalDocument |
      | PROFESSIONAL_LIBERAL_OR_AUTONOMOUS | DNI           |
      | SALARIED                           | PASSPORT      |
      | RENTIER                            | NIE           |
      | WITHOUT_ECONOMIC_ACTIVITY          | REDCARD       |
      | PENSIONER                          | DNI           |

   @tag=MinorCustomer  
   Scenario Outline: Create a minor customer with KNIF legal document for different activity types, country of birth as Non Spain , Physical Address as Spain and validate the customer information
  	 When user creates a "minor" customer with "<ActivityType>" legal document as "NIF" country of birth as "Non_Spain" and physical address as "Spain"
  	 And user activates the created customer
  	 And search for the customer
  	 Then customer details should match against information used while customer creation
  
  		 Examples:
  			 |ActivityType|
  			 |PROFESSIONAL_LIBERAL_OR_AUTONOMOUS|
  			 |SALARIED|
  			 |RENTIER|
  			 |WITHOUT_ECONOMIC_ACTIVITY|
  			 |PENSIONER|
 
  @tag=MajorCustomer
  Scenario Outline: Create a major customer with different legal document for different activity types, country of birth as Non Spain , Physical Address as Spain and validate the customer information
    When user creates a "major" customer with '<ActivityType>' legal document as '<LegalDocument>' country of birth as "Non_Spain" and physical address as "Spain"
    And user activates the created customer
    And search for the customer
    Then customer details should match against information used while customer creation

    Examples: 
      | ActivityType                       | LegalDocument |
      | PROFESSIONAL_LIBERAL_OR_AUTONOMOUS | REDCARD       |
      | SALARIED                           | PASSPORT      |
      | RENTIER                            | DNI           |
      | WITHOUT_ECONOMIC_ACTIVITY          | PASSPORT      |
      | PENSIONER                          | DNI           |

@tag=MinorCustomer
Scenario Outline: Create a minor customer with KNIF legal document for different activity types, country of birth as Non Spain , Physical Address as Non - Spain and validate the customer information
  	 When user creates a "minor" customer with "<ActivityType>" legal document as "NIF" country of birth as "Non_Spain" and physical address as "Non_Spain"
  	 And user activates the created customer
  	 And search for the customer
  	 Then customer details should match against information used while customer creation
  
  		 Examples:
  			 |ActivityType|
  			 |PROFESSIONAL_LIBERAL_OR_AUTONOMOUS|
  			 |SALARIED|
  			 |RENTIER|
  			 |WITHOUT_ECONOMIC_ACTIVITY|
  			 |PENSIONER|
  
  @tag=MajorCustomer  
  Scenario Outline: Create a major customer with different legal document for different activity types, country of birth as Non Spain , Physical Address as Non Spain and validate the customer information
    When user creates a "major" customer with '<ActivityType>' legal document as '<LegalDocument>' country of birth as "Non_Spain" and physical address as "Non_Spain"
    And user activates the created customer
    And search for the customer
    Then customer details should match against information used while customer creation

    Examples: 
      | ActivityType                       | LegalDocument |
      | PROFESSIONAL_LIBERAL_OR_AUTONOMOUS | REDCARD       |
      | SALARIED                           | PASSPORT      |
      | RENTIER                            | NIE           |
      | WITHOUT_ECONOMIC_ACTIVITY          | DNI           |
      | PENSIONER                          | NIE           |

	@tag=MinorCustomer
  Scenario Outline: Create a customer aged between 14 to 18 with activity type as "PROFESSIONAL LIBERAL OR AUTONOMOUS" , country of birth as spain, different national physical address and validate the customer information
    When user creates a "minor_14_to_18" customer with "PROFESSIONAL_LIBERAL_OR_AUTONOMOUS" legal document as '<LegalDocument>' country of birth as "Spain" and physical address as '<NationalAddress>'
    And user activates the created customer
    And search for the customer
    Then customer details should match against information used while customer creation

    Examples: 
      | LegalDocument | NationalAddress |
      | DNI           | Spain           |
      | PASSPORT      | Spain           |
      | REDCARD       | Non_Spain       |
      | NIE           | Non_Spain       |

 
  @tag=MinorCustomer 
  Scenario Outline: Create a customer aged between 14 to 18 with activity type as "PROFESSIONAL LIBERAL OR AUTONOMOUS" , country of birth as Non Spain, physical address as Non Spain and validate the customer information
    When user creates a "minor_14_to_18" customer with "PROFESSIONAL_LIBERAL_OR_AUTONOMOUS" legal document as '<LegalDocument>' country of birth as "Non_Spain" and physical address as "Non_Spain"
    And user activates the created customer
    And search for the customer
    Then customer details should match against information used while customer creation

    Examples: 
      | LegalDocument |
      | NIE           |
      | PASSPORT      |
      | DNI           |
      | REDCARD       |

  @tag=SearchCustomer
  Scenario Outline: Search for the customer with different parameters i.e firstSurName, secondSurName,  customer DOB, customer Legal ID, etc.
    Given there is an active customer
    When user searches for the customer with different parameters 
    Then the user should see the search results of the customer corresponding to the search query

  

   # Negative Scenario for customer amendment 
   @tag=NegativeScenarios
  Scenario Outline: Validate if correct validation message is generated when user tries to amend customer with incorrect input details i.e. invalid DOB, LegalDocument, etc.
  Given there is a basic customer
  When user amends the customer '<detail>' with invalid data
  Then the valid validation code and message should be returned
  
  Examples:
  | detail              |
  | dateOfBirth         |
  | residenceTCode      |
  | activityTypeTCode   |
  | educationLevelTCode |
 
  # Negative Scenario for customer creation
  @tag=NegativeScenarios 
  Scenario Outline: Validating if correct validation message is generated when user tries to create customer with incorrect input details i.e. invalid DOB, LegalDocument, etc.
    When user creates a customer with invalid '<details>'
    Then the valid validation message should be returned should be returned

    Examples: 
      | details       |
      | KNIF          |
      | DNI           |
      | NIE           |
      | DateOfBirth   |
      | NationalTCode |
   
     @tag=NegativeScenarios
     Scenario Outline: Validating if correct validation message is generated when user tries to create customer with duplicate details i.e. invalid Passport, DNI, NIE etc.
    When user creates a customer with duplicate '<details>'
    Then the valid validation code and message should be returned

    Examples: 
      | details  |
      | Passport |
      | DNI      |
      | NIE      |
      | KNIF     |
      
    #Negative - Searching the customer with Invalid Params 
    @tag=NegativeScenarios
  Scenario Outline: Validate if correct validation message is generated when user tries to search customer with invalid search details i.e. invalid date for DOB, InvalidLegalDocument, etc.,
    When user search for the customer with '<invalidDetail>'
    Then the valid validation code and message should be returned

    Examples: 
      | invalidDetail                     |
      | customer.invalidDOB               |
      | customer.invalidLegalDocumentID   |
      | customer.invalidLegalDocumentType |
