Feature: Stub Responses
  In order to simulate behaviour of third-party web services
  As a test for my application
  I want to simulate http service behaviour
  
  Background:
    Given GET /foo returns 404 with the body "Not Found"
    And   GET /bar returns 404 with the body "Not Found"
    And   POST /foo returns 404 with the body "Not Found"
    And   POST /bar returns 404 with the body "Not Found"
  
  Scenario: Stub GET response
    When  I POST "application/json+rack-stub" to /foo with the body:
      """
        {
          "GET" : [200, { "header": "value" }, ["jazz"]]
        }
      """
    Then  GET /foo should return 200 with the body "jazz"
    And   POST /foo should return 404 with the body "Not Found"

  Scenario: Stub POST response
    When  I POST "application/json+rack-stub" to /bar with the body:
      """
        {
          "POST" : [200, { "header": "value" }, ["funk"]]
        }
      """
    Then  POST /bar should return 200 with the body "funk"
    And   GET /foo should return 404 with the body "Not Found"
    
  Scenario: Clear all stub responses
    When  I POST "application/json+rack-stub" to /foo with the body:
      """
        {
          "GET" : [200, { "header": "value" }, ["soul"]]
        }
      """
    And   I POST "application/json+rack-stub" to /bar with the body:
      """
       {
         "POST" : [200, { "header": "value" }, ["brother"]]
       }
      """
    When  I POST "application/json+rack-stub" to /rack_stubs/clear with the body:
      """
      """
    Then  GET /foo should return 404 with the body "Not Found"
    And   POST /bar should return 404 with the body "Not Found"

  Scenario: List all stub responses
    Then  GET /rack_stubs/list should return 200 with the body "{}"
    When  I POST "application/json+rack-stub" to /foo with the body:
      """
        {
          "GET" : [200, { "header": "value" }, ["salsa"]]
        }
      """
    And   I POST "application/json+rack-stub" to /bar with the body:
      """
       {
         "POST" : [200, { "header": "value" }, ["chicken"]]
       }
      """
    Then  GET /rack_stubs/list should return 200 with the body:
      """
      {"/foo":{"GET":[200,{"header":"value"},["salsa"]]},"/bar":{"POST":[200,{"header":"value"},["chicken"]]}}
      """

