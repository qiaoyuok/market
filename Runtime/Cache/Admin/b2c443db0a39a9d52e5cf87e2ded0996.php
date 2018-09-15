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
        <h2>新增货柜</h2>
    </div>
    <form action="<?php echo U();?>" method="post" class="form-horizontal">
        <div class="form-item" style="height:35px;">
            <label class="item-label"style="float:left">货柜名称</label>
            <div class="controls" style="float:left">
                <input type="text" class="text input-large" name="device_name" value="<?php echo ($deviceinfo["device_name"]); ?>">
                <input type="text" class="text input-large" style="display:none" name="device_id" value="<?php echo ($deviceinfo["device_id"]); ?>">
            </div>
        </div>
        
        <?php if(($is_show) == "1"): ?><div class="form-item" style="height:35px;">
                <label class="item-label" style="float:left">所属店铺</label>
                <div class="controls" style="float:left">
                    <?php if(!empty($shoplists)): ?><select name="shop_id" id="shopselect">
                            <?php if(is_array($shoplists)): $i = 0; $__LIST__ = $shoplists;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i; if(($vo["shop_id"]) == $deviceinfo["shop_id"]): ?><option selected value="<?php echo ($vo["shop_id"]); ?>"><?php echo ($vo["shop_name"]); ?></option>
                                    <?php else: ?><option value="<?php echo ($vo["shop_id"]); ?>"><?php echo ($vo["shop_name"]); ?></option><?php endif; endforeach; endif; else: echo "" ;endif; ?>
                        </select>
                        <?php else: ?><a href="<?php echo U('Shop/add');?>">请先添加店铺</a><?php endif; ?>
                </div>
            </div>

           <div class="form-item" style="height:35px;">
                <label class="item-label" style="float:left">所属锁板</label>
                <div class="controls" style="float:left">
                    <?php if(!empty($thisshoplocks)): ?><select name="lock_id" id="lock">
                            <?php if(is_array($thisshoplocks)): $i = 0; $__LIST__ = $thisshoplocks;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i; if(($vo["lock_id"]) == $deviceinfo["lock_id"]): ?><option selected value="<?php echo ($vo["lock_id"]); ?>">锁板ID号<?php echo ($vo["lock_id"]); ?></option>
                                    <?php else: ?><option value="<?php echo ($vo["lock_id"]); ?>">锁板ID号<?php echo ($vo["lock_id"]); ?></option><?php endif; endforeach; endif; else: echo "" ;endif; ?>
                        </select>
                        <?php else: ?><a href="<?php echo U('addlock');?>">请先添加锁板</a><?php endif; ?>
                </div>
                <label class="item-label" style="float:left;margin-left:25px;">锁号</label>
                <div class="controls" style="float:left">
                    <select name="lock_num" id="lock_num">
                        <?php $__FOR_START_21132__=1;$__FOR_END_21132__=51;for($i=$__FOR_START_21132__;$i < $__FOR_END_21132__;$i+=1){ if(in_array(($i), explode(',',"<?php echo ($usedlocks_num); ?>"))): else: ?>
                                <?php if(($i) == $deviceinfo["lock_num"]): ?><option selected value="<?php echo ($i); ?>"><?php echo ($i); ?></option>
                                    <?php else: ?><option value="<?php echo ($i); ?>"><?php echo ($i); ?></option><?php endif; endif; } ?>
                    </select>
                </div>
            </div>
        
        <div class="form-item" style="height:35px;">
                <label class="item-label" style="float:left">货板</label>
                <div class="controls" style="float:left">
                    <?php if(!empty($boards)): ?><select name="board_id" id="boardselect">
                            <?php if(is_array($boards)): $i = 0; $__LIST__ = $boards;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i; if(($deviceinfo["board_id"]) == $vo["board_id"]): ?><option value="<?php echo ($vo["board_id"]); ?>" selected="selected">货板ID号<?php echo ($vo["board_id"]); ?></option>
                                    <?php else: ?>
                                    <option value="<?php echo ($vo["board_id"]); ?>">货板ID号<?php echo ($vo["board_id"]); ?></option><?php endif; endforeach; endif; else: echo "" ;endif; ?>
                        </select>
                        <?php else: ?>
                        <a href="<?php echo U('addboard');?>">请先添加货板</a><?php endif; ?>
                </div>
            </div><?php endif; ?>
            <input id="smallboxparams" style="display:none" type="text" name="goods_status">
        <div class="smallbox" style="font-size: 16px;font-weight: bold;">
            <ul>
                <?php if(empty($goods_status)): $__FOR_START_32213__=1;$__FOR_END_32213__=19;for($i=$__FOR_START_32213__;$i < $__FOR_END_32213__;$i+=1){ ?><li onclick="setgoods(<?php echo ($i); ?>)" id="smallbox<?php echo ($i); ?>" style="cursor:pointer"><p>配置货品</p></li><?php } ?>
                    <?php else: ?>
                    <?php if(is_array($goods_status)): $i = 0; $__LIST__ = $goods_status;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i; if(($vo) == ""): ?><li onclick="setgoods(<?php echo ($i); ?>)" id="smallbox<?php echo ($i); ?>" style="cursor:pointer"><p>配置货品</p></li>
                            <?php else: ?>
                            <li style="background:#5FB878;cursor:pointer" onclick="setgoods(<?php echo ($i); ?>)" id="smallbox<?php echo ($i); ?>"><p><?php echo ($vo); ?></p><p onclick="cancelgoods(event,<?php echo ($i); ?>)" style="font-size: 14px;background: #FF5722;margin: auto;margin-top: 8px;cursor: pointer;color:#fff;">取　消</p></li><?php endif; endforeach; endif; else: echo "" ;endif; endif; ?>
            </ul>
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
  //方法级渲染
  shop_id = <?php echo ($deviceinfo["shop_id"]); ?>;
  table.render({
    elem: '#LAY_table_user'
    ,url: '/index.php?s=/Admin/Device/setgoodslists/shop_id/'+shop_id
    ,cols: [[
    //   {checkbox: true, fixed: true}
      {field:'shopgoods_id', title: 'ID', width:80, fixed: true}
      ,{field:'goods_name', title: '货品名称', width:200}
      ,{field:'cost', title: '进价', width:100}
      ,{field:'cell_price', title: '售价', width:100}
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
            shop_id:shop_id,
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
                url: '/index.php?s=/Admin/Device/setgoodslists/shop_id/'+shop_id
                ,page: {curr: 1  }
                ,where: {cate_id:data.value} //设定异步数据接口的额外参数
                //,height: 300
            });
        });

        function getsetgoods(shop_id='') {
            console.log("请求了！")
            table.reload('testReload', {
                url: '/index.php?s=/Admin/Device/setgoodslists/shop_id/'+shop_id
                ,page: {curr: 1  }
                
                //,height: 300
            });
        }
        //导航高亮
        highlight_subnav('<?php echo U('Device/index');?>');

        locklists = <?php echo json_encode($locklists);?>;
        grouplocks = <?php echo json_encode($grouplocks);?>;
        boardlists = <?php echo json_encode($boardlists);?>;
        console.log(boardlists);
        arr = new Array();
        <?php if (!empty($jsgoods_status)) { foreach($jsgoods_status as $k=>$v){?>
                arr[<?php echo $k;?>] = <?php if($v==null){echo "null";}else{foreach($v as $k1=>$v1){echo $k1;}}?>;
        <?php  } } ?>
    // console.log(arr);
        $("#shopselect").change(function(e){
            console.log(e.currentTarget.value)

            shop_id = e.currentTarget.value;
            // 删除锁板子元素
            clearselect();
            // 删除锁号子元素
            clearclock_num();

            //删除货板子元素
            clearboard(shop_id);

            // 添加锁板子元素
            appendselect(shop_id);

            //获取该店铺已配置商品
            getsetgoods(shop_id);

        })
        $("#lock").change(function(e){
            console.log(e.currentTarget.value)

            lock_id = e.currentTarget.value;
           
            // 删除锁号子元素
            clearclock_num();
            // 添加锁号
            appendlockselect(lock_id);
        })

        function clearselect(){

            //删除锁板列表下的所有元素
            var length = $("#lock").children().length;
            console.log("当前锁板列表长度",length);
            if (length!=0) {

                for (var i = 0; i < length; i++) {
                    
                    ($("#lock").children()[0]).remove();
                }
                console.log("删除锁板子元素成功");
            }
        }

        function clearboard(shop_id){

            //删除货板列表下的所有元素
            var length = $("#boardselect").children().length;
            console.log("当前货板列表长度",length);
            if (length!=0) {

                for (var i = 0; i < length; i++) {
                    
                    ($("#boardselect").children()[0]).remove();
                }
                console.log("删除货板子元素成功");
            }

            // 添加货板子元素
            if (boardlists!=null) {
                flag_board = 0;
                var board_parent = $("#boardselect").parent();
                board_parent.html("");
                $.each(boardlists,function(index,element){
                    if (element.shop_id == shop_id) {
                        flag_board++;
                        
                        if (flag_board==1) {
                            board_parent.append('<select name="board_id" id="boardselect">');
                            goods_status(element.board_id)
                        }
                        $("#boardselect").append("<option value="+element.board_id+">货板ID号"+element.board_id+"</option>");
                    }    
                })

                if (flag_board>=1) {
                    board_parent.append('</select>');
                }

                if (flag_board == 0) {
                    board_parent.html("<a id='boardselect' href='/index.php?s=/Admin/Device/addboard'>添加货板</a>");
                }
            }
        }

        //监测货板id是否改变
        $("#boardselect").change(function(e){
            
            board_id = e.currentTarget.value;
            goods_status(board_id);

        })

        // 公用货板ID号发生改变获取该货板商品配置
        function goods_status(board_id=''){
            $.post("/index.php?s=/Admin/Device/getboardset","board_id="+board_id,function(res){
                // console.log(res);return false;
                res = JSON.parse(res);
                // console.log(res);
                if (res.status == 1) {
                    $.each(res.jsgoods_status,function(index,element){
                        if (element!=null) {
                            for(x in element){
                                arr[index] = x;
                            }
                        }else{
                            arr[index] = null;
                        }
                    })
                    console.log(res.goods_status)
                    // 往小板上填商品名
                    for(k in res.goods_status){
                        
                        if (res.goods_status[k]!=null) {
                            $("#smallbox"+k).css("background","#5FB878");
                            $("#smallbox"+k).html('<p>'+res.goods_status[k]+'</p><p onclick="cancelgoods(event,'+k+')" style="font-size: 14px;background: #FF5722;margin: auto;margin-top: 8px;cursor: pointer;color:#fff">取　消</p>');
                        }else{
                            $("#smallbox"+k).html("<p>配置货品</p>");
                            $("#smallbox"+k).css("background","none");
                        }
                    }
                }else if(res.status == 2){
                    arr = [];
                    for (var i = 1; i <= 18; i++) {
                        
                        $("#smallbox"+i).html("<p>配置货品</p>");
                        $("#smallbox"+i).css("background","none");
                        $("#smallboxparams").val("");
                    }
                }
                // console.log("arr:",arr)
            })
        }

        

        function clearclock_num() {

            //删除锁号列表下所有的子元素
            var length = $("#lock_num").children().length;
            console.log("当前锁板列表长度",length);
            if (length!=0) {

                for (var i = 0; i < length; i++) {
                    
                    ($("#lock_num").children()[0]).remove();
                }
                console.log("删除锁号子元素成功");
            }
        }

        function appendselect(shop_id){
            flag = 0;
            var lock_parent = $("#lock").parent();
            lock_parent.html("");
            $.each(locklists,function(index,element) {
                if (element.shop_id==shop_id) {
                    ++flag;
                    if(flag == 1){
                        lock_parent.append('<select name="lock_id" id="lock">')
                        appendlockselect(element.lock_id);
                    }
                    $("#lock").append("<option value="+element.lock_id+">锁板ID号"+element.lock_id+"</option>");
                }
            })

            if (flag>=1) {
                lock_parent.append("</select>");
            }
            console.log(flag);
            if (flag==0) {
                lock_parent.html("<a id='lock' href='/index.php?s=/Admin/Device/addlock'>添加锁板</a>");
            }
        }
        
        //添加锁号
        function appendlockselect(lock_id) {
            arr = new Array();
            $.each(grouplocks,function(index,element){
                if(element.lock_id == lock_id){
                    arr[index] = element.lock_num;
                }
            })
            
            console.log(arr);
            for (let i = 1; i < 51; i++) {
                bol = isinarray(i);
                if(bol){
                    $("#lock_num").append("<option value='"+i+"'>"+i+"</option>")
                }
                
            }
        }

        //判断某个元素是否在数组内
        function isinarray(i){
            for (let index = 0; index < arr.length; index++) {
                if(arr[index] == i){
                    return false;
                    break;
                }
            }
            return true;
        }
        
        table.on('tool(user)', function(obj){
            
            var data = obj.data;
            if(obj.event === 'choose'){
                layer.msg('已选商品：'+ data.goods_name);
                $("#smallbox"+smallbox).css("background","#5FB878");
                $("#smallbox"+smallbox).html('<p>'+data.goods_name+'</p><p onclick="cancelgoods(event,'+smallbox+')" style="font-size: 14px;background: #FF5722;margin: auto;margin-top: 8px;cursor: pointer;color:#fff">取　消</p>');

                arr[smallbox] = data.shopgoods_id;
                smallboxparams = window.JSON.stringify(arr);
                $("#smallboxparams").val(smallboxparams);
                console.log(smallboxparams);
            }
	    });
    });
    
</script>

<script type="text/html" id="barDemo">
  <!-- <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a> -->
  <a class="layui-btn layui-btn-xs" lay-event="choose">选择</a>
</script>

<script>
    function setgoods(i){
            console.log(i);
            $("#background").show();
            smallbox = i;

        }
        // 取消货品
        function cancelgoods(e,i){
            e.stopPropagation();
            $("#smallbox"+i).html("<p>配置货品</p>");
            $("#smallbox"+i).css("background","none");
            arr[i] = null;
            smallboxparams = window.JSON.stringify(arr);
            $("#smallboxparams").val(smallboxparams);
            console.log(smallboxparams);
        }
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