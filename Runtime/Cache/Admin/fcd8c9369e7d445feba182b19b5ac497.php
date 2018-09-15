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
            

            
    <div class="main-title">
        <h2>添加货品</h2>
    </div>
    <form action="<?php echo U('addshopgoods');?>" method="post" class="form-horizontal">
        <div class="form-item">
            <!-- <label class="item-label">选择货品</label> -->
            <div class="controls">
                <p id="but" style="cursor: pointer;color: green;font-size: 22px;">点击选择商品</p>
                <input type="text" class="text input-large" style="display: none;" name="shop_id" value="<?php echo ($shop_id); ?>">
                <input type="text" class="text input-large" style="display: none;" id="goods_id" name="goods_id" value="">
                <input type="text" class="text input-large" style="display: none;" id="goods_name" name="goods_name" value="">
                <input type="text" class="text input-large" style="display: none;" id="cate_id" name="cate_id" value="">
            </div>
        </div>
        <div class="form-item">
            <label class="item-label">进货价</label>
            <div class="controls">
                <input type="text" class="text input-large" name="cost">
            </div>
        </div>
        <div class="form-item">
            <label class="item-label">销售价</label>
            <div class="controls">
                <input type="text" class="text input-large" name="cell_price">
            </div>
        </div>
        <div class="form-item">
            <button class="btn submit-btn ajax-post" id="submit" type="submit" target-form="form-horizontal">确 定</button>
            <button class="btn btn-return" onclick="javascript:history.back(-1);return false;">返 回</button>
        </div>
    </form>

    <div id="background" style="position:absolute;width:100%;height:100%;top:0;left:0;background:rgba(134, 148, 192, 0.5);display:none">
        <div id="tablebox" style="width:50%;height:400px;border:1px solid #EEE;margin:150px auto;background:#fff;padding:15px;">
            <h3 style="text-align:center;font-size:18px;font-weight:bold;border-bottom:1px solid #E6E6E6;height:35px;line-height:35px;margin-bottom:5px;">货品选择</h3>
            <div style="width:100%;height:33px;">
                <form  class="layui-form">
                    <div style="max-width:350px;float:left;">
                        <label class="layui-form-label">货品分类:</label>
                        <div class="layui-input-block">
                            <select id="cate_name" lay-verify=""  lay-filter="cateselect">
                                <option value="0">全部</option>
                                <?php if(!empty($catelists)): if(is_array($catelists)): $i = 0; $__LIST__ = $catelists;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i; if($_GET['cate_id'] == $vo['cate_id']): ?><option value="<?php echo ($vo["cate_id"]); ?>" selected="selected"><?php if(($vo["lev"]) == "1"): ?>　　<?php endif; echo ($vo["cate_name"]); ?></option>
                                            <?php else: ?>
                                            <option value="<?php echo ($vo["cate_id"]); ?>"><?php if(($vo["lev"]) == "1"): ?>　　<?php endif; echo ($vo["cate_name"]); ?></option><?php endif; endforeach; endif; else: echo "" ;endif; endif; ?>
                            </select>
                        </div>
                    </div>
                </form>
                <div class="demoTable" style="float:right;">
                    搜索商品名：
                    <div class="layui-inline">
                        <input class="layui-input" name="id" id="demoReload" autocomplete="off">
                    </div>
                    <button class="layui-btn" data-type="reload">搜索</button>
                </div>
            </div>
            <div style="width:100%;height:300px;">
                <table class="layui-hide" id="LAY_table_user" lay-filter="user"></table> 
            </div>
            
        </div>
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
    
    <script type="text/javascript">
        //导航高亮
        highlight_subnav('<?php echo U('Shop/index');?>');

        $("#but").click(function(e){
           $("#background").show();
        })
    </script>


     <script>
        layui.use('form', function(){
            var form = layui.form;
            
            //监听提交
            form.on('submit(formDemo)', function(data){
                layer.msg(JSON.stringify(data.field));
                return false;
            });
        }); 
    </script>


    <script>
layui.use('table', function(){
  var table = layui.table;
  shop_id = <?php echo ($shop_id); ?>;
  //方法级渲染
  table.render({
    elem: '#LAY_table_user'
    ,url: '/index.php?s=/Admin/Shop/setgoodslists/shop_id/'+shop_id
    ,cols: [[
    //   {checkbox: true, fixed: true}
      {field:'goods_id', title: 'ID', width:80, fixed: true}
      ,{field:'goods_name', title: '货品名称', width:300}
      ,{field:'goods_price', title: '价格', width:200}
      ,{field:'goods_num', title: '库存', width:200}
      ,{field:'city', width:150, title: '操作',toolbar: '#barDemo'}
    ]]
    ,limit:6
    ,limits:[6]
    ,id: 'testReload'
    ,page: true
  });
  
  var $ = layui.$, active = {
    reload: function(){
      var demoReload = $('#demoReload');
      
      //执行重载
      table.reload('testReload', {
        page: {
          curr: 1 //重新从第 1 页开始
        }
        ,where: {
            goods_name: demoReload.val(),
            shop_id: <?php echo ($shop_id); ?>,
        }
      });
    }
  };
  
  $('.demoTable .layui-btn').on('click', function(){
    var type = $(this).data('type');
    active[type] ? active[type].call(this) : '';
  });

    

});
layui.use(['form','table'] ,function(){
        var form = layui.form;
        var table = layui.table;
        
        form.on('select(cateselect)', function(data){
            table.reload('testReload', {
                url: '/index.php?s=/Admin/Shop/setgoodslists'
                ,page: {curr: 1  }
                ,where: {cate_id:data.value,shop_id:shop_id} //设定异步数据接口的额外参数
                //,height: 300
            });
        });

        table.on('tool(user)', function(obj){
            
            var data = obj.data;
            console.log(data)
            if(obj.event === 'choose'){
                layer.msg('已选商品：'+ data.goods_name);
                $("#but").html(data.goods_name);
                $("#goods_id").val(data.goods_id);
                $("#goods_name").val(data.goods_name);
                $("#cate_id").val(data.cate_id);
               
            }
        });
    });
    
</script>

<script type="text/html" id="barDemo">
  <!-- <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a> -->
  <a class="layui-btn layui-btn-xs" lay-event="choose">选择</a>
</script>

<script>
    
    $("#tablebox").click(function(e){
        $("#background").show();
        e.stopPropagation();
        
    })
    $("#background").click(function(e){
        // console.log("hah ")
        $("#background").hide();
        e.stopPropagation();
    })
</script>

</body>
</html>