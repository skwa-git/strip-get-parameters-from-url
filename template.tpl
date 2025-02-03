___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Strip GET parameters from URLs",
  "categories": ["TAG_MANAGEMENT", "Funktionalität"],
  "description": "This variable strips GET parameters from a URL and returns the URL without the parameters. The parameters can be defined in a comma-separated list.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "LABEL",
    "name": "description",
    "displayName": "Enter the input URL and the the GET parameters you want to strip from the URL."
  },
  {
    "type": "TEXT",
    "name": "inputURL",
    "displayName": "Input URL",
    "simpleValueType": true,
    "defaultValue": "{{Page URL}}"
  },
  {
    "type": "TEXT",
    "name": "inputParams",
    "displayName": "Parameters to strip",
    "simpleValueType": true,
    "alwaysInSummary": true,
    "help": "If there is more than one parameter you want to strip, separate them by commas. Tip: Create the comma-separated list in a text editor and then just copy/paste it into the field.",
    "valueHint": "hash, fbclid, mc_cid, mc_eid, msclkid, epik, ttclid, cid, firstname, first_name, lastname, last_name, password, phone, email"
  },
  {
    "type": "LABEL",
    "name": "helpfulParams",
    "displayName": "Example Parameters (for copy/paste, feel free to add more): hash, fbclid, mc_cid, mc_eid, msclkid, epik, ttclid, cid, firstname, first_name, lastname, last_name, password, phone, email"
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// Retrieve inputs from GTM template fields
const inputURL = data.inputURL || '';
const inputParams = data.inputParams || '';

// Convert inputParams into an array, trimming whitespace and removing empty values
const paramsToStrip = inputParams.split(',').map(function(param) {
  return param.trim();
}).filter(function(param) {
  return param.length > 0;
});

// Separate the URL into base and query string parts
const urlParts = inputURL.split('?');
const baseURL = urlParts[0];
const queryString = urlParts[1];

// If there's no query string, return the original URL
if (!queryString) {
  return inputURL;
}

// Parse query string into individual key-value pairs
const queryParams = queryString.split('&').map(function(param) {
  return param.split('=');
});

// Helper function to check if a parameter is in the list of params to strip
function isParamInStripList(param) {
  for (var i = 0; i < paramsToStrip.length; i++) {
    if (paramsToStrip[i] === param) {
      return true;
    }
  }
  return false;
}

// Filter out parameters specified in paramsToStrip
const filteredParams = queryParams.filter(function(pair) {
  return !isParamInStripList(pair[0]);
});

// Rebuild the URL
const newQueryString = filteredParams.map(function(pair) {
  return pair.join('=');
}).join('&');
const finalURL = newQueryString ? baseURL + '?' + newQueryString : baseURL;

// Return the modified URL
return finalURL;


___TESTS___

scenarios:
- name: Remove 2 parameters
  code: |-
    const mockData = {
      // Mocked field values
      inputURL: "https://www.example.com/?param=value&fbclid=456&epik=789",
      inputParams: "fbclid, epik"
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns the correct result.
    assertThat(variableResult).isNotEqualTo(undefined);
    assertThat(variableResult).isEqualTo("https://www.example.com/?param=value");
- name: Remove no parameters
  code: |-
    const mockData = {
      // Mocked field values
      inputURL: "https://www.example.com/?param=value",
      inputParams: "fbclid, epik"
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns the correct result.
    assertThat(variableResult).isNotEqualTo(undefined);
    assertThat(variableResult).isEqualTo("https://www.example.com/?param=value");
- name: URL without parameters
  code: |-
    const mockData = {
      // Mocked field values
      inputURL: "https://www.example.com/",
      inputParams: "fbclid, epik"
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns the correct result.
    assertThat(variableResult).isNotEqualTo(undefined);
    assertThat(variableResult).isEqualTo("https://www.example.com/");


___NOTES___

Created on 11/5/2024, 4:28:55 PM


