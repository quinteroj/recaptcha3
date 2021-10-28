<cfscript>
	param name="args.size" default="normal"; // normal, or compact
</cfscript>
<cfoutput>
	<cfif isnull( prc.recaptcha_inited )>
		<!--- <script type="text/javascript" src="#getModuleSettings( "recaptcha" ).scriptURL#" defer></script> --->
		<cfset prc.recaptcha_inited = true>
	</cfif>
	<!--- <div
		class="g-recaptcha"
		data-sitekey="#getModuleSettings( "recaptcha" ).publicKey#"
		data-size="#args.size#"
	></div> --->

	<button class="g-recaptcha" 
        data-sitekey="#getModuleSettings( "recaptcha" ).publicKey#" 
        data-callback='onSubmit' 
        data-action='submit'>Submit</button>
</cfoutput>