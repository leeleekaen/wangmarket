<%@page import="com.xnx3.admin.entity.Site"%>
<%@page import="com.xnx3.net.OSSUtil"%>
<%@page import="com.xnx3.j2ee.Global"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib uri="http://www.xnx3.com/java_xnx3/xnx3_tld" prefix="x" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String imagePrefixUrl = OSSUtil.url+"site/"+request.getAttribute("siteid")+"/column_icon/";
%>
<jsp:include page="../iw/common/head.jsp">
	<jsp:param name="title" value="模版变量列表"/>
</jsp:include>

<table class="layui-table" id="xnx3_body" style="margin:0px;">
  <thead>
    <tr>
      <th>变量名称</th>
      <th>备注</th>
      <th>最后修改时间</th>
      <th>操作</th>
    </tr> 
  </thead>
  <tbody class="tile__listedit" id="columnList">
  	<!-- display 显示或者隐藏，是否在导航中显示。若为0，则不加入排序 -->
  	<c:forEach items="${list}" var="templateVar">
        <tr>
        	<!--display${column['used']}-->
            <td style="width:150px;">${templateVar['varName'] }</td>
            <td>${templateVar['remark'] }</td>
            <td style="width:100px;"><x:time linuxTime="${templateVar['updatetime'] }" format="yy-MM-dd hh:mm"></x:time></td>
            <td style="width:110px;">
            	<a href="templateVar.do?templateVarName=${templateVar['varName'] }" class="layui-btn layui-btn-small"><i class="layui-icon">&#xe642;</i></a>
            	<button onclick="deleteTemplateVar('${templateVar['id'] }', '${templateVar['varName'] }');" class="layui-btn layui-btn-small"><i class="layui-icon">&#xe640;</i></a>
			</td>
        </tr>
    </c:forEach>
  </tbody>
</table>

<div style="padding:15px;">
	<a class="layui-btn" href="templateVar.do" style="margin-left: 10px;margin-bottom: 20px;">添加模版变量</a>
</div>
<div style="padding-right:15px; text-align: right;margin-top: -66px;">
	提示：&nbsp;&nbsp;&nbsp;
	<botton class=""><i class="layui-icon">&#xe642;</i></botton><span style="padding-left:12px;padding-right: 30px;">编辑</span>
	<botton class=""><i class="layui-icon">&#xe640;</i></botton><span style="padding-left:12px;padding-right: 30px;">删除</span>
</div>

<script type="text/javascript">

/**
 * 编辑栏目
 * siteColumnId 要编辑的栏目的id
 */
function editColumn(siteColumnId){
	layer.open({
		type: 2, 
		title:'修改栏目', 
		area: ['460px', '375px'],
		shadeClose: true, //开启遮罩关闭
		content: '<%=basePath %>column/popupColumnGaoJiUpdate.do?id='+siteColumnId
	});
}

/**
 * 删除
 * id 要编辑的模版变量的id
 * name 要删除的项的名字
 */
function deleteTemplateVar(id, name){
	var dtv_confirm = layer.confirm('确定要删除“'+name+'”？删除后不可恢复！', {
	  btn: ['删除','取消'] //按钮
	}, function(){
		layer.close(dtv_confirm);
		$.showLoading('正在删除');
		$.getJSON('<%=basePath %>template/deleteTemplateVar.do?id='+id,function(obj){
			$.hideLoading();
			if(obj.result == '1'){
				$.toast("删除成功", function() {
					window.location.reload();	//刷新当前页
				});
	     	}else if(obj.result == '0'){
	     		 $.toast(obj.info, "cancel", function(toast) {});
	     	}else{
	     		alert(obj.result);
	     	}
		});
	}, function(){
	});
	
}
</script>
</body>
</html>