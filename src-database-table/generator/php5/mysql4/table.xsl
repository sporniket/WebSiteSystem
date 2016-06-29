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
<xsl:output method="text" encoding="iso-8859-15"/>
<!--(c)2005 David Sporn-->
<!-- == == == == == == == == == Main part == == == == == == == == == -->
	<xsl:template match="table"><![CDATA[<?php 
/****** GENERATED CODE - DO NOT EDIT ******/
require_once('lib/DatabaseTable.php') ;

/*]]><xsl:value-of select="description"/><![CDATA[
 *
 * This Componant contains the following entities : 
 *     Db]]><xsl:value-of select="@classname" /><![CDATA[Filter
 *     Db]]><xsl:value-of select="@classname" /><![CDATA[Row
 *     Db]]><xsl:value-of select="@classname" /><![CDATA[Table
 */

/**Class containing criteria for building a SQL selection.
 */
class Db]]><xsl:value-of select="@classname"/><![CDATA[Filter
{
]]><xsl:apply-templates select="." mode="Filter"/><![CDATA[
}

/**Class for storing one row of the database table.
 */
class Db]]><xsl:value-of select="@classname"/><![CDATA[Row
{
]]><xsl:apply-templates select="." mode="Row"/><![CDATA[
}

/**Operations on the database table
 */
class Db]]><xsl:value-of select="@classname"/><![CDATA[Table
{
]]><xsl:apply-templates select="." mode="Table"/><![CDATA[
}
?>]]>
	</xsl:template>



<!-- == == == == == == == == == Bean generation == == == == == == == == == -->
	<xsl:template match="table" mode="Row"><![CDATA[
	//========================================
	//Constructor
	function Db]]><xsl:value-of select="@classname"/><![CDATA[Row()
	{]]><xsl:apply-templates select="model/property" mode="FieldInitializer"/><![CDATA[
	}
		
	//========================================
	//Accessors]]><xsl:apply-templates select="model/property" mode="Accessor"/><![CDATA[
	
	//=== Sid =================================
	function get]]><xsl:value-of select="model/@sidName"/><![CDATA[()
	{
		return $this->my]]><xsl:value-of select="model/@sidName"/><![CDATA[ ;
	}

	function setSid($new]]><xsl:value-of select="model/@sidName"/><![CDATA[)
	{
		$this->mySid = $new]]><xsl:value-of select="model/@sidName"/><![CDATA[ ;
	}

	//========================================
	//Fields]]><xsl:apply-templates select="model/property" mode="Field"/><![CDATA[
	var $my]]><xsl:value-of select="model/@sidName"/><![CDATA[ ;
]]>
	</xsl:template>




<!-- == == == == == == == == == Filter generation == == == == == == == == == -->
	<xsl:template match="table" mode="Filter"><![CDATA[
	//========================================
	//Constants]]><xsl:apply-templates select="filter/enum" mode="DeclareValues"/><![CDATA[
	
	//========================================
	//Constructor
	function Db]]><xsl:value-of select="@classname"/><![CDATA[Filter()
	{]]><xsl:apply-templates select="filter/enum" mode="FieldInitializer"/>
	<xsl:apply-templates select="filter/property" mode="FieldInitializer"/>
	<xsl:apply-templates select="model/property[@type='char' or @type='unsignedInteger' or @type='']" mode="FieldInitializer">
		<xsl:with-param name="checkEnum" select="1"/>
	</xsl:apply-templates><![CDATA[
	}
		
	//========================================
	//Accessors]]><xsl:apply-templates select="filter/enum" mode="Accessor"/>
	<xsl:apply-templates select="filter/property" mode="Accessor"/>
	<xsl:apply-templates select="model/property[@type='char' or @type='unsignedInteger' or @type='']" mode="Accessor">
		<xsl:with-param name="checkEnum" select="1"/>
	</xsl:apply-templates><![CDATA[
	
	//=== Sid =================================
	function get]]><xsl:value-of select="model/@sidName"/><![CDATA[()
	{
		return $this->my]]><xsl:value-of select="model/@sidName"/><![CDATA[ ;
	}

	function setSid($new]]><xsl:value-of select="model/@sidName"/><![CDATA[)
	{
		$this->mySid = $new]]><xsl:value-of select="model/@sidName"/><![CDATA[ ;
	}

	//========================================
	//Fields]]><xsl:apply-templates select="filter/enum" mode="Field"/>
	<xsl:apply-templates select="filter/property" mode="Field"/>
	<xsl:apply-templates select="model/property[@type='char' or @type='unsignedInteger' or @type='']" mode="Field">
		<xsl:with-param name="checkEnum" select="1"/>
	</xsl:apply-templates><![CDATA[
	var $my]]><xsl:value-of select="model/@sidName"/><![CDATA[ ;
]]>
	</xsl:template>



<!-- == == == == == == == == == Table operation generation == == == == == == == == == -->
	<xsl:template match="table" mode="Table"><![CDATA[
	//========================================
	//Constructor
	function Db]]><xsl:value-of select="@classname"/><![CDATA[Table($tableNameSpace = '', $modelNameSpace = '')
	{
		$this->myTable = $tableNameSpace.']]><xsl:value-of select="@tablename"/><![CDATA[' ; //the name of the table
		$this->myModel = array() ;
		$this->myModel[']]><xsl:value-of select="model/@sidColumn"/><![CDATA['] = $modelNameSpace.']]><xsl:value-of select="model/@sidColumn"/><![CDATA[';
		]]><xsl:apply-templates select="model/property" mode="InitModel"/><![CDATA[
	}
	
	//========================================
	//Operations
	/**Select rows from the table according to a filter.
	 * @param filter the filter (might be null)
	 * @param rangeStart (>=0 : skip the $rangeStart first records)
	 * @param rangeLength ($rangeStart >= 0 && $rangeLength > 0 : return only $rangeLength records)
	 * @return an array of Db]]><xsl:value-of select="@classname" /><![CDATA[Row
	 */
	function getList($filter = null, $rangeStart = -1, $rangeLength = 0)
	{
		//Sanity check
		if ($rangeStart >= 0 && $rangeLength <= 0)
		{
			return array() ;
		}
		$list_retour = array() ;
		//TODO : Build the sql request using the optionnal filter
		$sql = '' ;
		if (null == $filter) //default selector
		{
			$columnList = array() ;
			$columnList[] = $this->myModel[']]><xsl:value-of select="model/@sidColumn"/><![CDATA['] ;]]><xsl:apply-templates select="sql/selectors/defaultselector/columns" mode="buildColumnList">
			<xsl:with-param name="variable_name" select="'columnList'"/>
		</xsl:apply-templates><![CDATA[

			$whereList = array() ; ]]><xsl:apply-templates select="sql/selectors/defaultselector/where" mode="buildWhereConditions">
			<xsl:with-param name="variable_name" select="'whereList'"/>
			<xsl:with-param name="filter_name" select="'$filter_name'"/>
		</xsl:apply-templates><![CDATA[
		
			$whereOperator = ']]><xsl:value-of select="sql/selectors/defaultselector/where/@operator"/><![CDATA[';

			$orderList = array() ;]]><xsl:apply-templates select="sql/selectors/defaultselector/orderby" mode="buildOrderByList">
			<xsl:with-param name="variable_name" select="'orderList'"/>
		</xsl:apply-templates><![CDATA[

			$groupList = array() ;]]><xsl:apply-templates select="sql/selectors/defaultselector/groupby" mode="buildGroupByList">
			<xsl:with-param name="variable_name" select="'orderList'"/>
		</xsl:apply-templates><![CDATA[

			$sql = buildSqlSelect ($this->myTable, $columnList, $whereList, $whereOperator, $orderList, $groupList)
		}
		]]><xsl:apply-templates select="sql/selectors" mode="buildSelectors">
			<xsl:with-param name="filter_name" select="'filter'"/>
			<xsl:with-param name="sid_name" select="model/@sidColumn"/>
		</xsl:apply-templates><![CDATA[
		else //no valid case
		{
			return $list_retour ;
		}

		$db_result = mysql_query($sql) ;
		$row_counter = 0 ;
		
		while ($next_record = @mysql_fetch_array($db_result))
		{
			if ($rangeStart >= 0 && $row_counter < $rangeStart)
			{
				$row_counter++ ;
				continue ; //range not reached yet
			}
			else if ($rangeStart >= 0 && ($rangeStart + $rangeLength) <= $row_counter)
			{
				break ; //range ends
			}
			$new_row = new Db]]><xsl:value-of select="@classname" /><![CDATA[Row ;
			
			//[fill the row]
			$new_row->setSid((integer)($next_record[$this->myModel[']]><xsl:value-of select="model/@sidColumn"/><![CDATA[']])) ;
			]]><xsl:apply-templates select="model/property" mode="fillRow"/><![CDATA[
			
			array_push($list_retour, $new_row) ;
			$row_counter++ ;
		}

		return $list_retour ;
	}
	
	/**Insert a row from a Db]]><xsl:value-of select="@classname" /><![CDATA[Row.
	 * @param row the Db]]><xsl:value-of select="@classname" /><![CDATA[Row
	 * @return -1 if the query failed
	 */
	function insert($row)
	{
		$sql = '' ;
		
		//SQL
		$columnList = array() ;]]><xsl:apply-templates select="model" mode="buildColumnList">
			<xsl:with-param name="variable_name" select="'columnList'"/>
		</xsl:apply-templates><![CDATA[
		
		$valueList = array() ;]]><xsl:apply-templates select="model" mode="buildValueList">
			<xsl:with-param name="variable_name" select="'valueList'"/>
			<xsl:with-param name="source_name" select="'row'"/>
		</xsl:apply-templates><![CDATA[
		
		$sql = buildInsertQuery($this->myTable, $columnList, $valueList) ;
		mysql_query($sql);
		return mysql_affected_rows() ;
	}
	
	/**Update a row from a Db]]><xsl:value-of select="@classname" /><![CDATA[Row.
	 * @param row the Db]]><xsl:value-of select="@classname" /><![CDATA[Row
	 * @return -1 if the query failed
	 */
	function update($row)
	{
		$sql = '' ;
		
		//SQL
		$columnList = array() ;]]><xsl:apply-templates select="model" mode="buildColumnList">
			<xsl:with-param name="variable_name" select="'columnList'"/>
		</xsl:apply-templates><![CDATA[
		
		$valueList = array() ;]]><xsl:apply-templates select="model" mode="buildValueList">
			<xsl:with-param name="variable_name" select="'valueList'"/>
			<xsl:with-param name="source_name" select="'row'"/>
		</xsl:apply-templates><![CDATA[

		$whereList = array() ;
		$whereList[] = buildCondition($this->myModel[']]><xsl:value-of select="model/@sidColumn"/><![CDATA['], $filter->get]]><xsl:value-of select="model/@sidName"/><![CDATA[(), 'eq', ']]><xsl:value-of select="model/@sidType"/><![CDATA[') ;
		
		$sql = buildUpdateQuery($this->myTable, $columnList, $valueList, $whereList, 'and') ;
		mysql_query($sql);
		return mysql_affected_rows() ;
	}
	
	/**Delete using Db]]><xsl:value-of select="@classname" /><![CDATA[Row (delete a row) or a Db]]><xsl:value-of select="@classname" /><![CDATA[Filter.
	 * @param filter the Db]]><xsl:value-of select="@classname" /><![CDATA[Row or Db]]><xsl:value-of select="@classname" /><![CDATA[Filter
	 * @return -1 if the query failed
	 */
	function delete($filter)
	{
		if (is_a($filter, 'Db]]><xsl:value-of select="@classname" /><![CDATA[Filter'))
		{
			return deleteUsingFilter($filter) ;
		}
		else if (is_a($filter, 'Db]]><xsl:value-of select="@classname" /><![CDATA[Row'))
		{
			return deleteUsingRow($filter) ;
		}
		else
		{
			return -1 ;
		}
	}

	function deleteUsingFilter($filter)
	{
		//TODO : Build the sql request using either a filter, either a row
		$sql = null ;
		
		if (null == $filter)
		{
			return -1 ;
		}
		]]><xsl:apply-templates select="sql/deletors" mode="buildDeletors">
			<xsl:with-param name="filter_name" select="'filter'"/>
			<xsl:with-param name="sid_name" select="model/@sidColumn"/>
		</xsl:apply-templates><![CDATA[
		else
		{
			return -1 ;
		}
		
		mysql_query($sql) ;
		return mysql_affected_rows() ;
	}

	/**Delete using Db]]><xsl:value-of select="@classname" /><![CDATA[Row (delete a row).
	 * @param filter the Db]]><xsl:value-of select="@classname" /><![CDATA[Row
	 * @return -1 if the query failed
	 */
	function deleteUsingRow($filter)
	{
		$sql = null ;
		
		if (null != $filter)
		{
			//build the sql request with a row
			//$sql = 'delete from '.$this->myTable.' where '.$this->myModel['sid'].' = '.(integer)$filter->getSid() ;
			$whereList = array() ;
			$whereList[] = buildCondition($this->myModel[']]><xsl:value-of select="model/@sidColumn"/><![CDATA['], $filter->get]]><xsl:value-of select="model/@sidName"/><![CDATA[(), 'eq', ']]><xsl:value-of select="model/@sidType"/><![CDATA[') ;
			$sql = buildDeleteQuery($this->myTable, $whereList, 'and') ;
		}
		else
		{
			return -1 ;
		}
		
		mysql_query($sql) ;
		return mysql_affected_rows() ;
	}
	
	//========================================
	//Fields
	var $myTable ;
	var $myModel ;
	
]]>
	</xsl:template>



<!-- == == == == == == == == == Common == == == == == == == == == -->
	<xsl:template match="property" mode="Accessor">
		<xsl:param name="checkEnum" select="0"/>
		<xsl:variable name="ref_name" select="@name"/>
		<xsl:if test="$checkEnum=0 or count(../../filter/enum[@name=$ref_name])=0"><![CDATA[
	
	//============= ]]><xsl:value-of select="@name"/><![CDATA[ =============
	/*==================*]]><xsl:value-of select="description"/><![CDATA[
	 *==================*/
	function get]]><xsl:value-of select="@name"/><![CDATA[()
	{
		return $this->my]]><xsl:value-of select="@name"/><![CDATA[ ;
	}

	function set]]><xsl:value-of select="@name"/><![CDATA[($new]]><xsl:value-of select="@name"/><![CDATA[)
	{
		$this->my]]><xsl:value-of select="@name"/><![CDATA[ = $new]]><xsl:value-of select="@name"/><![CDATA[ ;
	}
]]></xsl:if></xsl:template>





	<xsl:template match="property" mode="Field">
		<xsl:param name="checkEnum" select="0"/>
		<xsl:variable name="ref_name" select="@name"/>
		<xsl:if test="$checkEnum=0 or count(../../filter/enum[@name=$ref_name])=0"><![CDATA[
	var $my]]><xsl:value-of select="@name"/><![CDATA[ ;]]></xsl:if></xsl:template>





	<xsl:template match="property" mode="FieldInitializer">
		<xsl:param name="checkEnum" select="0"/>
		<xsl:variable name="ref_name" select="@name"/>
		<xsl:if test="$checkEnum=0 or count(../../filter/enum[@name=$ref_name])=0"><![CDATA[
		$this->set]]><xsl:value-of select="@name"/><![CDATA[(]]><xsl:value-of select="@defaultValue"/><![CDATA[) ;]]></xsl:if></xsl:template>





	<xsl:template match="property" mode="InitModel"><![CDATA[
		$this->myModel[']]><xsl:value-of select="@column"/><![CDATA['] = $modelNameSpace.']]><xsl:value-of select="@column"/><![CDATA[';]]></xsl:template>



	<xsl:template match="model/property" mode="fillRow">
		<xsl:variable name="ref_name" select="@name"/>
		<xsl:variable name="col_name" select="@column"/>
		<![CDATA[
			$new_row->set]]><xsl:value-of select="@name"/><![CDATA[(($next_record[$this->myModel[']]><xsl:value-of select="$col_name"/><![CDATA[']])) ;]]></xsl:template>



	<xsl:template match="enum" mode="DeclareValues">
		<xsl:apply-templates select="item" mode="DeclareValues"><xsl:with-param name="prefix" select="concat(@name,'_')"/></xsl:apply-templates>
	</xsl:template>





	<xsl:template match="item" mode="DeclareValues">
		<xsl:param name="prefix"/><![CDATA[
	var $]]><xsl:value-of select="$prefix"/><xsl:value-of select="@name"/><![CDATA[ = ]]><xsl:value-of select="@value"/><![CDATA[ ;]]></xsl:template>





	<xsl:template match="enum" mode="FieldInitializer"><![CDATA[
		$this->set]]><xsl:value-of select="@name"/><![CDATA[(]]>Db<xsl:value-of select="../../@classname"/>Filter::<xsl:value-of select="@name"/>_<xsl:value-of select="@defaultValue"/><![CDATA[) ;]]></xsl:template>





	<xsl:template match="enum" mode="Accessor"><![CDATA[
	
	//=== ]]><xsl:value-of select="@name"/><![CDATA[ ===
	/*==================*]]><xsl:value-of select="description"/><![CDATA[
	 *==================*/
	function get]]><xsl:value-of select="@name"/><![CDATA[()
	{
		return $this->my]]><xsl:value-of select="@name"/><![CDATA[ ;
	}

	function set]]><xsl:value-of select="@name"/><![CDATA[($new]]><xsl:value-of select="@name"/><![CDATA[)
	{
		$this->my]]><xsl:value-of select="@name"/><![CDATA[ = $new]]><xsl:value-of select="@name"/><![CDATA[ ;
	}
]]></xsl:template>





	<xsl:template match="enum" mode="Field"><![CDATA[
	var $my]]><xsl:value-of select="@name"/><![CDATA[ ;]]></xsl:template>





	<xsl:template match="model" mode="buildColumnList">
		<xsl:param name="variable_name"/><xsl:for-each select="property"><![CDATA[
		$]]><xsl:value-of select="concat($variable_name, '[] = $this->myModel[&quot;', @column, '&quot;] ;')"/><![CDATA[]]></xsl:for-each></xsl:template>





	<xsl:template match="model" mode="buildValueList">
		<xsl:param name="variable_name"/>
		<xsl:param name="source_name"/><xsl:for-each select="property"><![CDATA[
		$]]><xsl:value-of select="concat($variable_name, '[] = encodeValue($', $source_name,'->get', @name, '(), &quot;', @type,'&quot;) ;')"/><![CDATA[]]></xsl:for-each></xsl:template>





	<xsl:template match="columns" mode="buildColumnList">
		<xsl:param name="variable_name"/><xsl:for-each select="column"><![CDATA[
			$]]><xsl:value-of select="concat($variable_name, '[] = $this->myModel[&quot;', @name, '&quot;] ;')"/><![CDATA[
]]></xsl:for-each></xsl:template>





	<xsl:template match="orderby" mode="buildOrderByList">
		<xsl:param name="variable_name"/><xsl:for-each select="column"><![CDATA[
			$]]><xsl:value-of select="concat($variable_name, '[] = $this->myModel[&quot;', @name, '&quot;].&quot; ', @order,'&quot; ;')"/><![CDATA[
]]></xsl:for-each></xsl:template>

	<xsl:template match="limit" mode="buildLimitParameter">
		<xsl:param name="filter_name"/>//FIXME compute limit, either from filter or by default ; if there is a limit, compute the offset from filter (or by default ?)</xsl:template>





	<xsl:template match="groupby" mode="buildGroupByList">
		<xsl:param name="variable_name"/><xsl:for-each select="column"><![CDATA[
			$]]><xsl:value-of select="concat($variable_name, '[] = $this->myModel[&quot;', @name, '&quot;].&quot; ', @order,'&quot; ;')"/><![CDATA[
]]></xsl:for-each></xsl:template>





	<xsl:template match="selectors" mode="buildSelectors">
		<xsl:param name="filter_name"/>
		<xsl:param name="sid_name"/><xsl:for-each select="selector"><![CDATA[
		/*==================*]]><xsl:apply-templates select="description"/><![CDATA[
		 *==================*/
		else if ]]><xsl:apply-templates select="conditionGroup" mode="buildIfConditions">
			<xsl:with-param name="filter_name" select="$filter_name"/>
			<xsl:with-param name="variable_name" select="'columnList'"/>
		</xsl:apply-templates><![CDATA[
		{
			$columnList = array() ;
			$columnList[] = $this->myModel[']]><xsl:value-of select="$sid_name"/><![CDATA['] ;]]><xsl:apply-templates select="columns" mode="buildColumnList">
			<xsl:with-param name="variable_name" select="'columnList'"/>
		</xsl:apply-templates><![CDATA[

			$whereList = array() ; ]]><xsl:apply-templates select="where" mode="buildWhereConditions">
			<xsl:with-param name="variable_name" select="'whereList'"/>
			<xsl:with-param name="filter_name" select="'$filter_name'"/>
		</xsl:apply-templates><![CDATA[

			$whereOperator = ']]><xsl:value-of select="where/@operator"/><![CDATA[';

			$orderList = array() ;]]><xsl:apply-templates select="orderby" mode="buildOrderByList">
			<xsl:with-param name="variable_name" select="'orderList'"/>
		</xsl:apply-templates><![CDATA[

			$groupList = array() ;]]><xsl:apply-templates select="groupby" mode="buildGroupByList">
			<xsl:with-param name="variable_name" select="'orderList'"/>
		</xsl:apply-templates><![CDATA[

			$limitCount = 0 ;
			$limitOffset = 0 ;]]><xsl:apply-templates select="limit" mode="buildLimitParameters">
			<xsl:with-param name="filter_name" select="'$filter_name'"/>
		</xsl:apply-templates><![CDATA[

			$sql = buildSqlSelect($this->myTable, $columnList, $whereList, $whereOperator, $orderList, $groupList, $limitCount, $limitOffset) ;
		}
]]></xsl:for-each></xsl:template>





	<xsl:template match="deletors" mode="buildDeletors">
		<xsl:param name="filter_name"/>
		<xsl:param name="sid_name"/><xsl:for-each select="deletor"><![CDATA[
		/*==================*]]><xsl:apply-templates select="description"/><![CDATA[
		 *==================*/
		else if ]]><xsl:apply-templates select="conditionGroup" mode="buildIfConditions">
			<xsl:with-param name="filter_name" select="$filter_name"/>
			<xsl:with-param name="variable_name" select="'columnList'"/>
		</xsl:apply-templates><![CDATA[
		{
			$whereList = array() ; ]]><xsl:apply-templates select="where" mode="buildWhereConditions">
			<xsl:with-param name="variable_name" select="'whereList'"/>
			<xsl:with-param name="filter_name" select="'$filter_name'"/>
		</xsl:apply-templates><![CDATA[

			$whereOperator = ']]><xsl:value-of select="where/@operator"/><![CDATA[';

			$sql = buildDeleteQuery($this->myTable, $whereList, $whereOperator) ;
		}
]]></xsl:for-each></xsl:template>





	<xsl:template match="conditionGroup" mode="buildIfConditions">
		<xsl:param name="variable_name"/>
		<xsl:variable name="operator"><xsl:choose>
			<xsl:when test="@operator = 'and'"><xsl:value-of select="' &amp;&amp; '"/></xsl:when>
			<xsl:when test="@operator = 'or'"><xsl:value-of select="' || '"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="' &amp;&amp; '"/></xsl:otherwise>
		</xsl:choose></xsl:variable><![CDATA[(]]><xsl:for-each select="conditionGroup|condition">
			<xsl:if test="position()>1"><xsl:value-of select="$operator"/></xsl:if>
			<xsl:apply-templates select="." mode="buildIfConditions">
				<xsl:with-param name="variable_name" select="$variable_name"/>
			</xsl:apply-templates>
		</xsl:for-each><![CDATA[)]]></xsl:template>





	<xsl:template match="condition" mode="buildIfConditions">
		<xsl:param name="variable_name"/>
		<xsl:variable name="operator"><xsl:choose>
			<xsl:when test="@operator = 'eq'"><xsl:value-of select="' == '"/></xsl:when>
			<xsl:when test="@operator = 'neq'"><xsl:value-of select="' != '"/></xsl:when>
			<xsl:when test="@operator = 'gt'"><xsl:value-of select="' > '"/></xsl:when>
			<xsl:when test="@operator = 'lt'"><xsl:value-of select="' &lt; '"/></xsl:when>
			<xsl:when test="@operator = 'ge'"><xsl:value-of select="' >= '"/></xsl:when>
			<xsl:when test="@operator = 'le'"><xsl:value-of select="' &lt;= '"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="' = '"/></xsl:otherwise>
		</xsl:choose></xsl:variable><![CDATA[(]]><xsl:choose>
			<xsl:when test="@enum = 'true'"><xsl:value-of select="concat('$', $variable_name,'->get',@name,'()',$operator,'Db',@name,'Filter::',@name,'_',@value)"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="concat('$', $variable_name,'->get',@name,'()',$operator,@value)"/></xsl:otherwise>
		</xsl:choose><![CDATA[)]]></xsl:template>





	<xsl:template match="where|whereConditionGroup" mode="buildWhereConditions">
		<xsl:param name="variable_name"/>
		<xsl:param name="filter_name"/>
		<xsl:variable name="operator"><xsl:choose>
			<xsl:when test="@operator = 'and'"><xsl:value-of select="' and '"/></xsl:when>
			<xsl:when test="@operator = 'or'"><xsl:value-of select="' or '"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="' and '"/></xsl:otherwise>
		</xsl:choose></xsl:variable><xsl:for-each select="whereConditionGroup|whereCondition">
			<xsl:choose>
				<xsl:when test="name()='whereConditionGroup'"><![CDATA[
			$]]><xsl:value-of select="concat($variable_name,'_',position(),' = array() ;')"/><![CDATA[
]]><xsl:apply-templates select="." mode="buildWhereConditions">
						<xsl:with-param name="variable_name" select="concat($variable_name,'_',position())"/>
						<xsl:with-param name="filter_name" select="$filter_name"/>
					</xsl:apply-templates><![CDATA[
			$]]><xsl:value-of select="concat($variable_name,'[] = buildConditionGroupClause ($',$variable_name,'_',position(),', &quot;', @operator,'&quot;) ;')"/><![CDATA[
]]></xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="." mode="buildWhereConditions">
						<xsl:with-param name="variable_name" select="$variable_name"/>
						<xsl:with-param name="filter_name" select="$filter_name"/>
					</xsl:apply-templates>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each></xsl:template>





	<xsl:template match="whereCondition" mode="buildWhereConditions">
		<xsl:param name="variable_name"/>
		<xsl:param name="filter_name"/>
		<xsl:variable name="column_name" select="@columnName"></xsl:variable>
		<xsl:variable name="model" select="/table/model"></xsl:variable>
		<xsl:variable name="model_sid" select="$model/@sidColumn"></xsl:variable>
		<xsl:variable name="type_column"><xsl:choose>
			<xsl:when test="@columnName=$model_sid"><xsl:value-of select="$model/@sidType"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="$model/property[@column=$column_name]/@type"/></xsl:otherwise>
		</xsl:choose></xsl:variable><![CDATA[
			$]]><xsl:value-of select="concat($variable_name,'[] = buildCondition($this->myModel[&quot;', @columnName, '&quot;], ',$filter_name,'.get',@filterName,', &quot;', @operator,'&quot;, &quot;', $type_column, '&quot;) ;')"/><![CDATA[
]]></xsl:template>
</xsl:stylesheet>
