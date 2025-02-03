
# GTM Variable Template 'Strip GET parameters from URLs'


Import this variable template to remove a list of GET parameters from a URL and get the URL without the specified parameters as return value from the Variable.


## How it works

You specify a URL variable and a list of GET parameters as input. The variable then searches the input URL for the GET parameters. If it finds one or more of the parameters in the URL, it removes them and returns the cleaned URL as result. 

If it does not find any of the specified parameters, the variable returns the input URL without changes

Example 1: 
- Input URL: https://www.example.com/?param=value&fbclid=456&epik=789 
- Specified parameters: fbclid, epik
- Result: https://www.example.com/?param=value

Example 2: 
- Input URL: https://www.example.com/?param=value 
- Specified parameters: fbclid, epik
- Result: https://www.example.com/?param=value

## Fields to specify

To run this project, you will need to add the following environment variables to your .env file

`Input URL`: Enter a variable that contains a URL. In most cases you will use GTM's default variable {{Page URL}}

`Parameters to strip`: Here you add one or more parameters that you want to remove from the URL. If you want to remove more than one parameters, enter a comma-separated list of values. 
Examples: 

- fbclid
- fbclid, msclkid, hash


## When to use it?

You can use this variable template in the following scenarios (those are only examples, be creative with your cases):

- Remove click parameters from URLs before you send it to your tracking tool (e.g. remove fbclid from URLs before you send it to Google Analytics)
- Remove PII from URLs before sending it to your tracking tool (e.g. remove the parameter 'email' from your URLs to make sure, no email adresses are sent to your tracking tool)
- Remove hash parameters from your URLs to make sure, your page reports don't get inflated by a trillion different values that are not relevant for analysis
