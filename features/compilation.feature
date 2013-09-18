Feature: Compilation

  As a user,
  I want to be able to compile my slides
  So that I can present them to the world and mould the malleable minds of eager students
  
  @announce
  Scenario: Successful compilation
    Given a project "proj" exists
    And the following decks exist within the project "proj":
    | topic1 |
    | topic2 |
  	When I run `profess compile`
    Then the following directories should exist:
    | output/topic1 |
    | output/topic2 |
    And the following files should exist:
    | output/index.html        |
    | output/topic1/index.html |
    | output/topic2/index.html |
    