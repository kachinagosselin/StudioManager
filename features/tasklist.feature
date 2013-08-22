Feature: Register Event

Scenario: Create a event student relationship
Given I am logged in
And there is an event
When I register for an event
When I view my events
Then I see the event listed
