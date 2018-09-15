<?php if (!defined('THINK_PATH')) exit();?><!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title><?php echo ($meta_title); ?></title>
    <link href="/Public/favicon.ico" type="image/x-icon" rel="shortcut icon">
    <link rel="stylesheet" type="text/css" href="/Public/Admin/css/base.css" media="all">
    <link rel="stylesheet" type="text/css" href="/Public/Admin/css/common.css" media="all">
    <link rel="stylesheet" type="text/css" href="/Public/Admin/css/module.css">
    <link rel="stylesheet" type="text/css" href="/Public/Admin/css/style.css" media="all">
    <link rel="stylesheet" type="text/css" href="/Public/Admin/layui/css/layui.css" media="all">
	<link rel="stylesheet" type="text/css" href="/Public/Admin/css/<?php echo (C("COLOR_STYLE")); ?>.css" media="all">
     <!--[if lt IE 9]>
    <script type="text/javascript" src="/Public/static/jquery-1.10.2.min.js"></script>
    <![endif]--><!--[if gte IE 9]><!-->
    <script type="text/javascript" src="/Public/static/jquery-2.0.3.min.js"></script>
    <script type="text/javascript" src="/Public/Admin/layui/layui.js"></script>
    <script type="text/javascript" src="/Public/Admin/js/jquery.mousewheel.js"></script>
    <!--<![endif]-->
    
</head>
<body>
    <!-- 头部 -->
    <div class="header">
        <!-- Logo -->
        <span class="logo" style="color: #fff;font-size: 20px;font-weight: bolder;cursor: pointer;" onclick="javascript:;window.location.href='/index.php?s=/Admin/User/index'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;无人超市</span>
        <!-- /Logo -->

        <!-- 主导航 -->
        <ul class="main-nav">
            <?php if(is_array($__MENU__["main"])): $i = 0; $__LIST__ = $__MENU__["main"];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$menu): $mod = ($i % 2 );++$i;?><li class="<?php echo ((isset($menu["class"]) && ($menu["class"] !== ""))?($menu["class"]):''); ?>"><a href="<?php echo (u($menu["url"])); ?>"><?php echo ($menu["title"]); ?></a></li><?php endforeach; endif; else: echo "" ;endif; ?>
        </ul>
        <!-- /主导航 -->

        <!-- 用户栏 -->
        <div class="user-bar">
            <a href="javascript:;" class="user-entrance"><i class="icon-user"></i></a>
            <ul class="nav-list user-menu hidden">
                <li class="manager">你好，<em title="<?php echo session('user_auth.username');?>"><?php echo session('user_auth.username');?></em></li>
                <li><a href="<?php echo U('User/updatePassword');?>">修改密码</a></li>
                <li><a href="<?php echo U('User/updateNickname');?>">修改昵称</a></li>
                <li><a href="<?php echo U('Public/logout');?>">退出</a></li>
            </ul>
        </div>
    </div>
    <!-- /头部 -->
    <!-- 边栏 -->
    <div class="sidebar" style="padding-top: 24px;">
        <!-- 子导航 -->
        
            <div id="subnav" class="subnav">
                <?php if(!empty($_extra_menu)): ?>
                    <?php echo extra_menu($_extra_menu,$__MENU__); endif; ?>

                <?php if(is_array($__MENU__["child"])): $i = 0; $__LIST__ = $__MENU__["child"];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$sub_menu): $mod = ($i % 2 );++$i;?><!-- 子导航 -->
                    <?php if(!empty($sub_menu)): if(!empty($key)): ?><h3><i class="icon icon-unfold"></i><?php echo ($key); ?></h3><?php endif; ?>
                        <ul class="side-sub-menu">
                            <?php if(is_array($sub_menu)): $i = 0; $__LIST__ = $sub_menu;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$menu): $mod = ($i % 2 );++$i;?><li>
                                    <a class="item" href="<?php echo (u($menu["url"])); ?>"><?php echo ($menu["title"]); ?></a>
                                </li><?php endforeach; endif; else: echo "" ;endif; ?>
                        </ul><?php endif; ?>
                    <!-- /子导航 --><?php endforeach; endif; else: echo "" ;endif; ?>
            </div>
        
        <!-- /子导航 -->
    </div>
    <!-- /边栏 -->

    <!-- 内容区 -->
    <div id="main-content" style="margin-left: 200px;margin-top:50px;">
        <div id="top-alert" class="fixed alert alert-error" style="display: none;">
            <button class="close fixed" style="margin-top: 4px;">&times;</button>
            <div class="alert-content">这是内容</div>
        </div>
        <div id="main" class="main">
            
            <!-- nav -->
            <?php if(!empty($_show_nav)): ?><div class="breadcrumb">
                <span>您的位置:</span>
                <?php $i = '1'; ?>
                <?php if(is_array($_nav)): foreach($_nav as $k=>$v): if($i == count($_nav)): ?><span><?php echo ($v); ?></span>
                    <?php else: ?>
                    <span><a href="<?php echo ($k); ?>"><?php echo ($v); ?></a>&gt;</span><?php endif; ?>
                    <?php $i = $i+1; endforeach; endif; ?>
            </div><?php endif; ?>
            <!-- nav -->
            

            
	<!-- 标题栏 -->
	<div class="main-title">
		<h2>订单管理</h2>
	</div>
	<div class="cf">
		<!-- <div class="fl" >
    
        </div> -->

        <!-- 高级搜索 -->
		<div class="search-form fl cf">
			<div class="sleft" >
				　姓名：<input type="text" style="float: none;width: 110px;" name="name" class="search-input" value="<?php echo I('name');?>" placeholder="请输入用户姓名">
				
			</div>
			<div class="sleft">
				　设备id：<input type="text" name="device_id" style="float: none;width: 100px;" id="getdevice" class="search-input" value="<?php echo I('device_id');?>" placeholder="请输入设备ID号">
				
			</div>
			<?php if(($is_show) == "1"): ?><div class="sleft">
					加盟商名称：<input type="text" name="business_name" style="float: none;width: 120px;" id="getbusiness" class="search-input" value="<?php echo I('business_name');?>" placeholder="请输入加盟商名称">
				</div>
				<div class="sleft">
					　店铺名：<input type="text" name="shop_name"  id="getshop" style="float: none;width: 110px;" class="search-input" value="<?php echo I('shop_name');?>" placeholder="请输入店铺名称">
					<!-- <a class="sch-btn" href="javascript:;" style="float: right;" id="search" url="<?php echo U('index');?>"><i class="btn-search"></i></a> -->
				</div><?php endif; ?>
            
			<div class="sleft" style="border: none;">
				<label>创建时间：</label>
            	<input type="text" id="time-start" name="time-start" class="text input-2x" value="<?php echo I('time-start');?>" placeholder="起始时间" />-
                <div class="input-append date" id="datetimepicker"  style="display:inline-block">
                    <input type="text" id="time-end" name="time-end" class="text input-2x" value="<?php echo I('time-end');?>" placeholder="结束时间" />
                    <span class="add-on"><i class="icon-th"></i></span>
                </div>
            </div>
        	<button class="btn" id="search" style="float: left;" url="<?php echo U('index');?>">搜　索</button>
		</div>
    </div>

    <!-- 获取设备列表 -->
    <div class="device_box" style="text-align: center;">
    	<h2>设备列表</h2>
    	<div class="device">
		  搜索设备：
		  <div class="layui-inline">
		    <input class="layui-input" name="id" id="device_id" placeholder="请输入设备ID号" autocomplete="off">
		  </div>
		  <button class="layui-btn" data-type="reload">搜索</button>
		</div>
    	<table class="layui-hide" id="device" lay-filter="device"></table>
    </div>

    <!-- 获取加盟商列表 -->
    <div class="business_box" style="text-align: center;">
    	<h2>加盟商列表</h2>
    	<div class="business">
		  搜索加盟商：
		  <div class="layui-inline">
		    <input class="layui-input" name="id" id="business_name" placeholder="请输入加盟商名称" autocomplete="off">
		  </div>
		  <button class="layui-btn" data-type="reload">搜索</button>
		</div>
    	<table class="layui-hide" id="business" lay-filter="business"></table>
    </div>

    <!-- 获取店铺列表 -->
    <div class="shop_box" style="text-align: center;">
    	<h2>店铺列表</h2>
    	<div class="shop">
		  搜索店铺：
		  <div class="layui-inline">
		    <input class="layui-input" name="id" id="shop_name" placeholder="请输入店铺名称" autocomplete="off">
		  </div>
		  <button class="layui-btn" data-type="reload">搜索</button>
		</div>
    	<table class="layui-hide" id="shop" lay-filter="shop"></table>
    </div>

    <!-- 数据列表 -->
    <div class="data-table table-striped">
	<table class="">
    <thead>
        <tr>
		<!-- <th class="row-selected row-selected"><input class="check-all" type="checkbox"/></th> -->
		<th class="">序号</th>
		<th class="">商品名称</th>
		<th class="">销售数量</th>
		<th class="">销售金额</th>
		<th class="">成本</th>
		<th class="">利润</th>
		</tr>
    </thead>
    <tbody>
		<?php if(!empty($list)): if(is_array($list)): $index = 0; $__LIST__ = $list;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($index % 2 );++$index;?><tr>
            <!-- <td><input class="ids" type="checkbox" name="id[]" value="<?php echo ($vo["order_id"]); ?>" /></td> -->
			<td><?php echo ($index); ?> </td>
			<td><?php echo ($vo["goods_name"]); ?></td>
			<?php if(empty($vo["small_num"])): ?><td>0</td>
				<?php else: ?>
				<td style="color: red"><?php echo ($vo["small_num"]); ?></td><?php endif; ?>
			<?php if(empty($vo["small_cell_price"])): ?><td>0.00</td>
				<?php else: ?>
				<td style="color: red"><?php echo ($vo["small_cell_price"]); ?></td><?php endif; ?>
			<?php if(empty($vo["small_cost"])): ?><td>0.00</td>
				<?php else: ?>
				<td style="color: red"><?php echo ($vo["small_cost"]); ?></td><?php endif; ?>
			<?php if(empty($vo["small_profit"])): ?><td>0.00</td>
				<?php else: ?>
				<td style="color: red"><?php echo ($vo["small_profit"]); ?></td><?php endif; ?>
		</tr><?php endforeach; endif; else: echo "" ;endif; ?>
		<?php else: ?>
		<td colspan="9" class="text-center"> aOh! 暂时还没有内容! </td><?php endif; ?>
	</tbody>
    </table>
    <div style="display: flex;justify-content: space-between;width: 50%;margin: auto;height: 50px;line-height: 50px;font-size: 16px;font-weight: bold;color: #E7262C">
    	<p>总销数量：<?php echo ($allnum); ?></p>
    	<p>总销售额：<?php echo ($allsalesamount); ?></p>
    	<p>总成本：<?php echo ($allcost); ?></p>
    	<p>总盈利：<?php echo ($allprofit); ?></p>
    </div>
	</div>
    <div class="page">
        <?php echo ($_page); ?>
    </div>

        </div>
        <div class="cont-ft">
            <div class="copyright">
                <!-- <div class="fl">感谢使用<a href="http://www.onethink.cn" target="_blank">OneThink</a>管理平台</div>
                <div class="fr">V<?php echo (ONETHINK_VERSION); ?></div> -->
            </div>
        </div>
    </div>
    <!-- /内容区 -->
    <script type="text/javascript">
    (function(){
        var ThinkPHP = window.Think = {
            "ROOT"   : "", //当前网站地址
            "APP"    : "/index.php?s=", //当前项目地址
            "PUBLIC" : "/Public", //项目公共目录地址
            "DEEP"   : "<?php echo C('URL_PATHINFO_DEPR');?>", //PATHINFO分割符
            "MODEL"  : ["<?php echo C('URL_MODEL');?>", "<?php echo C('URL_CASE_INSENSITIVE');?>", "<?php echo C('URL_HTML_SUFFIX');?>"],
            "VAR"    : ["<?php echo C('VAR_MODULE');?>", "<?php echo C('VAR_CONTROLLER');?>", "<?php echo C('VAR_ACTION');?>"]
        }
    })();
    </script>
    <script type="text/javascript" src="/Public/static/think.js"></script>
    <script type="text/javascript" src="/Public/Admin/js/common.js"></script>
    <script type="text/javascript">
        +function(){
            var $window = $(window), $subnav = $("#subnav"), url;
            $window.resize(function(){
                $("#main").css("min-height", $window.height() - 130);
            }).resize();

            /* 左边菜单高亮 */
            url = window.location.pathname + window.location.search;
            url = url.replace(/(\/(p)\/\d+)|(&p=\d+)|(\/(id)\/\d+)|(&id=\d+)|(\/(group)\/\d+)|(&group=\d+)/, "");
            $subnav.find("a[href='" + url + "']").parent().addClass("current");

            /* 左边菜单显示收起 */
            $("#subnav").on("click", "h3", function(){
                var $this = $(this);
                $this.find(".icon").toggleClass("icon-fold");
                $this.next().slideToggle("fast").siblings(".side-sub-menu:visible").
                      prev("h3").find("i").addClass("icon-fold").end().end().hide();
            });

            $("#subnav h3 a").click(function(e){e.stopPropagation()});

            /* 头部管理员菜单 */
            $(".user-bar").mouseenter(function(){
                var userMenu = $(this).children(".user-menu ");
                userMenu.removeClass("hidden");
                clearTimeout(userMenu.data("timeout"));
            }).mouseleave(function(){
                var userMenu = $(this).children(".user-menu");
                userMenu.data("timeout") && clearTimeout(userMenu.data("timeout"));
                userMenu.data("timeout", setTimeout(function(){userMenu.addClass("hidden")}, 100));
            });

	        /* 表单获取焦点变色 */
	        $("form").on("focus", "input", function(){
		        $(this).addClass('focus');
	        }).on("blur","input",function(){
				        $(this).removeClass('focus');
			        });
		    $("form").on("focus", "textarea", function(){
			    $(this).closest('label').addClass('focus');
		    }).on("blur","textarea",function(){
			    $(this).closest('label').removeClass('focus');
		    });

            // 导航栏超出窗口高度后的模拟滚动条
            var sHeight = $(".sidebar").height();
            var subHeight  = $(".subnav").height();
            var diff = subHeight - sHeight; //250
            var sub = $(".subnav");
            if(diff > 0){
                $(window).mousewheel(function(event, delta){
                    if(delta>0){
                        if(parseInt(sub.css('marginTop'))>-10){
                            sub.css('marginTop','0px');
                        }else{
                            sub.css('marginTop','+='+10);
                        }
                    }else{
                        if(parseInt(sub.css('marginTop'))<'-'+(diff-10)){
                            sub.css('marginTop','-'+(diff-10));
                        }else{
                            sub.css('marginTop','-='+10);
                        }
                    }
                });
            }
        }();
    </script>
    
<link href="/Public/static/datetimepicker/css/datetimepicker.css" rel="stylesheet" type="text/css">
<?php if(C('COLOR_STYLE')=='blue_color') echo '<link href="/Public/static/datetimepicker/css/datetimepicker_blue.css" rel="stylesheet" type="text/css">'; ?>
<link href="/Public/static/datetimepicker/css/dropdown.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/Public/static/datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="/Public/static/datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script type="text/javascript">
    highlight_subnav('<?php echo U('Order/index');?>');
    statusflag = "<?php echo isset($_GET['status'])?$_GET['status']:" ";?>";
    if (statusflag!="") {
    	$("#status"+statusflag).attr("selected","selected");
    }
$(function(){
	//搜索功能
	$("#search").click(function(){
		var url = $(this).attr('url');
		// var status = $("#sch-sort-txt").attr("data");
        var query  = $('.search-form').find('input').serialize();
        query = query.replace(/(&|^)(\w*?\d*?\-*?_*?)*?=?((?=&)|(?=$))/g,'');
        query = query.replace(/^&/g,'');
		if(status != ''){
			query +=  query;
        }
        if( url.indexOf('?')>0 ){
            url += '&' + query;
        }else{
            url += '?' + query;
        }
		window.location.href = url;
	});

	/* 状态搜索子菜单 */
	$(".search-form").find(".drop-down").hover(function(){
		$("#sub-sch-menu").removeClass("hidden");
	},function(){
		$("#sub-sch-menu").addClass("hidden");
	});
	$("#sub-sch-menu li").find("a").each(function(){
		$(this).click(function(){
			var text = $(this).text();
			$("#sch-sort-txt").text(text).attr("data",$(this).attr("value"));
			$("#sub-sch-menu").addClass("hidden");
		})
	});

    //回车自动提交
    $('.search-form').find('input').keyup(function(event){
        if(event.keyCode===13){
            $("#search").click();
        }
    });

    $('#time-start').datetimepicker({
        format: 'yyyy-mm-dd',
        language:"zh-CN",
	    minView:2,
	    autoclose:true
    });

    $('#datetimepicker').datetimepicker({
       format: 'yyyy-mm-dd',
        language:"zh-CN",
        minView:2,
        autoclose:true,
        pickerPosition:'bottom-left'
    })

    $("#getdevice").click(function(e){
		$(".device_box").toggle();
		$(".business_box").hide();
		$(".shop_box").hide();

		console.log("focus");
		e.stopPropagation();
	}) 
	$(".device_box").click(function(e){
		$(".device_box").show();

		console.log("device_box");
		e.stopPropagation();
	})
	$(document).click(function(){
		$(".device_box").hide();
	})

	$("#getbusiness").click(function(e){
		$(".business_box").toggle();
		$(".device_box").hide();
		$(".shop_box").hide();
		console.log("focus");
		e.stopPropagation();
	}) 
	$(".business_box").click(function(e){
		$(".business_box").show();
		console.log("business_box");
		e.stopPropagation();
	})
	$(document).click(function(){
		$(".business_box").hide();
	})

	$("#getshop").click(function(e){
		$(".shop_box").toggle();
		$(".device_box").hide();
		$(".business_box").hide();		
		console.log("focus");
		e.stopPropagation();
	}) 
	$(".shop_box").click(function(e){
		$(".shop_box").show();
		console.log("shop_box");
		e.stopPropagation();
	})
	$(document).click(function(){
		$(".shop_box").hide();
	})

	$("#status").change(function(e){
		// console.log(e.currentTarget.value);
		// status = e.currentTarget.value;
		// $("#statusvalue").val(e.currentTarget.value);
		window.location.href="/index.php?s=/Admin/Finance/index/status/"+e.currentTarget.value
	})


})
</script>
<script>
layui.use('table',function(){
  var table = layui.table;
  table.render({
    elem: '#device'
    ,url:'/index.php?s=/Admin/Finance/devicelist'
    ,limit:6
    ,limits:[6]
    ,cols: [[
      {field:'id', width:"5%", title: 'ID'}
      ,{field:'device_id', width:"14%", title: '设备ID号'}
      ,{field:'device_name', width:"14%", title: '设备名称'}
      ,{field:'city', width:"13%", title: '操作',toolbar: '#deviceop'}
    ]]
    ,id: 'deviceReload'
    ,page: true
  });
   	table.on('tool(device)', function(obj){
	    var data = obj.data;
	    if(obj.event === 'choose'){
	    	// layer.msg('ID：'+ data.device_id + ' 的查看操作');
	    	$("#getdevice").val(data.device_id);
	    }
	  });

   	  var $ = layui.$, active = {
	    reload: function(){
	      var device_id = $('#device_id');
	      
	      //执行重载
	      table.reload('deviceReload', {
	        page: {
	          curr: 1 //重新从第 1 页开始
	        }
	        ,where: {
	            device_id: device_id.val()
	        }
	      });
	    }
	  };
  $('.device .layui-btn').on('click', function(){
    var type = $(this).data('type');
    active[type] ? active[type].call(this) : '';
  });
});
</script>

<script type="text/html" id="deviceop">
  <!-- <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a> -->
  <a class="layui-btn layui-btn-xs" lay-event="choose">选择</a>
</script>

<script>
layui.use('table',function(){
  var table = layui.table;
  table.render({
    elem: '#business'
    ,url:'/index.php?s=/Admin/Finance/businesslist'
    ,limit:6
    ,limits:[6]
    ,cols: [[
      {field:'business_id', width:"5%", title: 'ID'}
      ,{field:'business_name', width:"14%", title: '加盟商名称'}
      ,{field:'business_address', width:"14%", title: '加盟商地址'}
      ,{field:'city', width:"13%", title: '操作',toolbar: '#businessop'}
    ]]
    ,id: 'bussinessReload'
    ,page: true
  });
   	table.on('tool(business)', function(obj){
	    var data = obj.data;
	    if(obj.event === 'choose'){
	    	// layer.msg('ID：'+ data.device_id + ' 的查看操作');
	    	$("#getbusiness").val(data.business_name);
	    }
	  });

   	  var $ = layui.$, active = {
	    reload: function(){
	      var business_name = $('#business_name');
	      
	      //执行重载
	      table.reload('bussinessReload', {
	        page: {
	          curr: 1 //重新从第 1 页开始
	        }
	        ,where: {
	            business_name: business_name.val()
	        }
	      });
	    }
	  };
  $('.business .layui-btn').on('click', function(){
    var type = $(this).data('type');
    active[type] ? active[type].call(this) : '';
  });
});
</script>

<script type="text/html" id="businessop">
  <!-- <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a> -->
  <a class="layui-btn layui-btn-xs" lay-event="choose">选择</a>
</script>

<script>
layui.use('table',function(){
  var table = layui.table;
  table.render({
    elem: '#shop'
    ,url:'/index.php?s=/Admin/Finance/shoplist'
    ,limit:6
    ,limits:[6]
    ,cols: [[
      {field:'shop_id', width:"5%", title: 'ID'}
      ,{field:'shop_name', width:"14%", title: '店铺名称'}
      ,{field:'shop_address', width:"14%", title: '店铺地址'}
      ,{field:'city', width:"13%", title: '操作',toolbar: '#shopop'}
    ]]
    ,id: 'shopReload'
    ,page: true
  });
   	table.on('tool(shop)', function(obj){
	    var data = obj.data;
	    if(obj.event === 'choose'){
	    	// layer.msg('ID：'+ data.device_id + ' 的查看操作');
	    	$("#getshop").val(data.shop_name);
	    }
	  });

   	  var $ = layui.$, active = {
	    reload: function(){
	      var shop_name = $('#shop_name');
	      
	      //执行重载
	      table.reload('shopReload', {
	        page: {
	          curr: 1 //重新从第 1 页开始
	        }
	        ,where: {
	            shop_name: shop_name.val()
	        }
	      });
	    }
	  };
  $('.shop .layui-btn').on('click', function(){
    var type = $(this).data('type');
    active[type] ? active[type].call(this) : '';
  });
});
</script>

<script type="text/html" id="shopop">
  <!-- <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a> -->
  <a class="layui-btn layui-btn-xs" lay-event="choose">选择</a>
</script>

</body>
</html>