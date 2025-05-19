@pet_data
Feature: GET - Retrieve Pet Data
  I can retrieve a Pet data


###############################
#####  Positive Scenarios  ####
###############################

  # Bug explained in the text. This test will fail most of the time due to unreliable endpoint
  # This is where we would report a new bug
  Scenario: I can retrieve data of the pet
    When I create and store a pet ID
    And I make a "GET" request with path param to "pet/pet_id"
    Then the response code is "200"

##############################
####  Negative Scenarios  ####
##############################

  Scenario: I cannot retrieve pet data if I pass non existing pet id
    When I make a "GET" request to "pet/12349128349754"
    Then the response code is "404"
    And the response body is equal to:
    """
    {
    "code": 1,
    "type": "error",
    "message": "Pet not found"
    }
    """


