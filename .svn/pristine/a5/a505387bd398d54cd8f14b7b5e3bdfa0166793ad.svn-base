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
class GoodsController extends AdminController {

   
    public function index(){
        $Goods   =   D('goods');
        $where = 'g.cate_id = c.cate_id and g.status>=0';
        if (!empty($_GET['cate_id'])) {
            $cate_id = $_GET['cate_id'];
            $catestr = $cate_id;
            $cate = M('cate');
            $cates = $cate->field("cate_id")->where("status >= 0 and cate_parent = ".$cate_id)->select();
            if($cates){
                foreach ($cates as $k => $v) {
                    $catestr.=",".$v['cate_id'];
                }
            }
            $where.=" and c.cate_id in (".$catestr.")";
        }
        if (!empty($_GET['goods_name'])) {
            $where.=" and goods_name like '%".I("goods_name")."%'";
        }
        
        // 自定义分页连表查询
        $page = new \Think\Page($Goods->table('mk_goods g,mk_cate c')->where($where)->count(),10);
        $list = $Goods->table('mk_goods g,mk_cate c')
                        ->field('g.*,c.cate_name')
                        ->where($where)
                        ->order('g.add_time desc')
                        ->limit($page->firstRow.','.$page->listRows)
                        ->select();
        
        // var_dump($cate_id);exit;
        int_to_string($list);
        // exit;
        $c = D("Cate");
        $map['status']  =   array('egt',0);
        $catelists = $c->where($map)->order("cate_id asc")->select();
        $catelists = get_list($catelists);
        // var_dump($catelists);exit;
        // echo "----"*2;exit;
        //设置分页主题
        $page->setConfig('theme','%FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END% %HEADER%');
        $p =$page->show();
        $this->assign('_page', $p? $p: '');
        // 记录当前列表页的cookie
        Cookie('__forward__',$_SERVER['REQUEST_URI']);
        // var_dump($list);exit;
        $this->assign('list', $list);
        $this->assign('cate_id', $cate_id);
        $this->assign('catelists', $catelists);
        $this->meta_title = '设备列表';

        $this->display();
    }

    public function out(){
        
        $Goods   =   D('goods');
        $where = 'g.cate_id = c.cate_id and g.status=-1';
        if (!empty($_GET['cate_id'])) {
            $cate_id = $_GET['cate_id'];
            $catestr = $cate_id;
            $cate = M('cate');
            $cates = $cate->field("cate_id")->where("status >= 0 and cate_parent = ".$cate_id)->select();
            if($cates){
                foreach ($cates as $k => $v) {
                    $catestr.=",".$v['cate_id'];
                }
            }
            $where.=" and c.cate_id in (".$catestr.")";
        }
        if (!empty($_GET['goods_name'])) {
            $where.=" and goods_name like '%".I("goods_name")."%'";
        }
        
        // 自定义分页连表查询
        $page = new \Think\Page($Goods->table('mk_goods g,mk_cate c')->where($where)->count(),10);
        $list = $Goods->table('mk_goods g,mk_cate c')
                        ->field('g.*,c.cate_name')
                        ->where($where)
                        ->order('g.add_time desc')
                        ->limit($page->firstRow.','.$page->listRows)
                        ->select();
        
        // var_dump($cate_id);exit;
        int_to_string($list);
        // exit;
        $c = D("Cate");
        $map['status']  =   array('egt',0);
        $catelists = $c->where($map)->order("cate_id asc")->select();
        $catelists = get_list($catelists);
        // var_dump($catelists);exit;
        // echo "----"*2;exit;
        //设置分页主题
        $page->setConfig('theme','%FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END% %HEADER%');
        $p =$page->show();
        $this->assign('_page', $p? $p: '');
        // 记录当前列表页的cookie
        Cookie('__forward__',$_SERVER['REQUEST_URI']);
        // var_dump($list);exit;
        $this->assign('list', $list);
        $this->assign('cate_id', $cate_id);
        $this->assign('catelists', $catelists);
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
       
        $Goods = D("Goods");

        if (IS_POST) {

            $id = $_POST['goods_id'];
            if ( empty($id) ) {
                $this->error('意外出错!');
            }
            $map['goods_id'] = $id;

            $bool = $this->diyedit('Goods', $map ,$_POST,$msg = array( 'success'=>'编辑成功！', 'error'=>'编辑失败！','url'=>U('index')));

        }else{
            $id = I('get.id');
            empty($id) && $this->error('参数不能为空！');
            $data = $Goods->table('mk_goods g,mk_cate c')
                        ->field('g.*,c.cate_name,c.cate_parent')
                        ->where('g.cate_id = c.cate_id AND g.goods_id ='.$id)
                        ->find();
            $map['status']  =   array('egt',0);
            $c = D("Cate");
            $cates = $this->lists($c,$map,"cate_id asc");
            $cates = get_list($cates);
            // var_dump($list);exit;
            // return $list;
            $this->assign("cates",$cates);
            $this->assign('data',$data);
            $this->meta_title = '编辑行为';
            $this->display();
        }
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
        $map['goods_id'] =   array('in',$id);
        switch ( strtolower($method) ){
            case 'forbiddevice':
                $this->forbid('Device', $map );
                break;
            case 'replaygoods':
                // var_dump($map);exit; 
                $this->resume('Goods', $map,array( 'success'=>'上架成功！', 'error'=>'上架失败！'));
                break;
            case 'deletegoods':
                $this->delete('Goods', $map ,array( 'success'=>'下架成功！', 'error'=>'下架失败！'));
                break;
            case 'onlydelete':
                $this->diyedit('Goods', $map ,$data=array("status"=>-2,$data['update_time']=NOW_TIME),array( 'success'=>'删除成功！', 'error'=>'删除失败！'));
                break;

            default:
                $this->error('参数非法');
        }
    }

/**
     * 分类状态状态修改
     * @author 朱亚杰 <zhuyajie@topthink.net>
     */
    public function catechangeStatus($method=null){
        $id = array_unique((array)I('id',0));
        // if( in_array(C('USER_ADMINISTRATOR'), $id)){
        //     $this->error("不允许对超级管理员执行该操作!");
        // }
        // var_dump($id);exit; 
        $id = is_array($id) ? implode(',',$id) : $id;
        if ( empty($id) ) {
            $this->error('请选择要操作的数据!');
        }
        $map['cate_id'] =   array('in',$id);
        $where['cate_parent'] = array('in',$id);
        $where['status'] = array("egt",0);
        // 判断是否有子分类吗，有，先删除子分类，
        $cate = M("cate");
        $res = $cate->where($where)->select();
        if ($res) {
            $this->error('请先删除子分类!');
        }
        $goods = M("goods");
        $res = $goods->where("status >= -1 and cate_id = ".$id)->select();
        if ($res) {
            $this->error('请先删除分类下的商品!');
        }
        // var_dump($map);exit;
        switch ( strtolower($method) ){
            case 'deletecate':
                $this->delete('Cate', $map );
                break;
            default:
                $this->error('参数非法');
        }
    }


    //分类管理
    public function category(){

        $c = D("Cate");
        $map['status']  =   array('egt',0);
        $list = $this->lists($c,$map,"cate_id asc");
        $list = get_list($list);
        // var_dump($list);exit;
        // return $list;
        $this->assign("list",$list);
        $this->display();
    }

    //新增分类
    public function cate_add(){
        $c = D("Cate");
        if (IS_POST) {
            $_POST['add_time'] = time();
            $_POST['update_time'] = time();
            $cate_id = $c->field("cate_name,cate_parent,add_time,update_time")->add($_POST);
            if(0 < $cate_id){ //注册成功
                $this->success('分类添加成功！');
            } else { //注册失败，显示错误信息
                $this->error("分类添加失败 ");
            }
        }else{
            $map['status']  =   array('egt',0);
            $list = $this->lists($c,$map,"cate_id asc");
            $list = get_list($list);
            // var_dump($list);exit;
            // return $list;
            $this->assign("list",$list);
            $this->display();
        }
    }

    //编辑分类
    public function cate_edit(){
        $cate = M("cate");
        if (IS_POST) {
            $_POST['update_time'] = time();
            $res = $cate->where("cate_id = ".$_POST['cate_id'])->save($_POST);
            if($res){ //注册成功
                $this->success('编辑成功！',U('category'));
            } else { //注册失败，显示错误信息
                $this->error("编辑失败 ");
            }
        }else{
            if ($_GET['cate_id']) {
                $cate_id = $_GET['cate_id'];
                $detail = $cate->where("cate_id = ".$cate_id)->find();
                // var_dump($detail);exit;
                $this->assign("detail",$detail);
                $this->display();
            }
        }
    }
    public function add($device_name = '', $device_qr = '', $shop_id = '',$device_id=""){
        if(IS_POST){
            $_POST['add_time'] = time();
            /* 调用注册接口注册用户 */
            $goods   =   D("goods");
             $goods_id = $goods->field("device_name,device_qr,shop_id,device_id")->add($_POST);
            if(0 < $goods_id){ //注册成功
                $this->success('货品添加成功！',U('index'));
            } else { //注册失败，显示错误信息
                $this->error("货品添加失败 ");
            }
        } else {
            $c = D("Cate");
            $cates = $this->lists($c);
            $this->assign("cates",$cates);
            $this->meta_title = '新增货品';
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
