<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------

namespace Admin\Controller;
use Admin\Model\DeviceModel;

/**
 * 后台设备控制器
 * 
 */
class DeviceController extends AdminController {

   
    public function index($shop_id = ''){

        $Device   =   D('device');
        $where = 'd.shop_id = s.shop_id AND d.status >= 0';
        if (!empty($_GET['shop_id'])) {
            
            $where.=" and s.shop_id = ".I("shop_id");
        }
        if (!empty($_GET['device_id'])) {
            
            $where.=" and d.device_id like '%".I("device_id")."%'";
        }

         $uid = session("user_auth")['uid'];
         // 取得在超级管理员组下的所有管理员
        $auth_group_access = M("auth_group_access");
        $auth_group_access_group = $auth_group_access->where("group_id = 1")->select();

        foreach ($auth_group_access_group as $k => $v) {
            
            $super[] = $v['uid'];
        }
        // 如果不是超级管理员，先去获取本加盟商下面的所有店铺
        if(C('USER_ADMINISTRATOR') != $uid&&!(in_array($uid, $super))){

            // 如果是店铺管理员，则只查询出当前店铺
            $userinfo = M("ucenter_member")->where("id = ".$uid)->find();

            if($userinfo['shop_id']>0){
                $shop_id = $userinfo['shop_id'];
                $this->assign("is_hidden",1);
            }else{
                $business_id = M("member")->where("status >=0 and uid = ".$uid)->find()['business_id'];
                $shoplists = M("shop")->field("shop_id,shop_name")->where("status >=0 and business_id = ".$business_id)->select();
                $shop_id = "";
                // 把所有的店铺id号放到一个一维数组里面
                if (!empty($shoplists)) {
                    foreach ($shoplists as $k => $v) {
                        if ($k==(count($shoplists)-1)) {
                            $shop_id .= $v['shop_id'];
                        }else{
                            $shop_id .= $v['shop_id'].",";
                        }
                    }
                }
            }

            
            // var_dump($shop_id);exit;
            $where .= " and d.shop_id in (".$shop_id.")";
        }else{
            $shoplists = M("shop")->field("shop_id,shop_name")->where("status >= 0")->order("add_time desc")->select();
        }
        // echo $where;exit;
        // 自定义分页连表查询
        $page = new \Think\Page($Device->table('mk_device d,mk_shop s')->where($where)->count(),10);
        $list = $Device->table('mk_device d,mk_shop s')
                        ->field('d.*,s.shop_name,s.shop_address')
                        ->where($where)
                        ->order('d.add_time desc')
                        ->limit($page->firstRow.','.$page->listRows)
                        ->select();

        int_to_string($list);

        //设置分页主题
        $page->setConfig('theme','%FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END% %HEADER%');
        $p =$page->show();
        $this->assign('_page', $p? $p: '');
        // 记录当前列表页的cookie
        Cookie('__forward__',$_SERVER['REQUEST_URI']);
        // var_dump($list);exit;
        $this->assign('list', $list);
        $this->assign('shoplists', $shoplists);
        $this->meta_title = '设备列表';

        $this->display();
    }

    /**
     * 修改昵称初始化
     * @author huajie <banhuajie@163.com>
     */
    public function updateNickname(){
        $nickname = M('Member')->getFieldByUid(UID, 'nickname');
        $this->assign('nickname', $nickname);
        $this->meta_title = '修改昵称';
        $this->display();
    }

    /**
     * 修改昵称提交
     * @author huajie <banhuajie@163.com>
     */
    public function submitNickname(){
        //获取参数
        $nickname = I('post.nickname');
        $password = I('post.password');
        empty($nickname) && $this->error('请输入昵称');
        empty($password) && $this->error('请输入密码');

        //密码验证
        $User   =   new UserApi();
        $uid    =   $User->login(UID, $password, 4);
        ($uid == -2) && $this->error('密码不正确');

        $Member =   D('Member');
        $data   =   $Member->create(array('nickname'=>$nickname));
        if(!$data){
            $this->error($Member->getError());
        }

        $res = $Member->where(array('uid'=>$uid))->save($data);

        if($res){
            $user               =   session('user_auth');
            $user['username']   =   $data['nickname'];
            session('user_auth', $user);
            session('user_auth_sign', data_auth_sign($user));
            $this->success('修改昵称成功！');
        }else{
            $this->error('修改昵称失败！');
        }
    }

    /**
     * 修改密码初始化
     * @author huajie <banhuajie@163.com>
     */
    public function updatePassword(){
        $this->meta_title = '修改密码';
        $this->display();
    }

    /**
     * 修改密码提交
     * @author huajie <banhuajie@163.com>
     */
    public function submitPassword(){
        //获取参数
        $password   =   I('post.old');
        empty($password) && $this->error('请输入原密码');
        $data['password'] = I('post.password');
        empty($data['password']) && $this->error('请输入新密码');
        $repassword = I('post.repassword');
        empty($repassword) && $this->error('请输入确认密码');

        if($data['password'] !== $repassword){
            $this->error('您输入的新密码与确认密码不一致');
        }

        $Api    =   new UserApi();
        $res    =   $Api->updateInfo(UID, $password, $data);
        if($res['status']){
            $this->success('修改密码成功！');
        }else{
            $this->error($res['info']);
        }
    }

    /**
     * 用户行为列表
     * @author huajie <banhuajie@163.com>
     */
    public function action(){
        //获取列表数据
        $Action =   M('Action')->where(array('status'=>array('gt',-1)));
        $list   =   $this->lists($Action);
        int_to_string($list);
        // 记录当前列表页的cookie
        Cookie('__forward__',$_SERVER['REQUEST_URI']);

        $this->assign('_list', $list);
        $this->meta_title = '用户行为';
        $this->display();
    }

    /**
     * 新增行为
     * @author huajie <banhuajie@163.com>
     */
    public function addAction(){
        $this->meta_title = '新增行为';
        $this->assign('data',null);
        $this->display('editaction');
    }

    /**
     * 编辑行为
     * @author huajie <banhuajie@163.com>
     */
    public function editAction(){
        $id = I('get.id');
        empty($id) && $this->error('参数不能为空！');
        $data = M('Action')->field(true)->find($id);

        $this->assign('data',$data);
        $this->meta_title = '编辑行为';
        $this->display();
    }

    /**
     * 更新行为
     * @author huajie <banhuajie@163.com>
     */
    public function saveAction(){
        $res = D('Action')->update();
        if(!$res){
            $this->error(D('Action')->getError());
        }else{
            $this->success($res['id']?'更新成功！':'新增成功！', Cookie('__forward__'));
        }
    }

    /**
     * 设备状态状态修改
     * @author 朱亚杰 <zhuyajie@topthink.net>
     */
    public function changeStatus($method=null){
        $id = array_unique((array)I('id',0));
        // if( in_array(C('USER_ADMINISTRATOR'), $id)){
        //     $this->error("不允许对超级管理员执行该操作!");
        // }
        // var_dump($id);exit; 
        $id = is_array($id) ? implode(',',$id) : $id;
        if ( empty($id) ) {
            $this->error('请选择要操作的数据!');
        }
        $map['id'] =   array('in',$id);
        switch ( strtolower($method) ){
            case 'forbiddevice':
                $this->forbid('Device', $map );
                break;
            case 'resumedevice':
                // var_dump($map);exit; 
                $this->resume('Device', $map );
                break;
            case 'deletedevice':
                $this->delete('Device', $map );
                break;
            default:
                $this->error('参数非法');
        }
    }

    public function qrcode($url,$device_id){
        Vendor('phpqrcode.phpqrcode');
        //生成二维码图片
        $object = new \QRcode();
        $url=$url;//网址或者是文本内容
        $level=3;
        $size=4;
        $errorCorrectionLevel =intval($level) ;//容错级别
        $matrixPointSize = intval($size);//生成图片大小
        $object->png($url, "./Uploads/qr/".$device_id.".png", $errorCorrectionLevel, $matrixPointSize, 2);
    }

    public function add(){
        if(IS_POST){
            $_POST['add_time'] = time();
            /* 调用注册接口注册用户 */
            $isempty = !empty($_POST['device_name'])&&!empty($_POST['device_id'])&&!empty($_POST['shop_id'])&&!empty($_POST['lock_id']);

            if (!$isempty) {
                $this->error("所有项目本能为空！请检查 ");
            }

            $device   =   D("device");
            // 先检查该设备是否已经存在
            $device_id = I("device_id");
            // 二维码生成标志
            $_POST['device_qr'] = time();
            $isset = $device->where("device_id='".$device_id."' and status >=0")->find();
            if (!$isset) {
                // 在此调用设备二维码生成方法
                // 定义二维码解析地址
                $url = "http://dlwfd.cc/index.php?s=/Admin/Buyapi/index/device_id/".$device_id."/lock_num/".$_POST['lock_num'];
                $this->qrcode($url,$device_id);
                // $uid    =   $User->register($username, $password, $email);
                 $device_id = $device->field("device_name,device_qr,shop_id,device_id,lock_id,lock_num")->add($_POST);
                 $grouplock = M("grouplocks");
                 $addgrouplock = $grouplock->field("lock_id,lock_num")->add($_POST);
                if(0 < $device_id&&$addgrouplock>0){ //注册成功
                    $this->success('设备添加成功！',U('index'));
                } else { //注册失败，显示错误信息
                    $this->error("设备添加失败 ");
                }
            }else{
                $this->error("该设备已经存在！ ");
            }
           
        } else {
            //通过该用户查找本加盟商下的所有店铺
            $uid = session("user_auth")['uid'];

            // 取得在超级管理员组下的所有管理员
            $auth_group_access = M("auth_group_access");
            $auth_group_access_group = $auth_group_access->where("group_id = 1")->select();

            foreach ($auth_group_access_group as $k => $v) {
                
                $super[] = $v['uid'];
            }

            // 如果不是超级管理员,并且不是配置的超管，则显示本加盟商下面的所有管理员
            if(C('USER_ADMINISTRATOR') != $uid&&!(in_array($uid, $super))){

                // 如果是店铺管理员，则只查询出当前店铺
                $userinfo = M("ucenter_member")->where("id = ".$uid)->find();
                // var_dump($userinfo);exit;
                if($userinfo['shop_id']>0){
                    $this->assign("is_hidden",1);
                    $shoplists = M("shop")->where("shop_id = ".$userinfo['shop_id']." and status>=0")->select();
                    // var_dump($shoplists);exit;
                }else{
                    $business_id = M("member")->where("uid = ".$uid)->find()['business_id'];
                    $shoplists = M("shop")->where("business_id = ".$business_id." and status>=0")->select();
                } 
            }else{
                $shoplists = M("shop")->where("status>=0")->select();
            }

            

            // var_dump($shoplists);exit;
            $l = D("lock");
            $locklists = $this->lists($l);
            $g = D("grouplocks");
            $grouplocks = $g->select();
            $usedlocks_num[0]="0";
            // 获取第一个店铺的第一个锁板
            $firstshop_id = !empty($shoplists)?$shoplists[0]['shop_id']:"";
            if (!empty($locklists)) {
                foreach ($locklists as $k => $v) {
                    if($v['shop_id'] == $firstshop_id){
                        $firstlock_id = $v['lock_id'];
                        //查找该锁板下所对应的锁号是否占用
                        foreach($grouplocks as $k=>$v){
                            if($v['lock_id']==$firstlock_id){
                                $usedlocks_num[] = $v['lock_num']; 
                            }
                        }
                        break;
                    }
                }
            }

            $usedlocks_num = implode(",",$usedlocks_num);
            // echo $usedlocks_num;
            // exit;
            // var_dump($shoplists);
            $this->assign("shoplists",$shoplists);
            $this->assign("locklists",$locklists);
            $this->assign("usedlocks_num",$usedlocks_num);
            $this->assign("firstshop",$shoplists[0]);
            $this->assign("grouplocks",$grouplocks);
            $this->meta_title = '新增设备';
            $this->display();
        }
    }

    // '{1,2,3,4,5,6....}' 直到18
    // '{[
    //     {"smallboard_id":1,"isempty":1,"shop_id":8,"status":{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}},
    //     {"smallboard_id":2,"isempty":1,"shop_id":8,"status":{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}},
    //     {"smallboard_id":3,"isempty":1,"shop_id":8,"status":{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}},
    //     {"smallboard_id":4,"isempty":1,"shop_id":8,"status":{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}},
    //     {"smallboard_id":5,"isempty":1,"shop_id":8,"status":{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}},
    // ]}'

    //配置商品调用
    public function setgoodslists($shop_id=''){
        //获取所有商品列表
        if (empty($shop_id)) {
            echo '{"code":0,"msg":"店铺ID号为空！"}';
            return ;
        }
        if(!empty($_GET['page'])&&!empty($_GET['limit'])){
            $limit = I("limit");
            $page = I("page");
            $where = "shop_id = ".$shop_id;
            if(!empty($_GET['goods_name'])){
                $goods_name = I("goods_name");
                $where .= " and goods_name like '%".$goods_name."%'";
            }

            if (!empty($_GET['cate_id'])) {
                
                $cate_id = I('cate_id');
                // echo $cate_id;
                $catestr = $cate_id;
                $cate = M('cate');
                $cates = $cate->field("cate_id")->where("status >= 0 and cate_parent = ".$cate_id)->select();
                if($cates){
                    foreach ($cates as $k => $v) {
                        $catestr.=",".$v['cate_id'];
                    }
                }
                $where.=" and cate_id in (".$catestr.")";
            }
            $count = M("shopgoods")->where($where)->count();
            $goodslists = M("shopgoods")->where($where)->limit($limit)->page($page)->select();
        }else{
            $goodslists = $goods->where("status >=0")->select();
        }

        $data['code'] = 0;
        $data['msg'] = "";
        $data['count'] = $count;
        $data['data'] = $goodslists;

        echo json_encode($data);
        return ;
    }

    public function deviceedit(){
        
        // 调到货柜编辑界面
        if(IS_POST){
            $_POST['update_time'] = time();
            /* 调用注册接口注册用户 */
            $isempty = !empty($_POST['device_name'])&&!empty($_POST['shop_id'])&&!empty($_POST['lock_id'])&&!empty($_POST['device_id']);

            if (!$isempty) {
                $this->error("所有项目本能为空！请检查 ");
            }

            $device   =   D("device");
            // 先检查该设备是否已经存在
            $device_id = I("device_id");
            $goods_status = json_decode($_POST['goods_status']);
            
            // for ($i=1; $i < 33; $i++) { 
            //     $notempty[$i] = "1";
                
            //  }
            $notempty = "";
             for ($i=1; $i < 33; $i++) { 
                
                if ($i!=32) {
                    $notempty .= "0,";
                }else{
                    $notempty .= "0";
                }
            }


            for ($i=1; $i < 19; $i++) { 
                if (!empty($goods_status[$i])) {
                    $res_goods_status[$i] = array($goods_status[$i]=>$notempty);
                }else{
                    $res_goods_status[$i] = $goods_status[$i];
                }
            }
             $res_goods_status = json_encode($res_goods_status);

            $board = M("board");
            $res_goods_status = $board->where("board_id = ".$_POST['board_id'])->save(array("goods_status"=>$res_goods_status,"device_id"=>$device_id));
            // var_dump($res_goods_status);
            if (!$res_goods_status) {
                $this->error("编辑失败！3");
            }

            $isset = $device->where("device_id='".$device_id."' and lock_num = ".$_POST['lock_num'])->find();
            // var_dump($isset);
            $devicedata['device_name'] = I("device_name");
            $devicedata['device_qr'] = time();
            $devicedata['shop_id'] = I("shop_id");
            $devicedata['lock_id'] = I("lock_id");
            $devicedata['lock_num'] = I("lock_num");
            $devicedata['board_id'] = I("board_id");
            if (!$isset) {
                // 在此调用设备二维码生成方法
                // 定义二维码解析地址
                $url = "http://dlwfd.cc/index.php?s=/Admin/Buyapi/index/device_id/".$device_id."/lock_num/".$_POST['lock_num'];
                $this->qrcode($url,$device_id);
                $device_id = $device->where("device_id = ".$_POST['device_id'])->field("device_name,device_qr,shop_id,lock_id,lock_num,board_id")->save($devicedata);
                $grouplock = M("grouplocks");
                $lockdata['lock_num'] = I("lock_num");
                $addgrouplock = $grouplock->where("lock_id = ".$_POST['lock_id'])->save($lockdata);
                // var_dump($addgrouplock);
                if(0 < $device_id&&$addgrouplock>0){ //注册成功
                    $this->success('编辑成功',U("index"));
                } else { //注册失败，显示错误信息
                    $this->error("编辑失败！1");
                }
            }else{
                $device_id = $device->where("device_id = ".$_POST['device_id'])->field("device_name,device_qr,shop_id,device_id,lock_id,lock_num,board_id")->save($devicedata);
               if($device_id>0){ //注册成功
                    $this->success('编辑成功',U("index"));
                  
               } else { //注册失败，显示错误信息
                   $this->error('编辑失败！2');
               }
            }
           
        } else {
            //先获取当前货柜的配置参数
            $device = M("Device");
            $device_id = I("device_id");
            if(!empty($device_id)){
                $deviceinfo = $device->where("device_id='".$device_id."'")->find();
                
                if ($deviceinfo) {
                    $this->assign("deviceinfo",$deviceinfo);
                }else{
                    $this->error("意外错误!");exit;
                }
            }
        }

        // 做一个标志给前台，看是否可以显示具体配置
         // 取得在超级管理员组下的所有管理员
        $auth_group_access = M("auth_group_access");
        $auth_group_access_group = $auth_group_access->where("group_id = 1")->select();

        foreach ($auth_group_access_group as $k => $v) {
            
            $super[] = $v['uid'];
        }

        $super[] = 1;
        // var_dump($super);exit;
        $uid = session("user_auth")['uid'];
        // 
        if(in_array($uid, $super)){
            $this->assign("is_show",1);
        }else{
            $this->assign("is_show",0);
        }

        // 获取商品分类
        $c = D("Cate");
        $map['status']  =   array('egt',0);
        $catelists = $c->where($map)->order("cate_id asc")->select();
        $catelists = get_list($catelists);

        // var_dump($deviceinfo);
        $s = M("shop");
        $shoplists = $this->lists($s);
        // var_dump($shoplists);exit;
        $l = M("lock");
        $locklists = $this->lists($l);
        // 获取当前锁板下所有已被使用锁号
        $grouplock = M("grouplocks");
        $grouplocks = $grouplock->select();
        $usedlocks_num = $grouplock->field("lock_num")->where("lock_id = ".$deviceinfo['lock_id'])->select();
        // array(1) { [0]=> array(1) { ["lock_num"]=> string(1) "1" } }
        // 去掉所有已被使用的锁号
        $usedlocks_num[0] = [0];
        foreach ($usedlocks_num as $k => $v) {
            if($v['lock_num'] != $deviceinfo['lock_num']){
                $usedlocks_num[] = $v['lock_num'];
            }
        }

        // 获取该店铺下的所有锁板
        $thisshoplocks = $l->where("shop_id = ".$deviceinfo['shop_id'])->select();

        $usedlocks_num = implode(",",$usedlocks_num);

        //获取当前店铺下的所有货板
        $board = M("board");
        $boards = $board->where("shop_id = ".$deviceinfo['shop_id'])->select();
        
        // var_dump($boards);exit;
        
        if ($boards) {
            // 已配置货板，获取当前货板配置；没有配置货板，获取当前店铺的第一个货板
            foreach ($boards as $k => $v) {
                
                if ($deviceinfo['board_id'] == $v['board_id']) {
                    $goods_status = json_decode($boards[$k]['goods_status'],true);
                    if ($goods_status) {
                        $this->assign("jsgoods_status",$goods_status);
                        //获取对应的商品名称

                        for ($i=1; $i < 19; $i++) { 
                            
                            if(is_array($goods_status[$i])){
                                foreach ($goods_status[$i] as $k => $v) {
                                    $goods_name = M("shopgoods")->field("goods_name")->where("shopgoods_id = ".$k)->find();
                                    $goods_status[$i] = $goods_name['goods_name'];
                                }
                            }
                        }
                    }
                    // var_dump($goods_status);exit;
                    $this->assign("goods_status",$goods_status);   
                }
            }
        }

        // 获取所有的货板
        $boardlists = M("board")->field("board_id,shop_id")->where("status >=0")->select();


        $this->assign("shoplists",$shoplists);
        $this->assign("locklists",$locklists);
        $this->assign("boards",$boards);
        $this->assign("empty",$empty);
        $this->assign("grouplocks",$grouplocks);
        $this->assign("thisshoplocks",$thisshoplocks);
        $this->assign("usedlocks_num",$usedlocks_num);        
        $this->assign("catelists",$catelists);        
        $this->assign("boardlists",$boardlists);        
        $this->display();
    }

    //获取货板当前配置
    public function getboardset($board_id=''){
        

        if (empty($board_id)) {
            echo '{"status":0,"msg":"缺少货板ID号"}';
            return ;
        }

        $goods_status = M("board")->where("board_id =".$board_id)->find()['goods_status'];
        if (!empty($goods_status)) {
            $jsgoods_status = $goods_status;
            $goods_status = json_decode($goods_status,true);

            for ($i=1; $i < 19; $i++) { 
                            
                if(is_array($goods_status[$i])){
                    foreach ($goods_status[$i] as $k => $v) {
                        $goods_name = M("shopgoods")->field("goods_name")->where("shopgoods_id = ".$k)->find();
                        $goods_status[$i] = $goods_name['goods_name'];
                    }
                }
            }
            $goods_status = json_encode($goods_status);
            echo '{"status":1,"jsgoods_status":'.$jsgoods_status.',"goods_status":'.$goods_status.'}';
            // exit;
            return ;
        }else{
            echo '{"status":2,"msg":"暂无配置"}';
            return;
        }

    }

    public function addlock(){
        if(IS_POST){
            $_POST['add_time'] = time();
            /* 调用注册接口注册用户 */
            $isempty = !empty($_POST['shop_id'])&&!empty($_POST['lock_id']);

            if (!$isempty) {
                $this->error("所有项目本能为空！请检查 ");
            }

            $lock   =   D("lock");
            // $uid    =   $User->register($username, $password, $email);
             $lock_id = $lock->field("lock_id,shop_id")->add($_POST);
            if(0 < $lock_id){ //注册成功
                $this->success('锁板添加成功！',U('lock'));
            } else { //注册失败，显示错误信息
                $this->error("锁板添加失败 ");
            }
        } else {
            $uid = session("user_auth")['uid'];


             // 取得在超级管理员组下的所有管理员
            $auth_group_access = M("auth_group_access");
            $auth_group_access_group = $auth_group_access->where("group_id = 1")->select();

            foreach ($auth_group_access_group as $k => $v) {
                
                $super[] = $v['uid'];
            }

            // 如果不是超级管理员,并且不是配置的超管，则显示本加盟商下面的所有管理员
            if(C('USER_ADMINISTRATOR') != $uid&&!(in_array($uid, $super))){
                
                // 如果是店铺管理员，则只查询出当前店铺
                $userinfo = M("ucenter_member")->where("id = ".$uid)->find();
                // var_dump($userinfo);exit;
                if($userinfo['shop_id']>0){
                    $shoplists = M("shop")->where("shop_id = ".$userinfo['shop_id']." and status>=0")->select();
                }else{
                    $business_id = M("member")->where("uid = ".$uid)->find()['business_id'];
                    $shoplists = M("shop")->where("business_id = ".$business_id." and status>=0")->select();
                }
            }else{
                $shoplists = M("shop")->where("status>=0")->select();
            }
            // var_dump($shoplists);
            $this->assign("shoplists",$shoplists);
            $this->meta_title = '新增设备';
            $this->display();
        }
    }

    public function addcupboard(){
        if(IS_POST){
            $_POST['add_time'] = time();
            /* 调用注册接口注册用户 */
            $cupboard   =   D("cupboard");
            // $uid    =   $User->register($username, $password, $email);
             $cupboard_id = $cupboard->field("lock_id,cupboard_id")->add($_POST);
            if(0 < $cupboard_id){ //注册成功
                $this->success('货柜添加成功！',U('cupboard'));
            } else { //注册失败，显示错误信息
                $this->error("货柜添加失败 ");
            }
        } else {
            $m = D("shop");
            $shoplists = $this->lists($m);
            $l = D("lock");
            $locklists = $this->lists($l);

            // var_dump($shoplists);
            $this->assign("shoplists",$shoplists);
            $this->assign("locklists",$locklists);
            $this->assign("firstshop",$shoplists[0]);
            // var_dump($shoplists[0]);exit;
            $this->meta_title = '新增设备';
            $this->display();
        }
    }

    public function addboard($board_id='',$shop_id=''){
        if(IS_POST){
            $_POST['add_time'] = time();
            
            if (empty($board_id)) {
                $this->error("请填写货板ID号！");
            }
            
            if (empty($shop_id)) {
                $this->error("请选择店铺！");
            }

            $board   =   D("board");
            // 首先查找该货板是否已经存在
            $res = $board->where("board_id = ".$board_id)->find();
            if ($res) {
                $this->error("该货板ID号已经存在！");
            }

            $board->create($_POST);

            $id = $board->add($_POST);

            if(0 < $id){ 
                $this->success('货板添加成功！',U('board'));
            } else { 
                $this->error("货板添加失败 ");
            }
        } else {
            $uid = session("user_auth")['uid'];

             // 取得在超级管理员组下的所有管理员
            $auth_group_access = M("auth_group_access");
            $auth_group_access_group = $auth_group_access->where("group_id = 1")->select();

            foreach ($auth_group_access_group as $k => $v) {
                
                $super[] = $v['uid'];
            }

            // 如果不是超级管理员,并且不是配置的超管，则显示本加盟商下面的所有管理员
            if(C('USER_ADMINISTRATOR') != $uid&&!(in_array($uid, $super))){
                // 如果是店铺管理员，则只查询出当前店铺
                $userinfo = M("ucenter_member")->where("id = ".$uid)->find();
                // var_dump($userinfo);exit;
                if($userinfo['shop_id']>0){
                    $shoplists = M("shop")->where("shop_id = ".$userinfo['shop_id']." and status>=0")->select();
                }else{
                    // 本加盟商下的店铺
                    $business_id = M("member")->where("uid = ".$uid)->find()['business_id'];
                    $shoplists = M("shop")->where("business_id = ".$business_id." and status>=0")->select();
                }
                

            }else{
                $shoplists = M("shop")->where("status>=0")->select();

            }
            $this->assign("shoplists",$shoplists);
            $this->meta_title = '新增设备';
            $this->display();
        }
    }

    public function lock($shop_id=''){
        
        $Lock   =   D('lock');
        $where = 'l.shop_id = s.shop_id AND l.status >= 0';
        if (!empty($shop_id)) {
            
            $where.=" and s.shop_id = ".$shop_id;
        }
        if (!empty($_GET['lock_id'])) {
            
            $where.=" and l.lock_id like '%".I("lock_id")."%'";
        }

        $uid = session("user_auth")['uid'];
        // 取得在超级管理员组下的所有管理员
        $auth_group_access = M("auth_group_access");
        $auth_group_access_group = $auth_group_access->where("group_id = 1")->select();

        foreach ($auth_group_access_group as $k => $v) {
            
            $super[] = $v['uid'];
        }
        // 如果不是超级管理员，先去获取本加盟商下面的所有店铺
        if(C('USER_ADMINISTRATOR') != $uid&&!(in_array($uid, $super))){

            // 如果是店铺管理员，则只查询出当前店铺
            $userinfo = M("ucenter_member")->where("id = ".$uid)->find();
            // var_dump($userinfo);exit;
            if($userinfo['shop_id']>0){
                $shop_id = $userinfo['shop_id'];
                $this->assign("is_hidden",1);
            }else{
                $business_id = M("member")->where("status >=0 and uid = ".$uid)->find()['business_id'];
                $shoplists = M("shop")->field("shop_id,shop_name")->where("status >=0 and business_id = ".$business_id)->select();
                $shop_id = "";
                // 把所有的店铺id号放到一个一维数组里面
                if (!empty($shoplists)) {
                    foreach ($shoplists as $k => $v) {
                        if ($k==(count($shoplists)-1)) {
                            $shop_id .= $v['shop_id'];
                        }else{
                            $shop_id .= $v['shop_id'].",";
                        }
                    }
                }
            }

            $where .= " and l.shop_id in (".$shop_id.")";
        }else{
            $shoplists = M("shop")->where("status >=0")->select();
        }

        // 自定义分页连表查询
        $page = new \Think\Page($Lock->where($where)->count(),10);
        $list = $Lock->table('mk_lock l,mk_shop s')
                        ->field('l.*,s.shop_name,s.shop_address')
                        ->where($where)
                        ->order('l.add_time desc')
                        ->limit($page->firstRow.','.$page->listRows)
                        ->select();
        int_to_string($list);

        //设置分页主题
        $page->setConfig('theme','%FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END% %HEADER%');
        $p =$page->show();
        $this->assign('_page', $p? $p: '');
        // 记录当前列表页的cookie
        Cookie('__forward__',$_SERVER['REQUEST_URI']);
        // var_dump($list);exit;
        $this->assign('list', $list);
        $this->assign('shoplists', $shoplists);
        $this->meta_title = '锁板管理';

        $this->display();
    }


    function lockchangeStatus($method=null){
        $id = array_unique((array)I('id',0));
        // if( in_array(C('USER_ADMINISTRATOR'), $id)){
        //     $this->error("不允许对超级管理员执行该操作!");
        // }
        // var_dump($id);exit; 
        $id = is_array($id) ? implode(',',$id) : $id;
        if ( empty($id) ) {
            $this->error('请选择要操作的数据!');
        }
        $map['id'] =   array('in',$id);
        switch ( strtolower($method) ){
            case 'forbiddevice':
                $this->forbid('Lock', $map );
                break;
            case 'resumedevice':
                // var_dump($map);exit; 
                $this->resume('Lock', $map );
                break;
            case 'deletedevice':
                $this->delete('Lock', $map );
                break;
            default:
                $this->error('参数非法');
        }
    }

    public function cupboard(){
        
        $Cupboard   =   D('cupboard');
        $where = 'c.lock_id = l.lock_id AND c.status >= 0';
        if (!empty($_GET['cupboard_id'])) {
            
            $where.=" and c.cupboard_id like '%".I("cupboard_id")."%'";
        }
        if (!empty($_GET['lock_id'])) {
            
            $where.=" and l.lock_id =".I("lock_id");
        }


        // 自定义分页连表查询
        $page = new \Think\Page($Cupboard->where("status EGT 0")->count(),10);
        $list = $Cupboard->table('mk_lock l,mk_cupboard c')
                        ->field('c.*')
                        ->where($where)
                        ->order('c.add_time desc')
                        ->limit($page->firstRow.','.$page->listRows)
                        ->select();

        int_to_string($list);
        // var_dump($list);exit;

        $Lock = M("Lock");
        $locklists = $Lock->field("lock_id")->where("status >= 0")->order("add_time desc")->select();

        // var_dump($shoplists);exit();
        //设置分页主题
        $page->setConfig('theme','%FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END% %HEADER%');
        $p =$page->show();
        $this->assign('_page', $p? $p: '');
        // 记录当前列表页的cookie
        Cookie('__forward__',$_SERVER['REQUEST_URI']);
        // var_dump($list);exit;
        $this->assign('list', $list);
        $this->assign('locklists', $locklists);
        $this->meta_title = '锁板管理';

        $this->display();
    }

    function cupboardchangeStatus($method=null){
        $id = array_unique((array)I('id',0));
        // if( in_array(C('USER_ADMINISTRATOR'), $id)){
        //     $this->error("不允许对超级管理员执行该操作!");
        // }
        // var_dump($id);exit; 
        $id = is_array($id) ? implode(',',$id) : $id;
        if ( empty($id) ) {
            $this->error('请选择要操作的数据!');
        }
        $map['id'] =   array('in',$id);
        switch ( strtolower($method) ){
            case 'forbiddevice':
                $this->forbid('Cupboard', $map );
                break;
            case 'resumedevice':
                // var_dump($map);exit; 
                $this->resume('Cupboard', $map );
                break;
            case 'deletedevice':
                $this->delete('Cupboard', $map );
                break;
            default:
                $this->error('参数非法');
        }
    }

    public function board($shop_id=''){
        
        $Board   =   D('board');
        $where = 'b.status >= 0 and b.shop_id = s.shop_id';
        if (!empty($_GET['board_id'])) {
            
            $where.=" and b.board_id like '%".I("board_id")."%'";
        }
        if (!empty($shop_id)) {
            $where .= " and b.shop_id = ".$shop_id;
        }

        $uid = session("user_auth")['uid'];
        // 取得在超级管理员组下的所有管理员
        $auth_group_access = M("auth_group_access");
        $auth_group_access_group = $auth_group_access->where("group_id = 1")->select();

        foreach ($auth_group_access_group as $k => $v) {
            
            $super[] = $v['uid'];
        }
        // 如果不是超级管理员，先去获取本加盟商下面的所有店铺
        if(C('USER_ADMINISTRATOR') != $uid&&!(in_array($uid, $super))){

            // 如果是店铺管理员，则只查询出当前店铺
            $userinfo = M("ucenter_member")->where("id = ".$uid)->find();
            // var_dump($userinfo);exit;
            if($userinfo['shop_id']>0){
                $shop_id = $userinfo['shop_id'];
                $this->assign("is_hidden",1);
            }else{
                $business_id = M("member")->where("status >=0 and uid = ".$uid)->find()['business_id'];
                $shops = M("shop")->field("shop_id")->where("status >=0 and business_id = ".$business_id)->select();
                $shop_id = "";
                // 把所有的店铺id号放到一个一维数组里面
                if (!empty($shops)) {
                    foreach ($shops as $k => $v) {
                        if ($k==(count($shops)-1)) {
                            $shop_id .= $v['shop_id'];
                        }else{
                            $shop_id .= $v['shop_id'].",";
                        }
                    }
                }
            }

            
            //找到本加盟商下的所有店铺下的所有货板
            $boards = M("board")->field("board_id")->where("shop_id in (".$shop_id.")")->select();
            
            $board_id = "";
            // 把所有的店铺id号放到一个一维数组里面
            if (!empty($boards)) {
                foreach ($boards as $k => $v) {
                    if ($k==(count($boards)-1)) {
                        $board_id .= $v['board_id'];
                    }else{
                        $board_id .= $v['board_id'].",";
                    }
                }
            }

            $where .=" and b.board_id in (".$board_id.")";

        }else{
            $shops = M("shop")->where("status >=0")->select();
        }
        // var_dump($where);
        // 自定义分页连表查询
        $page = new \Think\Page($Board->table("mk_board as b,mk_shop as s")->where($where)->count(),10);
        $list = $Board->table("mk_board as b,mk_shop as s")
                        ->where($where)
                        ->order('b.add_time desc')
                        ->limit($page->firstRow.','.$page->listRows)
                        ->select();

        int_to_string($list);
        // var_dump($list);exit;
        //设置分页主题
        $page->setConfig('theme','%FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END% %HEADER%');
        $p =$page->show();
        $this->assign('_page', $p? $p: '');
        // 记录当前列表页的cookie
        Cookie('__forward__',$_SERVER['REQUEST_URI']);
        $this->assign('list', $list);
        $this->assign('shops', $shops);
        $this->meta_title = '锁板管理';

        $this->display();
    }

    public function editboard($id='',$shop_id=''){
        


        if (empty($id)) {
            $this->error("参数错误！");
        }
        if (empty($shop_id)) {
            $this->error("参数错误！");
        }

        if (IS_POST) {
            
            $res = M("board")->where("id = ".$id)->save(array("shop_id"=>$shop_id));
            if ($res) {
                $this->success("编辑成功",U("board"));
            }else{
                $this->error("编辑失败！");
            }
        }

        $boardinfo = M("board")->where("id = ".$id." and shop_id =".$shop_id)->find();

        if (empty($boardinfo)) {
            $this->error("该货板不存在！");
        }

        $uid = session("user_auth")['uid'];
        // 如果不是超级管理员，先去获取本加盟商下面的所有店铺
        if(C('USER_ADMINISTRATOR') != $uid){

            $business_id = M("member")->where("status >=0 and uid = ".$uid)->find()['business_id'];
            $shops = M("shop")->field("shop_id")->where("status >=0 and business_id = ".$business_id)->select();
        }else{
            $shops = M("shop")->where("status >=0")->select();
        }

        
        $this->assign("shops",$shops);
        $this->assign("shop_id",$shop_id);
        $this->assign("boardinfo",$boardinfo);
        $this->display();
    }

     function boardchangeStatus($method=null){
        $id = array_unique((array)I('id',0));
        // if( in_array(C('USER_ADMINISTRATOR'), $id)){
        //     $this->error("不允许对超级管理员执行该操作!");
        // }
        // var_dump($id);exit; 
        $id = is_array($id) ? implode(',',$id) : $id;
        if ( empty($id) ) {
            $this->error('请选择要操作的数据!');
        }
        $map['id'] =   array('in',$id);
        switch ( strtolower($method) ){
            case 'forbiddevice':
                $this->forbid('Board', $map );
                break;
            case 'resumedevice':
                // var_dump($map);exit; 
                $this->resume('Board', $map );
                break;
            case 'deletedevice':
                $this->delete('Board', $map );
                break;
            default:
                $this->error('参数非法');
        }
    }


    /**
     * 获取用户注册错误信息
     * @param  integer $code 错误编码
     * @return string        错误信息
     */
    private function showRegError($code = 0){
        switch ($code) {
            case -1:  $error = '用户名长度必须在16个字符以内！'; break;
            case -2:  $error = '用户名被禁止注册！'; break;
            case -3:  $error = '用户名被占用！'; break;
            case -4:  $error = '密码长度必须在6-30个字符之间！'; break;
            case -5:  $error = '邮箱格式不正确！'; break;
            case -6:  $error = '邮箱长度必须在1-32个字符之间！'; break;
            case -7:  $error = '邮箱被禁止注册！'; break;
            case -8:  $error = '邮箱被占用！'; break;
            case -9:  $error = '手机格式不正确！'; break;
            case -10: $error = '手机被禁止注册！'; break;
            case -11: $error = '手机号被占用！'; break;
            default:  $error = '未知错误';
        }
        return $error;
    }

}
