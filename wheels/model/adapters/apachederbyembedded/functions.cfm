<cffunction name="generatedKey" returntype="string" access="public" output="false">
	<cfreturn "identitycol">
</cffunction>

<cffunction name="randomOrder" returntype="string" access="public" output="false">
	<cfreturn "RANDOM()">
</cffunction>

<cffunction name="getType" returntype="string" access="public" output="false">
	<cfargument name="type" type="string" required="true">
	<cfscript>
		var loc = {};
		switch(arguments.type)
		{
			case "bigint": {loc.returnValue = "cf_sql_bigint"; break;}
			case "char for bit data": {loc.returnValue = "cf_sql_bit";	break;}
			case "blob": {loc.returnValue = "cf_sql_blob";	break;}
			case "clob": {loc.returnValue = "cf_sql_clob"; break;}
			case "char": {loc.returnValue = "cf_sql_char"; break;}
			case "date": {loc.returnValue = "cf_sql_date"; break;}
			case "decimal": case "numeric": {loc.returnValue = "cf_sql_decimal"; break;}
			case "double": case "double precision": {loc.returnValue = "cf_sql_double"; break;}
			case "float": case "real": {loc.returnValue = "cf_sql_float"; break;}
			case "integer": {loc.returnValue = "cf_sql_integer"; break;}
			case "smallint": case "year": {loc.returnValue = "cf_sql_smallint"; break;}
			case "time": {loc.returnValue = "cf_sql_time"; break;}
			case "timestamp": {loc.returnValue = "cf_sql_timestamp"; break;}
			case "tinyint": {loc.returnValue = "cf_sql_tinyint"; break;}
			case "varbinary": {loc.returnValue = "cf_sql_varbinary"; break;}
			case "varchar": {loc.returnValue = "cf_sql_varchar"; break;}
			case "long varchar": case "xml": {loc.returnValue = "cf_sql_longvarchar"; break;}
		}
	</cfscript>
	<cfreturn loc.returnValue>
</cffunction>

<cffunction name="query" returntype="struct" access="public" output="false">
	<cfargument name="sql" type="array" required="true">
	<cfargument name="limit" type="numeric" required="false" default=0>
	<cfargument name="offset" type="numeric" required="false" default=0>
	<cfargument name="parameterize" type="boolean" required="true">
	<cfscript>
		var loc = {};
		var query = {};
		arguments.name = "query.name";
		arguments.result = "loc.result";
		arguments.datasource = variables.instance.connection.datasource;
		arguments.username = variables.instance.connection.username;
		arguments.password = variables.instance.connection.password;
		loc.sql = arguments.sql;
		loc.limit = arguments.limit;
		loc.offset = arguments.offset;
		loc.parameterize = arguments.parameterize;
		StructDelete(arguments, "sql");
		StructDelete(arguments, "limit");
		StructDelete(arguments, "offset");
		StructDelete(arguments, "parameterize");
	</cfscript>
	<cfquery attributeCollection="#arguments#"><cfloop array="#loc.sql#" index="loc.i"><cfif IsStruct(loc.i)><cfif IsBoolean(loc.parameterize) AND loc.parameterize><cfset loc.queryParamAttributes = StructNew()><cfset loc.queryParamAttributes.cfsqltype = loc.i.type><cfset loc.queryParamAttributes.value = loc.i.value><cfif StructKeyExists(loc.i, "null")><cfset loc.queryParamAttributes.null = loc.i.null></cfif><cfif StructKeyExists(loc.i, "scale") AND loc.i.scale GT 0><cfset loc.queryParamAttributes.scale = loc.i.scale></cfif><cfqueryparam attributeCollection="#loc.queryParamAttributes#"><cfelse>'#loc.i.value#'</cfif><cfelse>#preserveSingleQuotes(loc.i)#</cfif>#chr(13)##chr(10)#</cfloop><cfif loc.limit>LIMIT #loc.limit#<cfif loc.offset>#chr(13)##chr(10)#OFFSET #loc.offset#</cfif></cfif></cfquery>
	<cfscript>
		loc.returnValue.result = loc.result;
		if (StructKeyExists(query, "name"))
			loc.returnValue.query = query.name;
	</cfscript>
	<cfreturn loc.returnValue>
</cffunction>