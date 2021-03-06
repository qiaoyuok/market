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
class ShopController extends AdminController {

   
    public function index($shop_name = ''){

        $shop   =   D('shop');
        $where = "s.status >=0 and s.business_id = b.business_id";

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
                $where .= " and s.shop_id = ".$userinfo['shop_id'];
            }else{
                $business_id = M("member")->where("status >=0 and uid = ".$uid)->find()['business_id'];
                $where .=" and s.business_id = ".$business_id;
            }
        }

        if (!empty($shop_name)) {
            $where .= " and s.shop_name like '%".$shop_name."%'";
        }

        // echo $where;exit;
        // 自定义分页连表查询
        $page = new \Think\Page($shop->table('mk_shop as s,mk_business as b')->where($where)->count(),10);
        $list = $shop->table('mk_shop as s,mk_business as b')
                        ->field('s.*,b.business_name,b.business_address,b.business_tel')
                        ->where($where)
                        ->order('s.add_time desc')
                        ->limit($page->firstRow.','.$page->listRows)
                        ->select();
        int_to_string($list);
        $page->setConfig('theme','%FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END% %HEADER%');
        $p =$page->show();
        $this->assign('_page', $p? $p: '');
        // 记录当前列表页的cookie
        // var_dump($list);exit;
        $uid = session("user_auth")['uid'];

        Cookie('__forward__',$_SERVER['REQUEST_URI']);
        $this->assign('list', $list);
        $this->assign('uid', $uid);
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
        // var_dump($id);
        // if( in_array(C('USER_ADMINISTRATOR'), $id)){
        //     $this->error("不允许对超级管理员执行该操作!");
        // }
        // var_dump($id);exit;
        $id = is_array($id) ? implode(',',$id) : $id;
        if ( empty($id) ) {
            $this->error('请选择要操作的数据!');
        }
        $map['shop_id'] =   array('in',$id);
        // var_dump($map);
        switch ( strtolower($method) ){
            case 'deleteshop':
                $d = D("Device");
                $map['status'] = array("EGT",0);
                $lists = $this->lists($d,$map);
                // var_dump($list)
                if (0 < $lists) {
                    $this->error("请先删除该店铺下的设备！");
                    return ; 
                }
                $this->delete('Shop', $map );
                break;
            default:
                $this->error('参数非法');
        }
    }

    public function add($business_id='',$shop_name=''){

        if(IS_POST){
            if (empty($business_id)) {
               $this->error("请选择加盟商！");
            }

            if (empty($shop_name)) {
               $this->error("请填写店铺名称！");
            }

            $_POST['add_time'] = time();
            $_POST['uid'] = session("user_auth")['uid'];
            /* 调用注册接口注册用户 */
            $shop   =   D("shop");
            // $uid    =   $User->register($username, $password, $email);
             $shop = $shop->field("shop_name,shop_address,add_time,uid,$business_id")->add($_POST);
            if(0 < $shop){ //注册成功
                $this->success('店面添加成功！',U('index'));
            } else { //注册失败，显示错误信息
                $this->error("店面添加失败 ");
            }
        } else {
            

            // 获取公司列表 定义：出超管外只显示本公司，超管可以指定任意公司
            $uid = session("user_auth")['uid'];
            $business = M("business");

            if(C('USER_ADMINISTRATOR') == $uid){

                $businesslists = $business->where("status >=0 and business_id>1")->select();
                $this->assign("businesslists",$businesslists);
            }else{

                // 普通用户，则只需获取本单位信息
                $businessinfo = $business->table("mk_business as b,mk_ucenter_member as u")->where("u.id = ".$uid." and b.business_id = u.business_id")->find();
                $this->assign("businessinfo",$businessinfo);
            }

            $this->assign("uid",$uid);


            $this->meta_title = '新增店面';
            $this->display();
        }
    }

    public function edit($business_id='',$shop_name='',$shop_id=''){

        if (empty($shop_id)) {
           
           $this->error("参数错误！");;
        }

        // var_dump($_POST);

        if(IS_POST){
            if (empty($business_id)) {
               $this->error("请选择加盟商！");
            }

            if (empty($shop_name)) {
               $this->error("请填写店铺名称！");
            }

            $_POST['update_time'] = time();
            $_POST['uid'] = session("user_auth")['uid'];
            /* 调用注册接口注册用户 */
            $shop   =   D("shop");
            // $uid    =   $User->register($username, $password, $email);
             $shop = $shop->where("shop_id = ".$shop_id)->save($_POST);
            if(0 < $shop){ //注册成功
                $this->success('编辑店面成功！',U('index'));
            } else { //注册失败，显示错误信息
                $this->error("编辑店面失败 ");
            }
        } else {
            

            // 获取公司列表 定义：出超管外只显示本公司，超管可以指定任意公司
            $uid = session("user_auth")['uid'];
            $business = M("business");

            if(C('USER_ADMINISTRATOR') == $uid){

                $businesslists = $business->where("status >=0 and business_id>1")->select();
                $this->assign("businesslists",$businesslists);
            }else{

                // 普通用户，则只需获取本单位信息
                $businessinfo = $business->table("mk_business as b,mk_ucenter_member as u")->where("u.id = ".$uid." and b.business_id = u.business_id")->find();
                $this->assign("businessinfo",$businessinfo);
            }

            // 获取当前店铺信息
            $shopinfo = M("shop")->where("status >=0 and shop_id = ".$shop_id)->find();
            // var_dump($shopinfo);exit;
            $this->assign("shopinfo",$shopinfo);
            $this->assign("uid",$uid);


            $this->meta_title = '新增店面';
            $this->display();
        }
    }


    public function shopgoods($shop_id='',$cate_id='',$goods_name=''){
        

        if (empty($shop_id)) {
            
            $this->error("参数出错！");
        }
        $where = "sg.shop_id = ".$shop_id;

        if (!empty($cate_id)) {
            
            $where .= " and cate_id = ".$cate_id;
        }

        if (!empty($goods_name)||$goods_name==0) {
            
            $where .= " and g.goods_name like '%".$goods_name."%'";
        }

        $shopgoods = M("shopgoods");

         // 自定义分页连表查询
        $page = new \Think\Page($shopgoods->table('mk_goods as g')->join("left join mk_shopgoods as sg on g.goods_id = sg.goods_id")->join("left join mk_frdgoods as fg on fg.shopgoods_id = sg.shopgoods_id")->where($where)->count(),10);
        $shopgoodslists = $shopgoods->table('mk_goods as g')
                        ->join("left join mk_shopgoods as sg on g.goods_id = sg.goods_id")
                        ->join("left join (SELECT *,count(*) frd_stock from mk_frdgoods where status = 1 GROUP BY shopgoods_id) fg  on fg.shopgoods_id = sg.shopgoods_id")
                        ->field('g.goods_name,sg.cost,sg.cell_price,sg.stock,fg.cost frd_cost,fg.cell_price frd_cell_price,fg.frd_stock,sg.shopgoods_id')
                        ->where($where)
                        ->limit($page->firstRow.','.$page->listRows)
                        ->select();
        $page->setConfig('theme','%FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END% %HEADER%');
        $p =$page->show();
        
        // var_dump($shopgoodslists);exit;
        Cookie('__forward__',$_SERVER['REQUEST_URI']);

        // 获取该店铺信息
        $shopinfo = M("shop")->where("shop_id = ".$shop_id)->find();
        // $shopgoodslists = M("shopgoods")->where($where)->select();
        // 获取商品分类
        $c = D("Cate");
        $map['status']  =   array('egt',0);
        $catelists = $c->where($map)->order("cate_id asc")->select();
        $catelists = get_list($catelists);

        $this->assign("catelists",$catelists);   
        $this->assign("shopgoodslists",$shopgoodslists);
        $this->assign("shopinfo",$shopinfo);
        // $this->assign('_page', $p? $p: '');
        $this->display();
    }


    public function addshopgoods($shop_id='',$goods_id='',$goods_name='',$cost='',$cell_price='',$cate_id=''){
        
        if (empty($shop_id)) {
            $this->error("参数错误！");
        }
        if (IS_POST) {
            
            if (empty($goods_id)||empty($goods_name)||empty($cost)||empty($cell_price)||empty($cate_id)) {
                $this->error("所有参数不能为空！");
            }
            $_POST['add_time'] = time();
            $shopgoods = M("shopgoods");
            $shopgoods->create($_POST);
            $shopgoods_id = $shopgoods->add($_POST);
            if ($shopgoods_id>0) {
                $this->success("添加成功",U("shopgoods?shop_id=".$shop_id));
            }else{
                $this->error("添加失败！");
            }

        }
        // 获取商品分类
        $c = D("Cate");
        $map['status']  =   array('egt',0);
        $catelists = $c->where($map)->order("cate_id asc")->select();
        $catelists = get_list($catelists);
        $this->assign("catelists",$catelists);   
        $this->assign("shop_id",$shop_id);     
        $this->display();
    }

    public function shopgoodsedit($shop_id='',$shopgoods_id='',$goods_id='',$goods_name='',$cost='',$cell_price=''){
        
        if (empty($shopgoods_id)) {
            
            $this->error("参数错误！");
        }

        if (IS_POST) {

            if (empty($shop_id)||empty($goods_id)||empty($goods_name)||empty($cost)||empty($cell_price)) {
                $this->error("所有参数不能为空！");
            }
            $_POST['update_time'] = time();
            M("shopgoods")->create($_POST);
            $res = M("shopgoods")->where("shopgoods_id = ".$shopgoods_id)->save($_POST);
            if ($res) {
                $this->success("编辑成功",U("shopgoods?shop_id=".$shop_id));
            }else{
                $this->error("编辑失败！");
            }
        }

        // 获取当前店铺当前商品的信息
        $shopgoodsinfo = M("shopgoods")->where("shopgoods_id = ".$shopgoods_id)->find();

        $this->assign("shopgoodsinfo",$shopgoodsinfo);
        $this->display();


    }

    public function shopgoodsdelete($shopgoods_id='',$shop_id=''){
        
        if (empty($shopgoods_id)||empty($shop_id)) {
            
            $this->error("请选择要操作的数据！");
        }

        $res = M("shopgoods")->where("shopgoods_id = ".$shopgoods_id)->delete();
        if ($res) {
            $this->success("删除成功",U("shopgoods?shop_id=".$shop_id));
        }else{
            $this->error("删除失败");
        }


    }
     //配置商品调用
    public function setgoodslists($shop_id=''){
        // var_dump($_GET);return ;
        //获取所有商品列表
        $goods  = M("Goods");
        // 首先获取当前店铺已配置商品，不会再在添加商品的时候显示
        if (empty($shop_id)) {
            echo '{"code":1,"data":"店铺ID号为空"}';return ;
        }
        // 获取当前店铺所有已配置商品
        $shopgoodssetedlists = M("shopgoods")->field("goods_id")->where("shop_id = ".$shop_id)->select();
        $goods_id = "";
        if ($shopgoodssetedlists) {
            foreach ($shopgoodssetedlists as $k => $v) {
            
                $goods_id .= ",".$v['goods_id'];
            }
        }
        $goods_id = "(0".$goods_id.")";
        $where = "goods_id not in ".$goods_id." and status>=0";
        $count = $goods->where($where)->count();     

        if(!empty($_GET['page'])&&!empty($_GET['limit'])){
            $limit = I("limit");
            $page = I("page");
            
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
            $count = $goods->where($where)->count();
            $goodslists = $goods->where($where)->limit($limit)->page($page)->select();
        }else{
            $goodslists = $goods->where($where)->select();
            // var_dump($goodslists);exit; 
        }
        if($goodslists){
            $data['code'] = 0;
            $data['msg'] = "";
            $data['count'] = $count;
            $data['data'] = $goodslists;
        }
        echo json_encode($data);
        return ;
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
