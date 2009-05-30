<cfcomponent extends="wheels.test">

	<cffunction name="setup">
		<cfset variables.controller = createobject("component", "wheels.tests.ControllerBlank")>
		<cfset args = {}>
		<cfset args.html = '<h1>this</h1><p><a href="http://www.google.com" title="google">is</a></p><p>a <a href="mailto:someone@example.com" title="invalid email">test</a> to<br/><a name="anchortag">see</a> if this works or not.</p>'>
	</cffunction>

	<cffunction name="test_all_tags_should_be_stripped">
		<cfset loc = {}>
		<cfset loc.a = duplicate(args)>
		<cfset loc.e = variables.controller.stripTags(argumentcollection=loc.a)>
		<cfset loc.r = "thisisa test tosee if this works or not.">
		<cfset assert("loc.e eq loc.r")>
	</cffunction>

</cfcomponent>