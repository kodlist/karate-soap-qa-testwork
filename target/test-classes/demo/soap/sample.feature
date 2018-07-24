#Author: mehar.koduri@realpage.com
#Keywords Summary :
#Feature: sample
#Scenario: small default scenario
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
Feature: Title of your feature  I want to use this template for my feature file

#===============================

  Background:  

	
#===============================

  @tag1
  Scenario Outline: Title of your scenario outline
    Given I want to write a step with <name>
    When I check for the <value> in step
    Then I verify the <status> in step

    Examples: 
      | name  | value | status  |
      | name1 |     5 | success |
      | name2 |     7 | Fail    |
#===============================

   #assert is keyword in karate
   @tag2
   @assertion
   Scenario: assert keword usage.
   Given def color = 'red '
	 And def num = 5
	 Then assert color + num == 'red 5'
	 
#===============================

	 
	 
   @xmlVerifyWithMatchKeyword
   Scenario: Karate lets you traverse xml in json style. please see both xml sytle and xml as json style.
   Given def cat = <cat><name>Billie</name><scores><score>2</score><score>5</score></scores></cat>
   # sadly, xpath list indexes start from 1
   Then match cat/cat/scores/score[2] == '5'
   # but karate allows you to traverse xml like json !!
   Then match cat.cat.scores.score[1] == '5'
   
  
#===============================
  
   @commonJSfunction
   Scenario: call js fucntion defined in karate-config.js
   Given def greet = greeter
   Then print greet('mehar')
   And print greeter('navya')
   And print addingTwoNumbers()
   And print addingNumbers(4,4)
   
   
#===============================
   
   @xmlRequest
   Scenario: reading complete xml and printing its content in report file
   # https://github.com/intuit/karate#reading-files
   # Prefer classpath: when a file is expected to be heavily re-used all across your project. And yes, relative paths will work.
   # 'classpath:demo/soap/request.xml'
   # file: for file option youhave to make sure the xml file is in taget folder.
 * def payload = read('classpath:demo/soap/request.xml')
 * print payload
 * def response = read('classpath:demo/soap/request.xml')
 * match payload == response
 
 
#===============================
 
	 @addingTwoNumberUsingOpenFreeWebservice
	 Scenario: making soap request to open webservice - add two numbers
	 Given url 'http://www.dneonline.com/calculator.asmx?op=Add' 
   And request read('soap-request-addTwoNum.xml')
   # soap is just an HTTP POST, so here we set the required header manually ..
   And header Content-Type = 'application/soap+xml; charset=utf-8'
   When method post
   * def sum = 10
   Then match response /Envelope/Body/AddResponse/AddResult == sum
   Then status 200
   
   
#===============================   
   
   @addingTwoNumbersWithDynamicDataVerify
   Scenario Outline: making soap request to open webservice - add two numbers
   Given url urlForDneOnlineCalculator 
   And request read('soap-request-addTwoNum.xml')
   # soap is just an HTTP POST, so here we set the required header manually ..
   And header Content-Type = addHeader
   When method post
   Then match response /Envelope/Body/AddResponse/AddResult == "<sum>"
   Then status 200
   Examples:
   | sum |
   | 10  |
   | 6   |
   | 4   |
   
   
#===============================   
   
   @changeInputDataInRequestDynamic_01
   Scenario Outline: making soap request multiple times with different data - add two numbers
   Given url urlForDneOnlineCalculator 
   * def xml =
   """
   <?xml version="1.0" encoding="utf-8"?>
			<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">
  			<soap12:Body>
    			<Add xmlns="http://tempuri.org/">
      			<intA>##(<_varA>)</intA>
      			<intB>##(<_varB>)</intB>
    			</Add>
  			</soap12:Body>
			</soap12:Envelope> 
		"""
		And request xml
		 # soap is just an HTTP POST, so here we set the required header manually ..
    And header Content-Type = addHeader
    When method post
    Then match response /Envelope/Body/AddResponse/AddResult == "<sum>"
    Then status 200
		Examples:
		| _varA | _varB | sum |
		|   3   |   3   | 6   |
		|   4   |   5   | 19   |
		
		
		
#===============================		
   
		@changeInputDataInRequestXMLDynamically_02
		Scenario Outline:
   	 Given url urlForDneOnlineCalculator 
     * def reqxml = read('request.xml')
     * set reqxml /
     | path 		    | value                  |
     | Add/intA     | "<value1>"             |
     | Add/intB     | "<value2>"             |
     #* print '====== req ===== ',reqxml
     #* configure logPrettyRequest = true . NOYE: This is set 'globally' using the Karate object in karate-config.js
   	 And request reqxml
		 # soap is just an HTTP POST, so here we set the required header manually ..
     And header Content-Type = addHeader
     When method post
     Then match response /Envelope/Body/AddResponse/AddResult == "<sum>"
     Then status 200
		 Examples:
		 | sum 	| value1 | value2 |
		 | 6    |  4     | 2      |
		 | 10   |  6     | 4      |


#===============================		 