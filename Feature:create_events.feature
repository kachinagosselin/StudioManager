Feature: Create Events
So that I can manage events
As an owner
I want to be able to add, delete and edit events

Scenario: Adding an event
Given there is no article with the title "First event"
And I am on the events page
When I follow ""
And I fill in "Title" with "First event"
And I fill in "Description" with "Test content"
And I press "Submit"
And I should see "First event"

Given /^there is no article with the title "([^"]*)"$/ do |article|
  Article.find_by_title(article).should_not == true
end

Then /^I should see "([^"]*)" on the articles list$/ do |title|
  visit articles_url
  page.should have_content title
end

Scenario: Adding an article without a title
    Given I am on the articles page
    When I follow "Add article"
    And I press "Submit"
    Then I should not see "Article saved successfully!"

Scenario: Deleting an article
    Given an article with the title "Hello world!"
    And I am on the articles page
    When I follow "Hello world!"
    And I follow "Destroy"
    Then I should be on the articles page
    And I should see "Article has been successfully destroyed!"
    And I should not see "Hello world!"