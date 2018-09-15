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
 * 后台用户控制器
 * @author 麦当苗儿 <zuojiazi@vip.qq.com>
 */
class BusinessController extends AdminController {

    /**
     * 用户管理首页
     * @author 麦当苗儿 <zuojiazi@vip.qq.com>
     */
    public function index(){
        
        //获取所有加盟商列表
        $business = M("Business");
        $where = "status >=0 and business_id>1";
        $businesslists = $business->where($where)->select();

        $this->assign("businesslists",$businesslists);
        $this->display();
    }

    public function add(){
        
        if (IS_POST) {
            
            if (empty($_POST['business_name'])) {
               $this->error("加盟商名称不能为空！");
            }


            $business = M("Business");
            $business->create($_POST);
            $_POST['add_time'] = time();
            $res = $business->add($_POST);
            if ($res) {
                $this->success("添加成功",U("index"));
            }else{
                $this->error("添加失败");

            }
            return ;
        }


        $this->display();
    }

    public function changeStatus($method=null){
        $business_id = array_unique((array)I('business_id',0));
       
        $business_id = is_array($business_id) ? implode(',',$business_id) : $business_id;
        if ( empty($business_id) ) {
            $this->error('请选择要操作的数据!');
        }
        $map['business_id'] =   array('in',$business_id);
        switch ( strtolower($method) ){
            case 'delete':
                $this->delete('Business', $map );
                break;
            default:
                $this->error('参数非法');
        }
    }

    public function edit($business_id){

        $business = M("business");

        if (empty($business_id)) {
            $this->error("参数错误！");
        }

        if (IS_POST) {
            
            if (empty($_POST['business_name'])) {
                
                $this->error("加盟商名称不能为空！");
            }

            $business->create($_POST);
            $res = $business->where("business_id = ".$business_id)->save($_POST);
            if ($res) {
                $this->success("编辑成功",U("index"));
            }else{
                $this->errot("编辑失败！");
            }
        }

        $businessinfo = $business->where("business_id = ".$business_id)->find();
        $this->assign("businessinfo",$businessinfo);
        $this->display();
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
