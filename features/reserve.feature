Feature: Reserve a room
  In order to welcome the RailsConf speakers
  RailsConf speakers
  should be able to reserve a room with a local
  
  Scenario: A RailsConf speaker reserves a room
    Given I am not authenticated
    When I view the rooms available
    Then I should not be able to reserve a room
    
    When I authenticate with twitter as "jamesgolick"
    And I view the rooms available
    Then I should be able to reserve a room
    
    When I click "Stay with Dave"
    Then I should see a form to "Stay with Dave"
    
    When I fill in the following fields
      | Expected Arrival Date/Time | Sunday, 7PM |
      | Email                      | arailsconfspeaker@localhost |
      | Notes                      | I'm only staying through Wednesday |
    And I click "Request Reservation"
    Then I should see "Thanks for requesting to stay with Dave"
    And "Dave" should receive a request email
    
    When "Dave" approves the reservation request
    Then "jamesgolick" should receive a confirmation email
    
    When I view the rooms available for "Dave"
    Then I should see "has 2 available rooms"
    And "jamesgolick" should be listed as staying with "Dave"
    
  Scenario: A host rejects a reservation request
    Given "jamesgolick" has submitted a reservation request
    When "Dave" rejects the reservation request
    Then "jamesgolick" should receive a rejection email
    
    When I view the rooms available for "Dave"
    Then I should see "has 3 available rooms"