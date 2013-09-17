Feature: Decks

  As a user,
  I want to be able to create slide decks
  So that I can give beautiful, informative presentations and impart my knowledge upon the world

  Scenario: Creating a new deck successfully
  	Given a project "proj" exists
	When I change to the root of the project "proj"
	And I run `profess new deck topic1`
	Then the following directories should exist:
	| slides/topic1 |
	And the following files should exist:
	| slides/topic1/deck.toml |
	And the file "slides/topic1/deck.toml" should contain:
	"""
 [deck]
   title = "topic1"
 
   # Uncomment the lines below to override global defaults set in 
   # config/project.toml.
 
   #[author]
   #  name        = "Your name here"
   #  email       = "user@example.com"
   #  department  = "Department of Computer Science"
   #  institution = "Western University"
	"""

  Scenario: Creating a new deck successfully from within a subdirectory of a project
  	Given a project "proj" exists
	When I cd to "proj/config"
	And I run `profess new deck topic1`
	Then the following directories should not exist:
	| slides/topic1 |
	But the following directories should exist:
	| ../slides/topic1 |
	And the following files should exist:
	| ../slides/topic1/deck.toml |
	
  Scenario: Attempting to create a deck from outside a project
	Given a directory named "tmp"
	When I cd to "tmp"
	And I run `profess new deck topic1`
	Then the following directories should not exist:
	| slides/topic1 |
	And the output should contain "Cannot find the project root."

  