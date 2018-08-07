<!DOCTYPE html>
<html ng-app="">

<head>
<meta charset="UTF-8">
<title>欢迎页面-X-admin2.0</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<!-- <meta name="viewport"
	content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" /> -->
<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" href="../css/font.css">
<link rel="stylesheet" href="../css/xadmin.css">
<script type="text/javascript" src="../js/jquery-2.0.3.min.js"></script>
<script type="text/javascript" src="../lib/layui/layui.js"
	charset="utf-8"></script>
<script type="text/javascript" src="../js/xadmin.js"></script>
<!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
<!--[if lt IE 9]>
      <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
      <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<script src="../angular/angular.min.js"></script>
<script type="text/javascript">
var localhost = 'http://' + location.host + "/";
var path = '${tableModel}';
function saveCtrl($scope,$http) {
	  $scope.keyid=sessionStorage.getItem("keyid");
	  $scope.add = function() {
	        $http({
	            method: "POST",
	            url: localhost+path+"/save",
	            data: $scope.conf
	        }).then(function successCallback(response) {
	        	$scope.conf="";
	        	$scope.msg = response.data.msg;
	        }, function errorCallback(response) {
	        	$scope.msg="系统异常";
	        });
	    } 
	  $scope.selectOne = function() {
      $http({
          method: "POST",
          url: localhost+path+"/selectOne",
          data: $scope.keyid
      }).then(function successCallback(response) {
          $scope.conf = response.data.conf;
      }, function errorCallback(response) {
          // 请求失败执行代码
      	$scope.msg="系统异常";
      });
  } 
	 if( $scope.keyid!=null){
 		 $scope.selectOne();
	}
   sessionStorage.removeItem("keyid");	   
}
</script>
</head>

<body ng-app="" ng-controller="saveCtrl">
	<div class="x-body layui-anim layui-anim-up">
		<form class="layui-form">
		<#list model as obj>
		<#if obj.columnName!= "id">
 		<div class="layui-form-item">
				<label for="L_email" class="layui-form-label"> <span
					class="x-red">*</span>${obj.columnMemo}
				</label>
				<div class="layui-input-inline">
					<input type="text" id="L_email" name="email" required=""
						autocomplete="off" class="layui-input" ng-model="conf.${obj.columnName}">
				</div>	
		</div>

</#if>
			
		</#list>
			<div class="layui-form-item">
				<label for="L_repass" class="layui-form-label"> </label>
				<button class="layui-btn" lay-filter="add" ng-click="add()" lay-submit="">
					 保存</button>
			</div>
		</form>
	</div>
	<script>
        layui.use(['form','layer'], function(){
            $ = layui.jquery;
          var form = layui.form
          ,layer = layui.layer;
        
          //自定义验证规则
          form.verify({
            nikename: function(value){
              if(value.length < 5){
                return '昵称至少得5个字符啊';
              }
            }
            ,pass: [/(.+){6,12}$/, '密码必须6到12位']
            ,repass: function(value){
                if($('#L_pass').val()!=$('#L_repass').val()){
                    return '两次密码不一致';
                }
            }
          });

          //监听提交
          form.on('submit(add)', function(data){
            console.log(data);
            //发异步，把数据提交给php
            layer.alert("增加成功", {icon: 6},function () {
            	parent.location.reload();
                // 获得frame索引
                var index = parent.layer.getFrameIndex(window.name);
                //关闭当前frame
                parent.layer.close(index);
            });
            return false;
          });
          
          
        });
    </script>

</body>

</html>