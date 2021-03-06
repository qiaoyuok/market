<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------

namespace Admin\Controller;

/**
 * 后台设备控制器
 * 
 */
class FinanceController extends AdminController {

   
    public function index($p=''){
        
        $order   =   D('order');
        // 自定义分页连表查询
        // 默认条件

        $where = "o.status = 1 and f.order_id = o.order_id and sg.shopgoods_id = f.shopgoods_id  and sg.shop_id =s.shop_id and b.business_id = s.business_id and o.uid = u.uid";
        $table = "mk_order o, mk_finance f, mk_shopgoods sg,mk_shop s,mk_business b,mk_user u";
        $uid = session("user_auth")['uid'];

         // 取得在超级管理员组下的所有管理员
        $auth_group_access = M("auth_group_access");
        $auth_group_access_group = $auth_group_access->where("group_id = 1")->select();

        foreach ($auth_group_access_group as $k => $v) {
            
            $super[] = $v['uid'];
        }

        $super[] = 1;

        if(in_array($uid, $super)){
            $this->assign("is_show",1);
        }else{

            $this->assign("is_show",0);
        }

        // 如果不是超级管理员，先去获取本加盟商下面的所有店铺
        if(C('USER_ADMINISTRATOR') != $uid&&!(in_array($uid, $super))){

            // 如果是店铺管理员，则只查询出当前店铺
            $userinfo = M("ucenter_member")->where("id = ".$uid)->find();
            // var_dump($userinfo);exit;
            if($userinfo['shop_id']>0){
                $where .= " and s.shop_id = ".$userinfo['shop_id'];
            }else{
                $business_id = M("member")->where("status >=0 and uid = ".$uid)->find()['business_id'];
                $where .= " and b.business_id = ".$business_id;
            }

        }else{
            if (!empty($_GET["business_name"])) {
                $where.=" AND b.business_name like '%".I("business_name")."%'";
            }
        }

        if (!empty($_GET["name"])) {
            $where.=" AND u.name like '%".I("name")."%'";
        }

        if (!empty($_GET["device_id"])) {
            $where.=" AND o.device_id like '%".I("device_id")."%'";
        }

        if (!empty($_GET["time-start"])) {
            $time_start = I("time-start")." 00:00:00";
            $where.=" AND o.update_time >=".strtotime($time_start);
        }

        if (!empty($_GET["time-end"])) {
            $time_end = I("time-end")." 23:59:59";
            $where.=" AND o.update_time <=".strtotime($time_end);
        }

        if (!empty($_GET["shop_name"])) {
            $where.=" AND s.shop_name like '%".I("shop_name")."%'";
        }

        // var_dump($where);exit;
        // var_dump($_GET);exit;
        $p = !empty($p)?($p-1)*10:0;
        // var_dump($p);exit;
        $page = new \Think\Page($order->table('mk_goods g')->where("g.status >=0")->count(),10);
        // var_dump($page);
        $list = $order->query("SELECT g.goods_name, a.small_cell_price, a.small_cost, a.small_num,a.small_profit FROM mk_goods AS g LEFT JOIN ( SELECT SUM(f.cost * f.num) AS small_cost, SUM(f.cell_price * f.num) AS small_cell_price, SUM(f.num) AS small_num,SUM(f.cell_price* f.num-f.cost* f.num) as small_profit, sg.goods_id FROM $table WHERE ( $where ) GROUP BY sg.goods_id) AS a ON g.goods_id = a.goods_id limit $p,10");
        // echo "SELECT g.goods_name, a.small_cell_price, a.small_cost, a.small_num,a.small_profit FROM mk_goods AS g LEFT JOIN ( SELECT SUM(f.cost * f.num) AS small_cost, SUM(f.cell_price * f.num) AS small_cell_price, SUM(f.num) AS small_num,SUM(f.cell_price* f.num-f.cost* f.num) as small_profit, sg.goods_id FROM $table WHERE ( $where ) GROUP BY sg.goods_id) AS a ON g.goods_id = a.goods_id limit $p,10";exit;
        // var_dump($list);exit;
        int_to_string($list);
        // 统计；总销售额；总成本，总盈利,总数量
        $allprofit = 0;
        $allcost = 0;
        $allsalesamount = 0;
        $allnum = 0;
        foreach ($list as $k => $v) {
            $allsalesamount += $v['small_cell_price'];
            $allcost += $v['small_cost'];
            $allnum += $v['small_num'];
        }
        
        $allprofit = $allsalesamount - $allcost;

        // var_dump($list);exit;
        //设置分页主题
        $page->setConfig('theme','%FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END% %HEADER%');
        $p =$page->show();
        $this->assign('_page', $p? $p: '');
        // 记录当前列表页的cookie
        Cookie('__forward__',$_SERVER['REQUEST_URI']);

        //获取设备列表共搜索选择
        // var_dump($list);exit;
        $this->assign('list', $list);
        $this->meta_title = '设备列表';
        $this->assign("uid",$uid);
        $this->assign("allcost",$allcost);
        $this->assign("allsalesamount",$allsalesamount);
        $this->assign("allprofit",$allprofit);
        $this->assign("allnum",$allnum);

        $this->display();
    }


    //设备搜索
    public function devicelist($device_id=''){
        
        $where = "status >=0";
        $uid = session("user_auth")['uid'];

        // 如果不是超级管理员，先去获取本加盟商下面的所有店铺
        if(C('USER_ADMINISTRATOR') != $uid){

            $business_id = M("member")->where("status >=0 and uid = ".$uid)->find()['business_id'];
            $shoplists = M("shop")->field("shop_id,shop_name")->where("status >=0 and business_id = ".$business_id)->select();
            $shop_id = "0";
            // 把所有的店铺id号放到一个一维数组里面
            if (!empty($shoplists)) {
                foreach ($shoplists as $k => $v) {
                    
                    $shop_id .= ",".$v['shop_id'];
                }
            }

            $where .= " and shop_id in (".$shop_id.")";

        }

        $page = isset($_GET['page'])?$_GET['page']:1;
        if (!empty($device_id)||$device_id == 0) {
            $where .= " and device_id like '%".$_GET['device_id']."%'";
        }
        // 每页记录数
        $limit = 6;
        $pagenow = ($page-1)*$limit;

        $device = M("device");
        // 总共记录数
        $device_count = $device->where($where)->count();
        // 总页数
        $pages = ceil($device_count/6);
        
        // 获取该页数据
        $device_list = $device->where($where)->limit($pagenow,$limit)->select();

        if ($device_list) {
            
            echo json_encode(array("data"=>$device_list,"code"=>0,"count"=>$device_count)); 
            return;
        }else{
            echo json_encode(array("data"=>null,"code"=>0,"count"=>0));
            return ;
        }
    }

    //加盟商搜索
    public function businesslist($business_name=''){
        
        $where = "status >=0 and business_id>1";

        $page = isset($_GET['page'])?$_GET['page']:1;
        if (!empty($business_name)||$business_name == 0) {
            $where .= " and business_name like '%".$business_name."%'";
        }
        // 每页记录数
        $limit = 6;
        $pagenow = ($page-1)*$limit;

        $business = M("business");
        // 总共记录数
        $business_count = $business->where($where)->count();
        // 总页数
        $pages = ceil($business_count/6);
        
        // 获取该页数据
        $business_list = $business->where($where)->limit($pagenow,$limit)->select();

        if ($business_list) {
            
            echo json_encode(array("data"=>$business_list,"code"=>0,"count"=>$business_count)); 
            return;
        }else{
            echo json_encode(array("data"=>null,"code"=>0,"count"=>0));
            return ;
        }
    }

    //店铺搜索
    public function shoplist($shop_name=''){
        // var_dump($shop_name);
        $where = "status >=0";

        $page = isset($_GET['page'])?$_GET['page']:1;
        if (!empty($shop_name)||$shop_name == 0) {
            $where .= " and shop_name like '%".$shop_name."%'";
        }
        // 每页记录数
        $limit = 6;
        $pagenow = ($page-1)*$limit;
        $uid = session("user_auth")['uid'];
        // 超级管理员可以获取全部的店铺、普通管理员只能获取本加盟商下的店铺
        // 如果不是超级管理员，先去获取本加盟商下面的所有店铺
        if(C('USER_ADMINISTRATOR') != $uid){

            $business_id = M("member")->where("status >=0 and uid = ".$uid)->find()['business_id'];
            $shoplists = M("shop")->field("shop_id,shop_name")->where("status >=0 and business_id = ".$business_id)->select();
            $shop_id = "0";
            // 把所有的店铺id号放到一个一维数组里面
            if (!empty($shoplists)) {
                foreach ($shoplists as $k => $v) {
                    
                    $shop_id .= ",".$v['shop_id'];
                }
            }

            $where .= " and shop_id in (".$shop_id.")";

        }
        $shop = M("shop");
        // 总共记录数
        $shop_count = $shop->where($where)->count();
        // 总页数
        $pages = ceil($business_count/6);
        
        // 获取该页数据
        $shop_list = $shop->where($where)->limit($pagenow,$limit)->select();

        if ($shop_list) {
            
            echo json_encode(array("data"=>$shop_list,"code"=>0,"count"=>$shop_count)); 
            return;
        }else{
            echo json_encode(array("data"=>null,"code"=>0,"count"=>0));
            return ;
        }
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

    public function add($device_name = '', $device_qr = '', $shop_id = '',$device_id=""){
        if(IS_POST){
            $_POST['add_time'] = time();
            /* 调用注册接口注册用户 */
            $device   =   D("device");
            // $uid    =   $User->register($username, $password, $email);
             $device_id = $device->field("device_name,device_qr,shop_id,device_id")->add($_POST);
            if(0 < $device_id){ //注册成功
                $this->success('设备添加成功！',U('index'));
            } else { //注册失败，显示错误信息
                $this->error("设备添加失败 ");
            }
        } else {
            $m = D("shop");
            $shoplists = $this->lists($m);
            // var_dump($shoplists);
            $this->assign("shoplists",$shoplists);
            $this->meta_title = '新增设备';
            $this->display();
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
