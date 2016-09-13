﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE HTML>
<html>
<jsp:include page="../../common/head.jsp"></jsp:include>
<title>角色列表</title>
</head>
<body>
	<nav class="breadcrumb">
		<i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span>
		系统管理 <span class="c-gray en">&gt;</span> 角色列表 <a
			class="btn btn-success radius r mr-20"
			style="line-height: 1.6em; margin-top: 3px"
			href="javascript:location.replace(location.href);" title="刷新"><i
			class="Hui-iconfont">&#xe68f;</i></a>
	</nav>
	<div class="pd-10">
		<div class="cl pd-5 bk-gray mt-10">
		<form action="${path}/role/list.json" method="get" id="listForm">
		<input type="hidden" name="page" value="1" />
			<shiro:hasPermission name="sys:role:add">
			<span class="l"><a href="javascript:;"
				onclick="layer_show('添加角色','${path }/role/add','','510')"
				class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i>
					添加角色</a></span>
			</shiro:hasPermission>
					<span class="r">
			<input type="text" class="input-text" style="width: 250px"
					placeholder="输入角色名" id="" name="name">
				<button type="button" class="btn btn-success radius" id="search" name="">
					<i class="Hui-iconfont">&#xe665;</i> 搜索
				</button>
			</span>
					</form>
		</div>
		<div class="mt-10">
			<table
				class="table table-border table-bordered table-hover table-bg table-sort">
				<thead>
					<tr class="text-c">
						<th width="25"><input type="checkbox" name="" value=""></th>
						<th>角色名</th>
						<th>编码</th>
						<th>描述</th>
						<th>排序</th>
						<th>是否启用</th>
						<shiro:hasPermission name="sys:role:update">
						<th>操作</th>
						</shiro:hasPermission>
					</tr>
				</thead>
				<tbody id="view">
				</tbody>
			</table>
		</div>
		<div class="mt-10" id="page"></div>
	</div>
				<script id="demo" type="text/html">
					{{# for(var i = 0, len = d.list.length; i < len; i++){ }}
						{{# var l = d.list[i]}}
						<tr class="text-c">
							<td><input type="checkbox" value="{{ l.id}}" name=""></td>
							<td>{{l.name}}</td>
							<td>{{ l.roleCode}}</td>
							<td>{{l.description }}</td>
							<td>{{ l.sort }}</td>
							<td class="td-status"><span
								class="label {{ l.disabled==0 ?'label-success':''}} radius">{{ l.disabled==0 ?'启用':'禁用' }}</span></td>
							<shiro:hasPermission name="sys:role:update">
							<td class="td-manage">
								<a style="text-decoration: none"
								class="statusOperate" href="javascript:;" itemId="{{l.id}}" status="{{l.disabled}}"
								title="{{ l.disabled==0 ?'禁用':'启用'}}"><i class="Hui-iconfont {{ l.disabled==0 ?'Hui-iconfont-shenhe-tingyong':'Hui-iconfont-shenhe-tongguo'}}"> </i></a>
								<a title="编辑" href="javascript:;"
								onclick="layer_show('修改角色','${path }/role/add?id={{ l.id}}','800','500')"
								class="ml-5" style="text-decoration: none">
									<i class="Hui-iconfont">&#xe6df;</i></a>
								<a title="设置权限" href="javascript:void(0);" itemId="{{l.id}}" onclick="layer_show('设置权限','${path}/role/editPerm?id={{l.id}}',300,400)" ><i class="Hui-iconfont Hui-iconfont-manage2"></i></a>
							</td>
							</shiro:hasPermission>
						</tr>
					{{# } }}
					</script>
	<jsp:include page="../../common/foot.jsp"></jsp:include>
	<script type="text/javascript">
	$(function(){
		initPage("listForm","demo", "view", "page");
	})
	$("#search").click(function(){
		$("[name='page']").val(1);
		initPage("listForm","demo", "view", "page");
	})
	/*管理员-停用*/
	$(document).on("click",".statusOperate",function(){
		var status = $(this).attr("status");
		var id = $(this).attr("itemId");
		var statusText = status==0?'停用':'启用';
		var confirmText = '确认要'+statusText+'吗？';
		var $this = $(this);
		layer.confirm(confirmText,function(index){
			$.getJSON("${path}/role/save",{id:id,disabled:(status==0?1:0)},function(data){
				if(data.status==0){
					layer.msg(data.msg,{icon: 6,time:1000});
				}else{
					layer.msg(data.msg,{icon: 5,time:1000});
				}
				initPage("listForm","demo", "view", "page");
			})
		});
	})
	</script>
</body>
</html>