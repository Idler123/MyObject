<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="../basePath.jsp" %> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>接口测试</title>
<script type="text/javascript" src="resource/jquery-1.7.2.min.js"></script>
<style>
*{font-family: '微软雅黑','Helvetica Neue',sans-serif,SimHei}
body{background-color: #F7F6F2;overflow: hidden;}
.container_form{
	width: 50%;
	height:100%;
	float: left;
	padding: 10 0 0 10;
}
.container_form table{width: 100%}
.container_resp{width: 45%;float: left;margin-left: 3%;padding: 10 0 0 0;}
.second-title{
	padding-bottom:10px;
	border-bottom: 1px solid rgba(0,0,0,.1);
	font-weight:400;
	font-size: 18px;
}
.item{
	font-size: 14px;
	}
.btn{margin: 10 0 10 0;padding: 0 5 0 5;cursor: pointer;}
.filebtn{margin: 0 0 0 0;padding: 0 5 0 5;cursor: pointer;}
input{
	border: 1px solid #ddd;
	padding: .65em 1em;
	background: #FFF;
	color: rgba(0,0,0,.7);
	border-radius:.3125em;
	height: 30px;
}
select{
	border: 1px solid #ddd;
	background: #FFF;
	color: rgba(0,0,0,.7);
	border-radius:.3125em;
	height: 30px;
}

.del_btn{float: right;margin-right: 20%;}
iframe{
	border: 1px solid #ddd;
	padding: .65em 1em;
	background: #FFF;
	color: rgba(0,0,0,.7);
	border-radius:.3125em;
	width: 97%;
	height: 90%;
}
</style>
<script type="text/javascript">
//初始化服务器地址
var server = $("base")[0].href;
//初始化资源地址
var resource = "";

//文件参数序号
var fileNum = 1;
	$(function() {
		//获取初始化服务器地址和资源地址
		$("#server").val(server);
		$("#resource").val(resource);
		//resp json format
		document.getElementById("mainframe").onload=function(){
			var str = $("#mainframe").contents().text();
			var obj = eval('(' + str + ')');
			var newStr = JSON.stringify(obj, null, "\t");  
			//JSON.stringify(jsObj, null, "\t"); // 缩进一个tab
			//JSON.stringify(jsObj, null, 4);    // 缩进4个空格
			$(window.frames["mainframe"].document).find("pre").html(newStr);
		};

	});

	//form 提交
	var doSubmit = function(){
		//method
		var method = $("#method option:selected").val();
		//请求地址
		var url = $("#server").val() + "/" + $("#resource").val(); 
		//构建form
		if (!createForm()) {
			return;
		}
		//修改form属性
		$("#testform").attr("action",url);
		$("#testform").attr("method",method);
		$("#testform").submit();
	}

	// 创建表单
	var createForm = function(){
		cleanForm();
		var flag = true;
		// 遍历显示的参数table
		$(".params_table tr").each(function(){
			if ($(this).hasClass("tr_param")) { // 文字参数
				var param_name = $(this).find(".param_name").val();
				var param_value = $(this).find(".param_value").val();
				// 拼接input放到form
				var _input = '<input type="hidden" name="'+param_name+'" value="'+param_value+'"/>'
				$("#testform").append(_input);
			}else if($(this).hasClass("tr_file")){ // 文件参数
				var name = $(this).find(".param_name").val().trim();
				if (name == "") {
					alert("文件参数名不能为空");
					flag = false;
					return false;
				}
				// 给表单里对应file input添加name属性
				var num = $(this).find(".filename").attr("id").substring(9);
				$("#file_"+num).attr("name",name);
			}
		});
		return flag;
	}

	// clean form
	var cleanForm = function(){
		$("#testform").find("[type=hidden]").remove();
	}

	// 添加一行
	var addLine = function(){
		var _new = $(".clone_tr_param").clone().removeClass("clone_tr_param").addClass("tr_param");
		_new.find(".param_name").css({"position":"relative","left":-100,"top":-100})
		_new.find(".param_value").css({"position":"relative","left":-100,"top":-100})
		_new.find(".del_btn").css({"position":"relative","left":-100,"top":-100})
		$(".params_table").append(_new);
		_new.find(".param_name").animate({"left":0,"top":0},800)
		_new.find(".param_value").animate({"left":0,"top":0},800)
		_new.find(".del_btn").animate({"left":0,"top":0},800)
	}
	
	// 添加一行文件
	var addLineFile = function(){
		$(".params_table").append($(".clone_tr_file").clone().removeClass("clone_tr_file").addClass("tr_file"));
		fileNum += 1;
		// 给table添加一个按钮和一个input框
		$(".params_table").find(".filebtn:last").attr("id","filebtn_"+fileNum);
		$(".params_table").find(".filename:last").attr("id","filename_"+fileNum);
		// 给隐藏的form添加file类型的input
		var _inputfile = '<input type="file" id="file_'+fileNum+'" onchange="javascript:filechange(this)"/>';
		$("#testform").append(_inputfile);
	}

	// 删除一行
	var deleteLine = function(_this){
		$(_this).parent().parent().remove();
	}

	// 删除一行文件参数
	var deleteLine4File = function(_this){
		var num = $(_this).parent().find(".filename").attr("id").substring(9);
		// 删除form里的隐藏文件input
		$("#file_"+num).remove();
		$(_this).parent().parent().remove();
	}
	
	// 选择文件
	var choseFile = function(_this){
		var num = $(_this).attr("id").substring(8);
		$("#file_"+num).click();
	}

	// 文件改变
	var filechange = function(_this){
		var num = $(_this).attr("id").substring(5);
		$("#filename_"+num).val($(_this).val());
	}

</script>
</head>
<body>
	<div class="container_form">
		<div>
			<div class="second-title">接口URL:</div>
			<table>
				<tr>
					<td width="16%" class="item">方法类型</td>
					<td width="70%" class="item">服务器地址</td>
					
				</tr>
				<tr>
					<td width="16%">
						<select id="method">
							<option value="POST">POST</option>
							<option value="GET">GET</option>
						</select>
					</td>
					<td width="70%"><input id="server" style="width: 70%"/></td>
				</tr>
				<tr>
					<td colspan="2" class="item">资源路径</td>
				</tr>
				<tr>
					<td colspan="2"><input id="resource" style="width: 76%"/></td>
				</tr>
			</table>
			<input type="button" class="btn" value="提交测试" onclick="doSubmit()" style="margin-left: 80%;height: 50px"/>
		</div>
		<div style="margin-top: 40px">
			<div class="second-title">接口参数:</div>
			<input type="button" class="btn" value="加一行" onclick="addLine()">
			<input type="button" class="btn" value="加一行(文件)" onclick="addLineFile()">
				<table class="params_table">
					<tr>
						<td class="item">参数名</td>
						<td class="item">参数值</td>
					</tr>
					<tr class="tr_param">
						<td><input type="text" class="param_name"></td>
						<td><input type="text" class="param_value"><input type="button" class="del_btn" value="-" onclick="javascript:deleteLine(this);"/></td>
					</tr>
				</table>
				<form action="" target="mainframe" id="testform" name="testform" method="post" enctype="multipart/form-data" style="display: none;">
				</form>
			<!-- 添加一行代码模板 -->
			<div style="display: none;">
				<table>
					<!-- 普通参数模板 -->
					<tr class="clone_tr_param">
						<td><input type="text" class="param_name"></td>
						<td><input type="text" class="param_value"><input type="button" class="del_btn" value="-" onclick="javascript:deleteLine(this)"/></td>
					</tr>
					<!-- 文件参数模板 -->
					<tr class="clone_tr_file">
						<td><input type="text" class="param_name"></td>
						<td><input type="button" value="上传文件" class="filebtn" onclick="javascript:choseFile(this)"/><input type="text" class="filename"><input type="button" class="del_btn" value="-" onclick="javascript:deleteLine4File(this)"/></td>
					</tr>
				</table>
			</div>
		</div>
		
		
		
	</div>
	
	<div class="container_resp">
		<div style="font-size: 18px;">返回信息:</div>
		<iframe id="mainframe" name="mainframe" frameborder="0" height="100%" width="100%" allowtransparency="true" align="center" scrolling="auto">
		</iframe>
	</div>
	
</body>
</html>

