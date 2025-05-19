import json
from urllib.parse import urljoin

import requests
from behave import when, step, then
from assertpy import assert_that

from environment import BASE_URL
from features.data import data


#####################
# REQUEST HANDLING #
#####################


@step('I make a "{request_method}" request to "{endpoint_url}"')
def request_without_payload(context, request_method, endpoint_url):
    request_method = request_method.lower()
    full_endpoint_url = urljoin(BASE_URL, endpoint_url)
    context.response = requests.request(request_method, full_endpoint_url)


@step('I make a "{request_method}" request with path param to "{endpoint_url}/{path_param}"')
def request_without_payload(context, request_method, endpoint_url, path_param):
    request_method = request_method.lower()

    # Retrieve the value from data.py using the provided param_path string.
    # Example: if param_path is "pet_id", this retrieves data.pet_id
    param_path_func = getattr(data, path_param)

    # Call the retrieved value with context to get the actual parameter value.
    param_path_data = param_path_func(context)

    full_endpoint_url = urljoin(BASE_URL, f"{endpoint_url}/{param_path_data}")

    context.response = requests.request(request_method, full_endpoint_url)


@step('I make a "{request_method}" request to "{endpoint_url}" endpoint with the payload:')
def request_with_payload(context, request_method, endpoint_url):
    request_method = request_method.lower()
    # Capture the multistring payload from the feature file
    payload = context.text
    # Convert the modified payload string to JSON
    payload_dict = json.loads(payload)
    # Make the request
    full_endpoint_url = urljoin(BASE_URL, endpoint_url)
    print("For demo purpose - full_endpoint_url", full_endpoint_url)
    context.response = requests.request(
        method=request_method,
        url=full_endpoint_url,
        json=payload_dict
    )

    print("For demo purpose -  Status code:", context.response.status_code)
    print("For demo purpose - Response body:", context.response.text)
    response_json = context.response.json()
    # Store pet id
    context.pet_id = response_json.get("id")
    print("For demo purpose - context.pet_id:", context.pet_id)


#####################
# RESPONSE HANDLING #
#####################


@then('the response code is "{expected_status_code}"')
def assert_expected_status_code(context, expected_status_code):
    actual_status_code = context.response.status_code
    assert_that(int(expected_status_code)).is_equal_to(actual_status_code)


@then('the response body is equal to:')
def assert_expected_response_body(context):
    actual_response_body = context.response.json()
    expected_response_body = json.loads(context.text)
    assert_that(expected_response_body).is_equal_to(actual_response_body)


@when('I create and store a pet ID')
def step_impl(context):
    context.execute_steps('''
    When I make a "POST" request to "/v2/pet" endpoint with the payload:
   """
    {
      "id": 12349128349754,
      "category": {
        "id": 0,
        "name": "dog"
      },
      "name": "ravaneli",
      "tags": [
        {
          "id": 0,
          "name": "dog"
        }
      ],
      "status": "available"
    }
   """
   ''')
