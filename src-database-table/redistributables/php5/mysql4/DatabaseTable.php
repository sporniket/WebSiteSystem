<?php
/*
(c)2004,2005 David Sporn

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
 */

/**Class with utilities function to build SQL queries.
 *Date should be given according to the following format :
 *YYYYMMDDhhmmss
 *YYYY:Year
 *MM:month
 *DD:day
 *hh:hour
 *mm:minute
 *ss:second
 */
class DatabaseTable
{
	//constants
	var $PATTERN_DATETIME = '/^(\d{4})(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})$/' ;
	
	var $OPERATOR_EQUAL = 'eq' ;
	var $OPERATOR_NOT_EQUAL = 'neq' ;
	var $OPERATOR_GREATER_OR_EQUAL = 'ge' ;
	var $OPERATOR_NOT_GREATER_OR_EQUAL = 'nge' ;
	var $OPERATOR_LESSER_OR_EQUAL = 'le' ;
	var $OPERATOR_NOT_LESSER_OR_EQUAL = 'nle' ;
	var $OPERATOR_GREATER = 'gt' ;
	var $OPERATOR_NOT_GREATER = 'ngt' ;
	var $OPERATOR_LESSER = 'lt' ;
	var $OPERATOR_NOT_LESSER = 'nlt' ;
	var $OPERATOR_IN = 'in' ;
	var $OPERATOR_NOT_IN = 'nin' ;
	var $OPERATOR_LIKE = 'like' ;
	var $OPERATOR_NOT_LIKE = 'nlike' ;
	
	var $TYPE_INTEGER = 'integer' ;
	var $TYPE_UNSIGNED_INTEGER = 'unsignedInteger' ;
	var $TYPE_CHAR = 'char' ;
	var $TYPE_STRING = 'string' ;
	var $TYPE_TEXT = 'text' ;
	var $TYPE_DATETIME = 'datetime' ;
	var $TYPE_DATE = 'date' ;
	
	//stores the table name
	var $myTable ;
	
	//map of the column names
	var $myModel ;
	
	/**Build a INSERT query.
	 *No sanity checks is performed .
	 *static.
	 *@param tableName name of the table.
	 *@param columnList array of column names or expressions.
	 *@param valueList array of values in the same order than columnList (ready to use).
	 *@return a sql query as a string
	 */
	function buildInsertQuery($tableName, $columnList, $valueList)
	{
		$sql = 'INSERT INTO '.$tableName.' ' ;
		$sql .= DatabaseTable::buildInsertValuesClause($columnList, $valueList) ;
		return $sql ;
	}
	
	/**Add columns list and VALUES clause.
	 *No sanity checks is performed .
	 *static.
	 *@param columnList array of column names or expressions.
	 *@param valueList array of values in the same order than columnList (ready to use).
	 *@return a sql query as a string
	 */
	function buildInsertValuesClause($columnList, $valueList)
	{
		$sqlCol = '' ;
		$sqlVal = '' ;
		foreach ($columnList as $key=>$value)
		{
			if ($key > 0)
			{
				$sqlCol .= ',' ;
				$sqlVal .= ',' ;
			}
			$sqlCol .= $value ;
			$sqlVal .= $valueList[$key] ;
		}
		$sql = '('.$sqlCol.') VALUES('.$sqlVal.')' ;
	}
	
	/**Build a UPDATE query.
	 *No sanity checks is performed .
	 *static.
	 *@param tableName name of the table.
	 *@param columnList array of column names or expressions.
	 *@param valueList array of values in the same order than columnList (ready to use).
	 *@param whereList array of conditions.
	 *@param whereOperator the logical operator to relate all the where conditions ('AND', 'OR').
	 *@return a sql query as a string
	 */
	function buildUpdateQuery($tableName, $columnList, $valueList, $whereList, $whereOperator)
	{
		$sql = 'UPDATE '.$tableName.' SET ' ;
		$sql .= DatabaseTable::buildUpdateSetClause($columnList, $valueList) ;
		$sql .= DatabaseTable::buildConditionGroupClause($whereList, $whereOperator) ;
		return $sql ;
	}
	
	/**Build a SET clause.
	 *No sanity checks is performed .
	 *static.
	 *@param columnList array of column names or expressions.
	 *@param valueList array of values in the same order than columnList (ready to use).
	 *@return a sql query as a string
	 */
	function buildUpdateSetClause($columnList, $valueList)
	{
		$sql = '' ;
		foreach ($columnList as $key=>$value)
		{
			if ($key > 0)
			{
				$sql .= ',' ;
			}
			$sql .= $value.' = '.$valueList[$key] ;
		}
		$sql = ' SET '.$sql.' ' ;
	}
	
	/**Build a DELETE query.
	 *No sanity checks is performed .
	 *static.
	 *@param tableName name of the table.
	 *@param whereList array of conditions.
	 *@param whereOperator the logical operator to relate all the where conditions ('AND', 'OR').
	 *@return a sql query as a string
	 */
	function buildDeleteQuery($tableName, $whereList, $whereOperator)
	{
		$sql = 'DELETE FROM '.$tableName.' WHERE ' ;
		$sql .= DatabaseTable::buildConditionGroupClause($whereList, $whereOperator) ;
		return $sql ;
	}
	
	/**Build a SELECT query.
	 *No sanity checks is performed .
	 *static.
	 *@param tableName name of the table.
	 *@param columnList array of column names or expressions.
	 *@param whereList array of conditions.
	 *@param whereOperator the logical operator to relate all the where conditions ('AND', 'OR').
	 *@param orderList array of column order names (column_name [asc|desc]).
	 *@param groupList array of column group names (function(column_name) [asc|desc]).
	 *@return a sql query as a string
	 */
	function buildSqlSelect ($tableName, $columnList, $whereList, $whereOperator, $orderList, $groupList)
	{
		$sql = 'SELECT ';
		foreach ($columnList as $key=>$value)
		{
			if (0 != (integer)$key) 
			{
				$sql .= ',' ;
			}
			$sql .= $value ;
		}
		$sql .= ' FROM '.$tableName ;
		$sql .= (0 < count($orderList))?' WHERE ':'' ;
		$sql .= DatabaseTable::buildConditionGroupClause($whereList, $whereOperator) ;
		$sql .= DatabaseTable::buildOrderByClause($orderList) ;
		$sql .= DatabaseTable::buildGroupByClause($groupList) ;
		return $sql ;
	}
	
	/**Build an column list query part.
	 *The query starts with a space.
	 *No sanity checks is performed .
	 *static.
	 *@param columnList array of column names or expressions.
	 *@return a sql query part as a string
	 */
	function buildColumnListClause ($columnList)
	{
		if (count($columnList))
		{
			$sql = ' ';
			foreach ($columnList as $key=>$value)
			{
				if (0 != (integer)$key) 
				{
					$sql .= ',' ;
				}
				$sql .= $value ;
			}
			return $sql ;
		}
		return '' ;
	}
	
	/**Build an ORDER BY query part.
	 *The query starts with a space.
	 *No sanity checks is performed .
	 *static.
	 *@param orderList array of column order names (column_name [asc|desc]).
	 *@return a sql query part as a string
	 */
	function buildOrderByClause ($orderList)
	{
		if (count($orderList))
		{
			$sql = ' ORDER BY ';
			foreach ($orderList as $key=>$value)
			{
				if (0 != (integer)$key) 
				{
					$sql .= ',' ;
				}
				$sql .= $value ;
			}
			return $sql ;
		}
		return '' ;
	}
	
	/**Build an GROUP BY query part.
	 *The query starts with a space.
	 *No sanity checks is performed .
	 *static.
	 *@param groupList array of column group names (function(column_name) [asc|desc]).
	 *@return a sql query part as a string
	 */
	function buildGroupByClause ($groupList)
	{
		if (count($orderList))
		{
			$sql = ' GROUP BY ';
			foreach ($groupList as $key=>$value)
			{
				if (0 != (integer)$key) 
				{
					$sql .= ',' ;
				}
				$sql .= $value ;
			}
			return $sql ;
		}
		return '' ;
	}
	
	/**Build a group of condition for WHERE clause.
	 *This purpose is building a group of conditions.
	 *The query starts with a space.
	 *No sanity checks is performed .
	 *static.
	 *@param whereList array of conditions.
	 *@param whereOperator the logical operator to relate all the where conditions ('AND', 'OR').
	 *@return a sql query part as a string
	 */
	function buildConditionGroupClause ($whereList, $whereOperator)
	{
		if (count($orderList))
		{
			$sql = ' (';
			foreach ($whereList as $key=>$value)
			{
				if (0 != (integer)$key) 
				{
					$sql .= ' '.$whereOperator.' ' ;
				}
				$sql .= $value ;
			}
			$sql .= ')' ;
			return $sql ;
		}
		return '' ;
	}
	
	/**Converts a list of logical column names into real column names.
	 *No sanity checks is performed .
	 *static.
	 *@param colDictionnary dictionnaries of real column names.
	 *@param colListe the logical column name list.
	 *@return a list of columns real names
	 */
	function buildRealColumnList($colDictionnary, $colListe)
	{
		$return_list = array();
		foreach ($colListe as $key=>$value)
		{
			$return_list[] = $colDictionnary[$value] ;
		}
		return $return_list ;
	}
	
	/**Build a condition.
	 *This condition will be used by buildConditionGroup
	 *No sanity checks is performed .
	 *static.
	 *@param colName name of the column.
	 *@param colValue value of the column.
	 *@param operator conditional operator (eq, neq, gt, ngt, ...,in, like).
	 *@param colType type of the value (string,number,datetime).
	 *@return a sql query part as a string (empty if operator and type are incorrects)
	 */
	//TODO: deals date type values
	function buildCondition($colName,$colValue,$operator='eq',$colType='string')
	{
		$encodedValue = encodeValue($colValue, $colType) ;
		return DatabaseTable::buildExpression($colName, $encodedValue, $operator) ;
	}

	/**Encode a value.
	 *No sanity checks is performed .
	 *static.
	 *@param value value of the column.
	 *@param type type of the value (string,number,datetime).
	 *@return a sql query part as a string (empty if operator and type are incorrects)
	 */	
	//TODO: use proper sanitization function for text values
	function encodeValue($value, $type)
	{
		$encodedValue = '' ;
		if ($type == DatabaseTable::TYPE_INTEGER)
		{
			$encodedValue = (integer)$value ;
		}
		else if ($type == DatabaseTable::TYPE_UNSIGNED_INTEGER)
		{
			$encodedValue = (integer)$value ;
		}
		else if ($type == DatabaseTable::TYPE_STRING)
		{
			$encodedValue = '\''.addslashes($value).'\'' ;
		}
		else if ($type == DatabaseTable::TYPE_CHAR)
		{
			$encodedValue = '\''.addslashes($value).'\'' ;
		}
		else if ($type == DatabaseTable::TYPE_TEXT)
		{
			$encodedValue = '\''.addslashes($value).'\'' ;
		}
		else if ($type == DatabaseTable::TYPE_DATETIME)
		{
			if (preg_match($this->DbTable->PATTERN_DATETIME, $value, $matches))
			{
				$encodedValue = '\''.$matches[1].'-'.$matches[2].'-'.$matches[3].' '.$matches[4].':'.$matches[5].':'.$matches[6].'\'' ;
			}
			else
			{
				$encodedValue = '\''.addslashes($value).'\'' ;
			}
		}
		return $encodedValue ;
	}
	
	/**Build an expression A op B.
	 *The resulting expression is not put inside parenthesis.
	 *For the operator DatabaseTable::OPERATOR_IN, the second member is put inside parenthesis.
	 *No sanity checks is performed .
	 *static.
	 *@param left first member.
	 *@param right second member.
	 *@param operator conditional operator (eq, neq, gt, ngt, ...,in, like).
	 *@return a string (empty if operator is incorrect)
	 */
	function buildExpression($left,$right,$operator='eq')
	{
		if ($operator == DatabaseTable::OPERATOR_EQUAL)
		{
			return ' '.$left.' = '.$right.' ' ;
		}
		else if ($operator == DatabaseTable::OPERATOR_GREATER_OR_EQUAL)
		{
			return ' '.$left.' >= '.$right.' ' ;
		}
		else if ($operator == DatabaseTable::OPERATOR_LESSER_OR_EQUAL)
		{
			return ' '.$left.' <= '.$right.' ' ;
		}
		else if ($operator == DatabaseTable::OPERATOR_GREATER)
		{
			return ' '.$left.' > '.$right.' ' ;
		}
		else if ($operator == DatabaseTable::OPERATOR_LESSER)
		{
			return ' '.$left.' < '.$right.' ' ;
		}
		else if ($operator == DatabaseTable::OPERATOR_IN)
		{
			return ' '.$left.' in ('.$right.') ' ;
		}
		else if ($operator == DatabaseTable::OPERATOR_LIKE)
		{
			return ' '.$left.' like '.$right.' ' ;
		}
		//NOT
		else if ($operator == DatabaseTable::OPERATOR_NOT_EQUAL)
		{
			return ' not '.$left.' = '.$right.' ' ;
		}
		else if ($operator == DatabaseTable::OPERATOR_NOT_GREATER_OR_EQUAL)
		{
			return ' not '.$left.' >= '.$right.' ' ;
		}
		else if ($operator == DatabaseTable::OPERATOR_NOT_LESSER_OR_EQUAL)
		{
			return ' not '.$left.' <= '.$right.' ' ;
		}
		else if ($operator == DatabaseTable::OPERATOR_NOT_GREATER)
		{
			return ' not '.$left.' > '.$right.' ' ;
		}
		else if ($operator == DatabaseTable::OPERATOR_NOT_LESSER)
		{
			return ' not '.$left.' < '.$right.' ' ;
		}
		else if ($operator == DatabaseTable::OPERATOR_NOT_IN)
		{
			return ' not '.$left.' in ('.$right.') ' ;
		}
		else if ($operator == DatabaseTable::OPERATOR_NOT_LIKE)
		{
			return ' not '.$left.' like '.$right.' ' ;
		}
		else
		{
			return ' not ' ;
		}
	}
	
	
	/**Build a LIMIT clause.
	 *@param count limit value.
	 *@param offset offset value.
	 *@return a <code>LIMIT $count [OFFSET $offset]</code> expression if appliable.
	 */
	function buildExpression($count=0,$offset=0)
	{
		//force integer values
		$intcount = (integer)$count ;
		$intoffset = (integer)$offset ;

		$sql = '' ;
		if ($intcount > 0)
		{
			$sqlLimit = ' LIMIT '.$intcount.' ' ;
			$sqlOffset = ($intoffset > 0)?'OFFSET '.$intoffset.' ':'' ;
			$sql=$sqlLimit.$sqlOffset ;
		}
		
		return $sql ;
	}
}
?>
