# WebSiteSystem
A collection of tools (code generation, etc) for developping a PHP website to be hosted on shared hosting.

>    This program is free software: you can redistribute it and/or modify
>    it under the terms of the GNU General Public License as published by
>    the Free Software Foundation, either version 3 of the License, or
>    (at your option) any later version.
>
>    This program is distributed in the hope that it will be useful,
>    but WITHOUT ANY WARRANTY; without even the implied warranty of
>    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>    GNU General Public License for more details.
>
>    You should have received a copy of the GNU General Public License
>    along with this program.  If not, see <http://www.gnu.org/licenses/>. 1



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
