Feature: Projects

  As a user,
  I want to be able to create projects
  So that I can organize my slide decks

  Scenario: Getting help
    When I run `profess new`
    Then the output should contain:
    """
    profess new deck
    """
	And the output should contain:
	"""
	profess new project
	"""

  Scenario: Creating a new project successfully
    When I run `profess new project proj`
    Then the following directories should exist:
      | proj        |
	  | proj/common |
      | proj/config |
      | proj/slides |
      | proj/output |
    And the following files should exist:
      | proj/config/project.toml |
	And the file "proj/config/project.toml" should contain:
	"""
 [project]
   name = "proj"

 # Global defaults for all decks set here.  You can
 # override these in the individual deck configuration
 # files.  
 [deck]
 
   [author]
     name        = "Your name here"
     email       = "user@example.com"
     department  = "Department of Computer Science"
     institution = "Western University"
    """ 
	
  Scenario: Attempting to create a new project without a name
    When I run `profess new project`
	Then the output should contain:
	"""
	ERROR: profess project was called with no arguments
	"""
