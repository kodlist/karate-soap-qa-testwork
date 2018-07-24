#Author: your.email@your.domain.com
#Keywords Summary :
#Feature: List of scenarios.
#Scenario: Business rule through list of steps with arguments.
#Given: Some precondition step
#When: Some key actions
#Then: To observe outcomes or validation
#And,But: To enumerate more Given,When,Then steps
#Scenario Outline: List of steps for data-driven as an Examples and <placeholder>
#Examples: Container for s table
#Background: List of steps run before each of the scenarios
#""" (Doc Strings)
#| (Data Tables)
#@ (Tags/Labels):To group Scenarios
#<> (placeholder)
#""
## (Comments)
#Sample Feature Definition Template



@tag
Feature: Title of your feature
  I want to use this template for my feature file
  
  Background:
  * def getDate =
	"""
	function() {
  	var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
  	var sdf = new SimpleDateFormat('yyyy/MM/dd');
  	var date = new java.util.Date();
  	return sdf.format(date);
	} 
	"""

	* def temp = getDate()

  @tag1
  Scenario: Print date and time using java method interop to js  
	* print 'date we tested this scenario:', temp 
	 Given def myVar = 'world'
	 Then print myVar
	
	
	@tag2
  Scenario: Print random stuff  
	 Given print 'we are on same page'
	 
	 
  @tag3
  Scenario Outline: Title of your scenario outline
    Given print 'I want to write a step with', "<name>"
    When print 'I check for the', "<value>", 'in step',
    Then print 'I verify the', "<status>", 'in step',

    Examples: 
      | name  | value | status  |
      | name1 |     5 | success |
      | name2 |     7 | Fail    |
      
      
