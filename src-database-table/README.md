#src-database-table, a PHP code generator

src-database-table convert a database table model written in an ad-hoc XML format into a set of PHP classes allowing to query data (read/write) and to wrap row data into a PHP object.

##Requirements
* [Apache Ant 1.9](https://ant.apache.org/)

##Target platform
* [PHP 5](http://php.net/)
* [MySQL 5](http://www.mysql.com/)


##How to use src-database-table

1. If this is not the case yet, transform your project so that it has a build process ; use whatever you want, the only requirement is to be able to use ant from your build toolchain.
2. Somewhere in your project folder, create your model files.
3. In a build file for ant, call the ant script of src-database-table, using the appropriate target and the appropriate parameters
4. Run the ant script that build your project.

##Samples

###Model file

```xml
<?xml version="1.0"?>
<table classname="Article" tablename="content">
	<description>
		<p>Describe a Virtual Page Manager table.</p>
	</description>
	<model sidColumn="sid" sidName="Sid" sidType="integer" sidDefaultValue="0">
		<!-- core fields -->
		<property column="gid" name="Gid" type="char" length="128" defaultValue="''" notnull="true" unique="true">
			<description>
				<p>Content identifier. Timestamp YYYYmmddhhMM is recommended for blog articles.</p>
			</description>
		</property>
		<property column="pid" name="Pid" type="char" length="128" defaultValue="''" notnull="true" unique="true">
			<description>
				<p>Content category identifier.</p>
			</description>
		</property>
		<property column="level" name="Level" type="unsignedInteger" length="1" defaultValue="0">
			<description>
				<p>Number of level of ancestor. Should be identical to the number of '.' in pid.</p>
			</description>
		</property>
		<property column="label" name="Label" type="text" defaultValue="''">
			<description>
				<p>User friendly label, for identifying an item (might be used as a title).</p>
			</description>
		</property>
		<property column="data" name="Data" type="text" defaultValue="''">
			<description>
				<p>The content's data.</p>
			</description>
		</property>
		<property column="online" name="Online" type="unsignedInteger" length="1" defaultValue="0">
			<description>
				<p>Online flag.</p>
			</description>
		</property>
	</model>
	<filter>
		<!-- the "isCondition" attribute allow for generating stubs for this file -->
		<enum name="Mode" type="unsignedInteger" defaultValue="SID" isCondition="true">
			<description>
				<p>Name of the criteria to use when using the filter.</p>
			</description>
			<item name="SID" value="0"/>
			<item name="GID" value="1"/>
			<item name="PID" value="2"/>
		</enum>
		<enum name="Online" type="unsignedInteger" defaultValue="ONLINE">
			<description>
				<p>Allowed values for the "Online" filter.</p>
			</description>
			<item name="OFFLINE" value="0"/>
			<item name="ONLINE" value="1"/>
		</enum>
		<enum name="Order" type="string" defaultValue="ASC">
			<description>
				<p>'asc' for ordering in ascending order, 'desc' for the reverse.</p>
			</description>
			<item name="ASC" value="'asc'"/>
			<item name="DESC" value="'desc'"/>
		</enum>
		<property name="UseOnline" type="boolean" defaultValue="false" isCondition="true">
			<description>
				<p>If true, take into account the "Online" filter.</p>
			</description>
		</property>
		<property name="ExactMatch" type="boolean" defaultValue="false" isCondition="true">
			<description>
				<p>If true, look for an exact match, otherwise search for a string starting with the value.</p>
			</description>
		</property>
	</filter>
	<sql>
		<selectors>
			<defaultselector>
				<columns>
					<!-- sid is always selected -->
					<column name="gid"/>
					<column name="pid"/>
					<column name="level"/>
					<column name="label"/>
					<column name="data"/>
					<column name="online"/>
				</columns>
				<!--where operator="and">
					<whereCondition columnName="sid" operator="eq" filterName="Sid"/>
				</where-->
				<orderby>
					<column name="gid" order="desc"/>
				</orderby>
				<!-- groupby>
					<column name="gid" order="desc"/>
				</groupby -->
			</defaultselector>
			<!-- == == == <condition name="Mode" value="SID" enum="true"/> == == == -->
			<!-- <condition name="UseOnline" value="true"/> -->
			<selector>
				<description>
					<p>Retrieve a content by SID and having the specified online status.</p>
				</description>
				<conditionGroup operator="and">
					<condition name="Mode" value="SID" enum="true"/>
					<condition name="UseOnline" value="true"/>
				</conditionGroup>
				<columns>
					<!-- sid is always selected -->
					<column name="gid"/>
					<column name="pid"/>
					<column name="level"/>
					<column name="label"/>
					<column name="data"/>
					<column name="online"/>
				</columns>
				<where operator="and">
					<whereCondition columnName="online" operator="eq" filterName="Online"/>
					<whereCondition columnName="sid" operator="eq" filterName="Sid"/>
				</where>
				<orderby>
					<column name="gid"/>
				</orderby>
			</selector>
			<!-- <condition name="UseOnline" value="false"/> -->
			<selector>
				<description>
					<p>Retrieve any content by SID.</p>
				</description>
				<conditionGroup operator="and">
					<condition name="Mode" value="SID" enum="true"/>
					<condition name="UseOnline" value="false"/>
				</conditionGroup>
				<columns>
					<!-- sid is always selected -->
					<column name="gid"/>
					<column name="pid"/>
					<column name="level"/>
					<column name="label"/>
					<column name="data"/>
					<column name="online"/>
				</columns>
				<where operator="and">
					<whereCondition columnName="sid" operator="eq" filterName="Sid"/>
				</where>
				<orderby>
					<column name="gid"/>
				</orderby>
			</selector>
			<!-- == == == <condition name="Mode" value="GID" enum="true"/> == == == -->
			<!-- <condition name="UseOnline" value="true"/> -->
			<selector>
				<description>
					<p>Retrieve a content by GID and having the specified online status.</p>
				</description>
				<conditionGroup operator="and">
					<condition name="Mode" value="GID" enum="true"/>
					<condition name="ExactMatch" value="true"/>
					<condition name="UseOnline" value="true"/>
				</conditionGroup>
				<columns>
					<!-- sid is always selected -->
					<column name="gid"/>
					<column name="pid"/>
					<column name="level"/>
					<column name="label"/>
					<column name="data"/>
					<column name="online"/>
				</columns>
				<where operator="and">
					<whereCondition columnName="online" operator="eq" filterName="Online"/>
					<whereCondition columnName="gid" operator="eq" filterName="Gid"/>
				</where>
				<orderby>
					<column name="gid" order="desc"/>
				</orderby>
			</selector>
			<selector>
				<description>
					<p>Retrieve a content that has a GID "like" the specified one and having the specified online status.</p>
				</description>
				<conditionGroup operator="and">
					<condition name="Mode" value="GID" enum="true"/>
					<condition name="ExactMatch" value="false"/>
					<condition name="UseOnline" value="true"/>
				</conditionGroup>
				<columns>
					<!-- sid is always selected -->
					<column name="gid"/>
					<column name="pid"/>
					<column name="level"/>
					<column name="label"/>
					<column name="data"/>
					<column name="online"/>
				</columns>
				<where operator="and">
					<whereCondition columnName="online" operator="eq" filterName="Online"/>
					<whereCondition columnName="gid" operator="like" filterName="Gid"/>
				</where>
				<orderby>
					<column name="gid" order="desc"/>
				</orderby>
			</selector>
			<!-- <condition name="UseOnline" value="false"/> -->
			<selector>
				<description>
					<p>Retrieve a content by GID.</p>
				</description>
				<conditionGroup operator="and">
					<condition name="Mode" value="GID" enum="true"/>
					<condition name="ExactMatch" value="true"/>
					<condition name="UseOnline" value="false"/>
				</conditionGroup>
				<columns>
					<!-- sid is always selected -->
					<column name="gid"/>
					<column name="pid"/>
					<column name="level"/>
					<column name="label"/>
					<column name="data"/>
					<column name="online"/>
				</columns>
				<where operator="and">
					<whereCondition columnName="gid" operator="eq" filterName="Gid"/>
				</where>
				<orderby>
					<column name="gid" order="desc"/>
				</orderby>
			</selector>
			<selector>
				<description>
					<p>Retrieve a content that has a GID "like" the specified one.</p>
				</description>
				<conditionGroup operator="and">
					<condition name="Mode" value="GID" enum="true"/>
					<condition name="ExactMatch" value="false"/>
					<condition name="UseOnline" value="false"/>
				</conditionGroup>
				<columns>
					<!-- sid is always selected -->
					<column name="gid"/>
					<column name="pid"/>
					<column name="level"/>
					<column name="label"/>
					<column name="data"/>
					<column name="online"/>
				</columns>
				<where operator="and">
					<whereCondition columnName="gid" operator="like" filterName="Gid"/>
				</where>
				<orderby>
					<column name="gid" order="desc"/>
				</orderby>
			</selector>
			<selector>
				<description>
					<p>Retrieve a list of content - blog.</p>
				</description>
				<conditionGroup operator="and">
					<condition name="Mode" value="PID" enum="true"/>
					<condition name="UseOnline" value="true"/>
				</conditionGroup>
				<columns>
					<!-- sid is always selected -->
					<column name="gid"/>
					<column name="pid"/>
					<column name="level"/>
					<column name="label"/>
					<column name="data"/>
					<column name="online"/>
				</columns>
				<where operator="and">
					<whereCondition columnName="pid" operator="like" filterName="Pid"/>
					<whereCondition columnName="online" operator="eq" filterName="Online"/>
				</where>
				<orderby>
					<column name="gid" order="desc"/>
				</orderby>
			</selector>
		</selectors>
		<deletors>
			<!-- == == == <condition name="Mode" value="SID" enum="true"/> == == == -->
			<!-- <condition name="UseOnline" value="true"/> -->
			<deletor>
				<conditionGroup operator="and">
					<condition name="Mode" value="SID" enum="true"/>
					<condition name="ExactMatch" value="true"/>
					<condition name="UseOnline" value="true"/>
				</conditionGroup>
				<where operator="and">
					<whereCondition columnName="online" operator="eq" filterName="Online"/>
					<whereCondition columnName="sid" operator="eq" filterName="Sid"/>
				</where>
			</deletor>
			<!-- == == == <condition name="Mode" value="GID" enum="true"/> == == == -->
			<!-- <condition name="UseOnline" value="true"/> -->
			<deletor>
				<conditionGroup operator="and">
					<condition name="Mode" value="GID" enum="true"/>
					<condition name="ExactMatch" value="true"/>
					<condition name="UseOnline" value="true"/>
				</conditionGroup>
				<where operator="and">
					<whereCondition columnName="online" operator="eq" filterName="Online"/>
					<whereCondition columnName="gid" operator="eq" filterName="Gid"/>
				</where>
			</deletor>
			<!-- <condition name="UseOnline" value="false"/> -->
			<deletor>
				<conditionGroup operator="and">
					<condition name="Mode" value="SID" enum="true"/>
					<condition name="ExactMatch" value="false"/>
					<condition name="UseOnline" value="true"/>
				</conditionGroup>
				<where operator="and">
					<whereCondition columnName="online" operator="eq" filterName="Online"/>
					<whereCondition columnName="gid" operator="like" filterName="Gid"/>
				</where>
			</deletor>
		</deletors>
	</sql>
</table>
```

###Sample call inside a ant build script

```xml
		<!-- call to src-database-table -->
		<mkdir dir="${dir.src}/${path.database}"/> <!-- avoid failure for missing directory, replace by test -->
		<ant dir="${path.code.generator.srcDatabaseTable}" target="generateFiles" inheritAll="false">
			<property name="param.dir.generator" value="php5"/>
			<property name="param.dir.database" value="mysql4"/>
			<property name="param.dir.build.generated" value="${dir.generated.php}/${path.classes}"/>
			<property name="param.dir.userfiles" value="${dir.src}/${path.database}"/>
			<property name="param.output.file.extension" value=".php"/>
		</ant>
```
