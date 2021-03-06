
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
<link href="<%=basePath%>/media/default/css/jquery.achieve.css"
	rel="stylesheet" type="text/css" media="all" />


<script>
	var operationTypes = '<s:property value="resultJson" escape="false" />';
	var operationArray = (new Function("", "return " + operationTypes))();
	$("#summaryx").achieve(operationArray, {
		left : -1,
		top : 5,
		width : 150,
		formatItem : function(row) {
			return row.name;
		},
		formatMatch2 : function(row) {

			return row.name + row.help;
		},
		formatResult : function(itemData, input, i) {
			$('#summaryx').val(itemData[i].name);
			$('#summaryx_code' ).val(itemData[i].code);
		}
	});
</script>

<s:include value="/admin/template/scriptMessage.jsp"/>
<s:include value="/admin/template/changeCSS.jsp"/>
<div class="pageHeader">
  	<div id="divLeft" style="height:20px">
		<b><s:text name="operators_top-up_analysis" /></b>  
		<span class="color-red"></span>
		<span class="color-gr"><s:text name="performance_analysis" />:<s:text name="remote_time-consuming" />:<s:property value="remoteRunTime"/>ms <s:text name="the_local_total_time" />:<s:property value="localRunTime"/>ms <s:text name="the_length_of_the_data" />:<s:property value="contentLength"/></span> 
	</div>
	
	<s:form action="payAssay_ptId" namespace="/admin/pay" method="post" theme="simple" onsubmit="return navTabSearch(this)">
		<div class="searchBar">
		<div class="searchDiv_left">
			 <s:text name="statistical_time" />：<s:textfield id="beginDate" name="beginDate" maxlength="10" size="12" cssClass="required date"></s:textfield>
			<s:text name="to" /> <s:textfield id="endDate" name="endDate" maxlength="10" size="12" cssClass="required date"></s:textfield>
			<s:text name="regional" />：<s:select list="ossServersList" label="" listKey="id" listValue="name" cssStyle="width:150px" name="selectArray"
			 multiple="true" size="5" headerKey="-1" headerValue="%{getText('all')}"></s:select> 
			
			<s:text name="platform" />:
			<input type="text" class="summary" id="summaryx" name="ptName" value="${ptName}"
			
						index="1" maxlength="100" />
			<input type="hidden" class="summary" id="summaryx_code" name="ptCode" value="${ptCode}" />
			<%-- <s:select list="@com.jcwx.game.common.constants.PtServerConstant@ptTypeMap" name="ptId" listKey="key" listValue="value"></s:select> --%>
			</div>
			<div class="searchButton">
				<ul>
					<li><div class="buttonActive"><div class="buttonContent"><button type="submit"><s:text name="%{getText('the_query')}"/></button></div></div></li>
				</ul>
			</div>
		</div>
	</s:form>
	 <div class="searchDiv_left" style="width:100%"><s:text name="related_statistics" />： <s:text name="query_the_total_prepaid_phone_number" />:
	 <%-- <s:property value="countRmb"/>  --%>
	  <fmt:formatNumber value="${countRmb}" type="number" pattern="#,#00.0#" />
	 </div>
	
</div>	

	<div class="pageContent" layoutH="240">
	    <table class="list" width="100%" >
	    	<thead>
		    	<tr>
		    	    <th  colspan="12"> 
		    	    	<s:text name="top-up_analysis" />
		    	    </th>
		    	</tr>
		    	<tr>
		    	    <th><s:text name="the_date_of" /></th>
		    	    <th><s:text name="regional" /></th>
		    	    <th><s:text name="total_amount_of_top-up" /></th>
		    	    <th><s:text name="top-up_account_number" /></th>
		    	    <th><s:text name="prepaid_phone_number" /></th>
		    	    <th>Arppu</th>
		    	</tr>
	    	</thead>
	    	<tbody>
		    	<s:iterator value="zpayDayDtoList" var="oneRow" status="offset"> 
		    		<tr  >
			    	    <td>
							<fmt:formatDate value="${oneRow.id}" pattern="yyyy-MM-dd" />
			    	    </td>
			    	    <td>
							<s:property value="#oneRow.serverName"/>
			    	    </td>
			    	    <td>
							<fmt:formatNumber value="${oneRow.moneyTotal}" type="number" pattern="#,#00.0#" />
			    	    </td>
			    	    <td>
							<s:property value="#oneRow.payUserNum"/>
			    	    </td>
			    	    <td>
							<s:property value="#oneRow.payTimes"/>
			    	    </td>
			    	    <td>
							<fmt:formatNumber value="${oneRow.arpu}" type="number" pattern="#,#00.0#" />
			    	    </td>
			    	</tr>
		    	</s:iterator>
	    	</tbody>
	    </table>
	 </div>
