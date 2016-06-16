# WebSiteSystem
A collection of tools (code generation, etc) for developping a PHP website to be hosted on shared hosting.

## Requirements
* [Apache Ant 1.9](https://ant.apache.org/)

## How to install

1. Clone this git repository on a local directory that will be accessible to all your projects.
2. To use a tool, call the ant build.xml with a specified target and appropriate parameters

E.g., in a project ant build file, one can see :

```xml
<ant dir="${path.code.generator.srcDatabaseTable}" target="generateFiles" inheritAll="false">
	<property name="param.dir.generator" value="php5"/>
	<property name="param.dir.database" value="mysql4"/>
	<property name="param.dir.build.generated" value="${dir.generated.php}/${path.classes}"/>
	<property name="param.dir.userfiles" value="${dir.src}/${path.database}"/>
	<property name="param.output.file.extension" value=".php"/>
</ant>
```

## Available tools

More to come...
