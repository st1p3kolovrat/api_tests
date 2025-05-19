@update_existing_pet
Feature: PUT - Update Existing Pet Endpoint
  I can update existing pet


##############################
####  Positive Scenarios  ####
##############################

  Scenario: I can update name of the existing pet
    # Add a new pet
    When I make a "POST" request to "/v2/pet" endpoint with the payload:
   """
    {
      "id": 202519050530,
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
    # Update existing pet
    When I make a "POST" request to "/v2/pet" endpoint with the payload:
    """
    {
        "id": 202519050530,
        "category": {
            "id": 0,
            "name": "dog"
        },
        "name": "pedro",
        "photoUrls": [],
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
    And the response body is equal to:
    """
    {
        "id": 202519050530,
        "category": {
            "id": 0,
            "name": "dog"
        },
        "name": "pedro",
        "photoUrls": [],
        "tags": [
            {
                "id": 0,
                "name": "dog"
            }
        ],
        "status": "available"
    }
    """
