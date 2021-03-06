<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------

namespace Admin\Controller;
use User\Api\UserApi;

/**
 * 后台用户控制器
 * @author 麦当苗儿 <zuojiazi@vip.qq.com>
 */
class UserController extends AdminController {

    /**
     * 用户管理首页
     * @author 麦当苗儿 <zuojiazi@vip.qq.com>
     */
    public function index($nickname=''){



        // 只是去获取所有的后台管理员门
        $uid = session("user_auth")['uid'];
        $member = M("member");
        $where = 'm.status>=0 and m.business_id = b.business_id and b.business_id>1';

        if (!empty($nickname)) {
            $where .= " and nickname like '%".$nickname."%'";
        }

        // 取得在超级管理员组下的所有管理员
        $auth_group_access = M("auth_group_access");
        $auth_group_access_group = $auth_group_access->where("group_id = 1")->select();

        foreach ($auth_group_access_group as $k => $v) {
            
            $super[] = $v['uid'];
        }

        // 如果不是超级管理员,并且不是配置的超管，则显示本加盟商下面的所有管理员
        if(C('USER_ADMINISTRATOR') != $uid&&!(in_array($uid, $super))){

            $business_id = $member->where("status >=0 and uid = ".$uid)->find()['business_id'];
            $where .=" and m.business_id = ".$business_id;
        }

        // 自定义分页连表查询
        $page = new \Think\Page($member->table('mk_member m,mk_business b')->where($where)->count(),10);
        $list = $member->table('mk_member m,mk_business b')
                        ->field('m.*,b.business_name,b.business_address')
                        ->where($where)
                        ->order('m.uid asc')
                        ->limit($page->firstRow.','.$page->listRows)
                        ->select();
        // var_dump($list);exit;
        int_to_string($list);
        $page->setConfig('theme','%FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END% %HEADER%');
        $p =$page->show();
        $this->assign('_page', $p? $p: '');
        // 记录当前列表页的cookie
        Cookie('__forward__',$_SERVER['REQUEST_URI']);
        $this->assign('_list', $list);
        $this->assign("uid",$uid);
        $this->display();
    }

    public function user($status='',$nickname=''){


        $user = M("user");
        $where = "1 ";
        if (!empty($status)||$status == "0") {
            $this->status = $status;
            $where .= " and status = ".$status;
        }

        if (!empty($nickname)) {
            
            $where .= " and nickname like '%".$nickname."%'";
        }
        // echo $where;exit;
        $list = $user->where($where)->order("uid asc")->select();
        // ,$map=array('status'=>array(0=>'默认未提交认证信息',1=>'已提交认证信息',2=>'通过审核',3=>"审核不通通过",4=>"被拉黑"))
        int_to_string($list,$map=array('status'=>array(0=>'新用户',1=>'待审核',2=>'已认证',3=>"审核未通过",4=>"已被拉黑")));
        // var_dump($list);exit;
        $this->assign('_list', $list);
        // var_dump($list);exit;
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

    // 审核
    public function tocheck(){
        $user = D("user");
        // var_dump($_GET);
        $uid = I("id");
        $userdetail = $user->where("uid = ".$uid)->find();
        // var_dump($userdetail);
        $this->assign("userdetail",$userdetail);
        $this->display();
    }

     // 查看资料
    public function look(){
        $user = D("user");
        // var_dump($_GET);
        $uid = I("id");
        $userdetail = $user->where("uid = ".$uid)->find();
        // var_dump($userdetail);
        $this->assign("userdetail",$userdetail);
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
     * 会员状态修改
     * @author 朱亚杰 <zhuyajie@topthink.net>
     */
    public function changeStatus($method=null){
        $id = array_unique((array)I('id',0));
        
        $id = is_array($id) ? implode(',',$id) : $id;
        if ( empty($id) ) {
            $this->error('请选择要操作的数据!');
        }

        $map['uid'] =   array('in',$id);
        switch ( strtolower($method) ){
            case 'resumeuser':
                $this->diyedit('user', $map,array("status"=>2),array( 'success'=>'审核通过成功', 'error'=>'审核通过失败',"url"=>U('user')) );
                break;
            case 'deleteuser':
            // var_dump($method);
                $this->diyedit('user', $map,array("status"=>-1),array( 'success'=>'删除成功', 'error'=>'删除失败',"url"=>U('user')) );
                break;
            case 'darkhoom':
            // var_dump($method);
                $this->diyedit('user', $map,array("status"=>4),array( 'success'=>'拉黑成功', 'error'=>'拉黑失败',"url"=>U('user')) );
                break;
            case 'falsed':
                $this->diyedit('user', $map ,array("status"=>3),array( 'success'=>'审核不通过成功', 'error'=>'审核不通过失败',"url"=>U('user')));
                break;
            default:
                $this->error('参数非法');
        }
    }

        /**
     * 会员状态修改
     * @author 朱亚杰 <zhuyajie@topthink.net>
     */
    public function adminchangeStatus($method=null){
        $id = array_unique((array)I('id',0));
        if( in_array(C('USER_ADMINISTRATOR'), $id)){
            $this->error("不允许对超级管理员执行该操作!");
        }
        $id = is_array($id) ? implode(',',$id) : $id;
        if ( empty($id) ) {
            $this->error('请选择要操作的数据!');
        }

        $map['uid'] =   array('in',$id);
        // var_dump($map);
        switch ( strtolower($method) ){
                case 'resume':
                    $this->resume('member', $map );
                    break;
                case 'forbid':
                    $this->forbid('member', $map );
                    break;
                case 'delete':
                    $this->delete('member', $map );
                    break;
            default:
                $this->error('参数非法');
        }
    }

    public function add($username = '', $password = '', $repassword = '', $email = '',$com_business_id='',$bus_business_id='',$shop_id='',$manager=''){
        if(IS_POST){
            /* 检测密码 */
            if($password != $repassword){
                $this->error('密码和重复密码不一致！');
            }
            if(empty($manager)){
                $this->error('请刷新重试！');
            }
            // 如果不是超级管理员
            if($manager==1){
                $business_id = 0;
                $shop_id = 0;
            }elseif ($manager == 2) {
                if(empty($bus_business_id)){
                    $this->error('请选择加盟商！');
                }else{
                    $business_id = $bus_business_id;
                    $shop_id = 0;
                }
            }elseif ($manager == 3) {
                if(empty($com_business_id)){
                    $this->error('请选择加盟商！');
                }
                if (empty($shop_id)) {
                    $this->error('请选择店铺！');
                }
                $business_id = $bus_business_id;
            }
           
            /* 调用注册接口注册用户 */
            $User   =   new UserApi;
            $uid    =   $User->register($username, $password, $email,'',$business_id,$manager,$shop_id);
            if(0 < $uid){ //注册成功
                $user = array('uid' => $uid, 'nickname' => $username, 'status' => 1,"business_id"=>$business_id,"reg_time"=>time());

                //分配至管理员组

                $res = M("auth_group_access")->add(array("uid"=>$uid,"group_id"=>$manager));
                if(!M('Member')->add($user)&&$res){
                    $this->error('用户添加失败！');
                } else {
                    $this->success('用户添加成功！',U('index'));
                }
            } else { //注册失败，显示错误信息
                $this->error($this->showRegError($uid));
            }
        } else {

            // 获取加盟商列表 定义：出超管外只显示本加盟商，超管可以指定加盟商
            $uid = session("user_auth")['uid'];
            $business = M("business");

             // 取得在超级管理员组下的所有管理员
            $auth_group_access = M("auth_group_access");
            $auth_group_access_group = $auth_group_access->where("group_id = 1")->select();

            foreach ($auth_group_access_group as $k => $v) {
                
                $super[] = $v['uid'];
            }
            $super[] = 1;

            // 如果不是超级管理员,并且不是配置的超管，则显示本加盟商下面的所有管理员
            if(C('USER_ADMINISTRATOR') != $uid&&!(in_array($uid, $super))){

                // 普通用户，则只需获取本加盟商信息
                $businessinfo = $business->table("mk_business as b,mk_ucenter_member as u")->where("u.id = ".$uid." and b.business_id = u.business_id")->find();
                $this->assign("businessinfo",$businessinfo);

                //获取本加盟商下的所有店铺
                $shop = M("shop");
                $shoplists = $shop->where("status >= 0 and bussiness_id = ".$businessinfo['business_id'])->select();
                $this->assign("shoplists",$shoplists);

               

            }else{

                 $businesslists = $business->where("status >=0 and business_id>1")->select();
                $this->assign("businesslists",$businesslists);
                
                //获取所有店铺
                $shop = M("shop");
                $shoplists = $shop->where("status >= 0")->select();
                $this->assign("shoplists",$shoplists);
            }

            if(in_array($uid, $super)){
                $this->assign("is_show",1);
            }else{
                $this->assign("is_show",0);
            }

            $this->assign("uid",$uid);
            $this->meta_title = '新增用户';
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
