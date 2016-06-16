<?xml version="1.0"?>
<!-- 
(c)2006 David Sporn

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public
License version 3 as published by the Free Software Foundation.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- Main part -->
<xsl:template match="table">
	<xsl:apply-templates select="filter"/>
</xsl:template>

<xsl:template match="filter">
	<FormBody>
		<xsl:attribute name="layout">Div</xsl:attribute>
		<xsl:attribute name="ResourceCall">getMessage</xsl:attribute>
		<xsl:attribute name="classname"><xsl:value-of select="concat(../@classname, 'FilterForm')"/></xsl:attribute>
		<xsl:attribute name="package">database.table</xsl:attribute>
		<xsl:apply-templates select="property|enum"/>
	</FormBody>
</xsl:template>

<xsl:template match="property">
	<field>
		<xsl:attribute name="type">SingleLineText</xsl:attribute>
		<xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
		<xsl:attribute name="valueSource">formData</xsl:attribute>
		<xsl:attribute name="labelKey"><xsl:value-of select="concat(../../@classname,'_Model_',@name)"/></xsl:attribute>
		<xsl:copy-of select="description"/>
	</field>
</xsl:template>

<xsl:template match="property[@type='text']">
	<field>
		<xsl:attribute name="type">text</xsl:attribute>
		<xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
		<xsl:attribute name="valueSource">formData</xsl:attribute>
		<xsl:attribute name="labelKey"><xsl:value-of select="concat(../../@classname,'_Model_',@name)"/></xsl:attribute>
		<xsl:copy-of select="description"/>
	</field>
</xsl:template>

<xsl:template match="enum">
	<field>
		<xsl:attribute name="type">radio</xsl:attribute>
		<xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
		<xsl:attribute name="valueSource">formData</xsl:attribute>
		<xsl:attribute name="labelKey"><xsl:value-of select="concat(../../@classname,'_Model_',@name)"/></xsl:attribute>
		<xsl:attribute name="layout">List</xsl:attribute>
		<xsl:copy-of select="description"/>
		<xsl:apply-templates select="item"/>
	</field>
</xsl:template>

<xsl:template match="item">
	<option>
		<xsl:attribute name="value"><xsl:value-of select="@value"/></xsl:attribute>
		<xsl:attribute name="labelKey"><xsl:value-of select="concat(../../../@classname,'_Filter_',../@name, '_', @name)"/></xsl:attribute>
	</option>
</xsl:template>

</xsl:stylesheet>