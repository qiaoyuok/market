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
        <h2>新增货柜<?php echo ($is_hidden); ?></h2>
    </div>
    <form action="<?php echo U();?>" method="post" class="form-horizontal">
        <div class="form-item" style="height:35px;">
            <label class="item-label"style="float:left">货柜名称</label>
            <div class="controls" style="float:left">
                <input type="text" class="text input-large" name="device_name" value="">
            </div>
        </div>
        <div class="form-item" style="height:35px;">
            <label class="item-label" style="float:left">货柜id号</label>
            <div class="controls" style="float:left">
                <input type="text" class="text input-large" name="device_id" value="">
            </div>
        </div>
        <?php if(($is_hidden) != "1"): ?><div class="form-item" style="height:35px;">
                <label class="item-label" style="float:left">所属店铺</label>
                <div class="controls" style="float:left">
                    <?php if(!empty($shoplists)): ?><select name="shop_id" id="shopselect">
                            <?php if(is_array($shoplists)): $i = 0; $__LIST__ = $shoplists;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><option value="<?php echo ($vo["shop_id"]); ?>"><?php echo ($vo["shop_name"]); ?></option><?php endforeach; endif; else: echo "" ;endif; ?>
                        </select>
                        <?php else: ?>
                        <a href="<?php echo U('Shop/add');?>">请先添加店铺</a><?php endif; ?>
                </div>
            </div><?php endif; ?>

       <div class="form-item" style="height:35px;">
            <label class="item-label" style="float:left">所属锁板</label>
            <div id="addlock" class="controls" style="float:left;position: relative;">
                <select name="lock_id" id="lock">
                   <?php if(!empty($firstshop)): if(is_array($locklists)): $i = 0; $__LIST__ = $locklists;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i; if(($vo["shop_id"]) == $firstshop["shop_id"]): ?><option value="<?php echo ($vo["lock_id"]); ?>">锁板ID号<?php echo ($vo["lock_id"]); ?></option><?php endif; endforeach; endif; else: echo "" ;endif; endif; ?>
                </select>
            </div>
            <label class="item-label" style="float:left;margin-left:25px;">锁号</label>
            <div class="controls" style="float:left">
                <select name="lock_num" id="lock_num">
                    <?php $__FOR_START_27321__=1;$__FOR_END_27321__=51;for($i=$__FOR_START_27321__;$i < $__FOR_END_27321__;$i+=1){ if(in_array(($i), explode(',',"<?php echo ($usedlocks_num); ?>"))): else: ?><option value="<?php echo ($i); ?>"><?php echo ($i); ?></option><?php endif; } ?>
                </select>
            </div>
        </div>
        <br>
        <div class="form-item">
            <button class="btn submit-btn ajax-post" id="submit" type="submit" target-form="form-horizontal">确 定</button>
            <button class="btn btn-return" onclick="javascript:history.back(-1);return false;">返 回</button>
        </div>
    </form>

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
        highlight_subnav('<?php echo U('Device/index');?>');

        locklists = <?php echo json_encode($locklists);?>;
        grouplocks = <?php echo json_encode($grouplocks);?>;

        $("#shopselect").change(function(e){
            console.log(e.currentTarget.value)

            shop_id = e.currentTarget.value;
            // 删除锁板子元素
            clearselect();
            // 删除锁号子元素
            clearclock_num();
            // 添加锁板子元素
            appendselect(shop_id);
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

            var length = $("#lock").children().length;
            console.log("当前锁板列表长度",length);
            if (length!=0) {

                for (var i = 0; i < length; i++) {
                    
                    ($("#lock").children()[0]).remove();
                }
                console.log("删除子元素成功");
            }
        }

        function clearclock_num() {

            //删除锁号列表下所有的子元素
            var length = $("#lock_num").children().length;
            console.log("当前锁号列表长度",length);
            if (length!=0) {

                for (var i = 0; i < length; i++) {
                    
                    ($("#lock_num").children()[0]).remove();
                }
                console.log("删除锁号子元素成功");
            }
        }

        function appendselect(shop_id){
            flag = 0;
            $.each(locklists,function(index,element) {
                // console.log("element:",element);
                // console.log("index:",index);
                if (element.shop_id==shop_id) {
                    ++flag;
                    if(flag == 1){
                        appendlockselect(element.lock_id);
                    }
                    $("#lock").append("<option value="+element.lock_id+">锁板ID号"+element.lock_id+"</option>");
                }
            })
        }

        //添加锁号
        function appendlockselect(lock_id) {
            arr = new Array();
            if (grouplocks != null) {
                $.each(grouplocks,function(index,element){
                    if(element.lock_id == lock_id){
                        arr[index] = element.lock_num;
                    }
                })
            }
            
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
    </script>

</body>
</html>