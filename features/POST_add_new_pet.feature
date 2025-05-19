@add_new_pet
Feature: POST - Add New Pet Endpoint
  I can add new pet
  and I receive expected error msgs if input values are not valid


##############################
####  Positive Scenarios  ####
##############################

  Scenario: I can add new pet to the store
    When I make a "POST" request to "/v2/pet" endpoint with the payload:
   """
    {
      "id": 0,
      "category": {
        "id": 0,
        "name": "dog"
      },
      "name": "tobi",
      "tags": [
        {
          "id": 0,
          "name": "dog"
        }
      ],
      "status": "available"
    }
   """
    Then the response code is "200"

##############################
####  Negative Scenarios  ####
##############################
  # Both should fail but they are not. 'name' field and 'photoUrls' are required fields.
  # This is where we would report a new bug
  Scenario Outline: Request should fail when the required field passes no value in the request body
    When I make a "POST" request to "/v2/pet" endpoint with the payload:
    """
    {
      "id": 0,
      "category": {
        "id": 0,
        "name": "string"
      },
      "name": "<name>",
      "photoUrls": [
        "<photo_url>"
      ],
      "tags": [
        {
          "id": 0,
          "name": "string"
        }
      ],
      "status": "available"
    }
   """
    Then the response code is "400"

    Examples:
      | name | photo_url |
      |      | whatever  |
      | tedi |           |

  # Should fail but it is not. Required field 'name' is removed completely from request body.
  # This is where we would report a new bug
  Scenario: Request should fail when the required field 'name' is removed
    When I make a "POST" request to "/v2/pet" endpoint with the payload:
    """
    {
      "id": 0,
      "category": {
        "id": 0,
        "name": "string"
      },
      "photoUrls": [
        "whatever"
      ],
      "tags": [
        {
          "id": 0,
          "name": "whatever_tag"
        }
      ],
      "status": "available"
    }
   """
    Then the response code is "400"

  # Should fail but it is not. Required field 'photoUrls' is removed completely from request body.
  # This is where we would report a new bug
  Scenario: Request should fail when the required field 'photoUrls' is removed
    When I make a "POST" request to "/v2/pet" endpoint with the payload:
    """
    {
      "id": 0,
      "category": {
        "id": 0,
        "name": "whatever"
      },
      "name": "floki",
      "tags": [
        {
          "id": 0,
          "name": "whatever_tag"
        }
      ],
      "status": "available"
    }
   """
    Then the response code is "400"


  Scenario Outline: Sending invalid "<request_method>" method throws expected status code
    When I make a "<request_method>" request to "/v2/pet"
    Then the response code is "405"

    Examples:
      | request_method |
      | GET            |
      | PATCH          |
      | DEL            |