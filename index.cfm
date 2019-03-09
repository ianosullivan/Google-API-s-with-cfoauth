

<!--- 
	This is a 2-step process;
	1 - Get the oauth access_token to get a fresh access_token
	2 - Use the access token to get required data
--->
<!---
	Step 1: Get the access token using oauth.
	Before we can do this we need the;
	- 'clientid' 
	- 'secretkey'
	These are created in the Google API Console here - https://console.cloud.google.com/apis/credentials. 
	Within the API console you need to create a 'Project' and within this you get the 'clientid' and 'secretkey'

	
	We also need to specify the 'scope' which is the API we want access to. The access_token generated is tied to this 'scope'
	For more on the Google Photo scopes see here - https://developers.google.com/photos/library/guides/authentication-authorization

	Lastly we need to specify the 'redirecturi' param. This has to match the value in the Google API Console. See here - https://take.ms/ksWpV
	
	Notes:
	* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
	The default expiry for google oauth2 access token is 1 hour. 
	The expiry_date is in the Unix epoch time in milliseconds. If you want to read this in human readable format then you can simply check it here..Unix timestamp to human readable time
	Using the access_token created below you can get 'token info' using - https://www.googleapis.com/oauth2/v3/tokeninfo?access_token=[ACCESS_TOKEN]. This returns JSON data like this - https://take.ms/kUpiN.
	The `expires_in` value is the number of seconds left before expiration of the token
 --->
<cfoauth
	type="Google"
	clientid="891686916073-umsrd54j62g4pk2sagtgtig7s78tqgi5.apps.googleusercontent.com"
	secretkey="qynGFdeJ5_QoSI5ulnzHifzD"
	scope="https://www.googleapis.com/auth/photoslibrary"
	result="oauth_result"
	redirecturi="http://127.0.0.1:8501/sites/_testing/"
>
<cfdump var="#oauth_result#">


<!--- 
	Step 2: Use the access_token created from '<cfoauth>' above to 'GET' the data you want. 
		Note: If this was changed to a 'POST' request (with URL https://photoslibrary.googleapis.com/v1/albums) it expected that you are trying to create a new album
	For more API endpoints see here - https://developers.google.com/photos/library/reference/rest/v1/albums/list
	This returns JSON data that needs to be parsed (via deserializeJSON) so it can be used by CFML
--->
<!--- <cfhttpparam name="Content-Type" type="header" value="application/json" /> --->
<cfhttp method="GET" charset="utf-8" url="https://photoslibrary.googleapis.com/v1/albums" result="res">
	<cfhttpparam name="Authorization" type="header" value="OAuth #oauth_result.access_token#" />
</cfhttp>
<cfdump var="#deserializeJSON(res.filecontent)#">

