<cffunction name="simpleFormat" returntype="any" access="public" output="false">
	<cfargument name="text" type="any" required="yes">
	<cfset var local = structNew()>

	<!--- Replace single newline characters with HTML break tags and double newline characters with HTML paragraph tags --->
	<cfset local.output = trim(arguments.text)>
	<cfset local.output = replace(local.output, "#chr(10)##chr(10)#", "</p><p>", "all")>
	<cfset local.output = replace(local.output, "#chr(10)#", "<br />", "all")>
	<cfif local.output IS NOT "">
		<cfset local.output = "<p>" & local.output & "</p>">
	</cfif>

	<cfreturn local.output>
</cffunction>


<cffunction name="autoLink" returntype="any" access="public" output="false">
	<cfargument name="text" type="any" required="yes">
	<cfargument name="link" type="any" required="no" default="all">
	<cfargument name="attributes" type="any" required="no" default="">
	<cfset var local = structNew()>

	<cfset local.url_regex = "(?ix)([^(url=)|(href=)'""])(((https?)://([^:]+\:[^@]*@)?)([\d\w\-]+\.)?[\w\d\-\.]+\.(com|net|org|info|biz|tv|co\.uk|de|ro|it)(( / [\w\d\.\-@%\\\/:]* )+)?(\?[\w\d\?%,\.\/\##!@:=\+~_\-&amp;]*(?<![\.]))?)">
	<cfset local.mail_regex = "(([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,}))">

	<cfif len(arguments.attributes) IS NOT 0>
		<!--- Add a space to the beginning so it can be directly inserted in the HTML link element below --->
		<cfset arguments.attributes = " " & arguments.attributes>
	</cfif>

	<cfset local.output = arguments.text>
	<cfif arguments.link IS NOT "urls">
		<!--- Auto link all email addresses --->
		<!--- <cfset local.output = REReplaceNoCase(local.output, "(([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,}))", "<a href=""mailto:\1""#arguments.attributes#>\1</a>", "all")> --->
		<cfset local.output = REReplaceNoCase(local.output, local.mail_regex, "<a href=""mailto:\1""#arguments.attributes#>\1</a>", "all")>
	</cfif>
	<cfif arguments.link IS NOT "email_addresses">
		<!--- Auto link all URLs --->
		<!--- <cfset local.output = REReplaceNoCase(local.output, "(\b(?:https?|ftp)://(?:[a-z\d-]+\.)+[a-z]{2,6}(?:/\S*)?)", "<a href=""\1""#arguments.attributes#>\1</a>", "all")> --->
		<cfset local.output = local.output.ReplaceAll(local.url_regex, "$1<a href=""$2""#arguments.attributes#>$2</a>")>
	</cfif>

	<cfreturn local.output>
</cffunction>

<cffunction name="highlight" returntype="any" access="public" output="false">
	<cfargument name="text" type="any" required="yes">
	<cfargument name="phrase" type="any" required="yes">
	<cfargument name="class" type="any" required="no" default="highlight">
	<cfreturn REReplaceNoCase(arguments.text, "(#arguments.phrase#)", "<span class=""#arguments.class#"">\1</span>", "all")>
</cffunction>


<cffunction name="stripTags" returntype="any" access="public" output="false">
	<cfargument name="text" type="any" required="true">
	<cfreturn REReplaceNoCase(arguments.text, "<[a-z].*?>(.*?)</[a-z]>", "\1" , "all")>
</cffunction>


<cffunction name="stripLinks" returntype="any" access="public" output="false">
	<cfargument name="text" type="any" required="true">
	<cfreturn REReplaceNoCase(arguments.text, "<a.*?>(.*?)</a>", "\1" , "all")>
</cffunction>