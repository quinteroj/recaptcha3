<cfscript>
	param name="args.id" default="recaptchaBtn";
	param name="args.label" default="Label";
	param name="args.loadRecaptchaApi" default="false";
</cfscript>
<cfoutput>
	<cfif isNull( prc.recaptcha_inited ) && args.loadRecaptchaApi>
		<script type="text/javascript" src="#getModuleSettings( "recaptcha3" ).scriptURL#" defer></script>
		<cfset prc.recaptcha_inited = true>
	</cfif>

	<button 
		id="#args.id#"
		class="g-recaptcha #args.class#"
		data-sitekey="#getModuleSettings( "recaptcha3" ).publicKey#" 
		data-callback="#args.callbackFunction#"
		data-action="submit"
	>
		#args.label#
	</button>
</cfoutput>