<?php

namespace Admin\Controller;
use Think\Controller;

/**
* APP店铺管理员登录类
*/
class ShopbaseController extends Controller{
	
	/**
	 * 店铺管理员入口操作
	 * @param  string $uid   [当前用户ID号]
	 * @param  string $token [用户校验token]
	 * @return [type]        [description]
	 */
	public function _initialize(){
		$uid = I("uid");
		$token = I("token");

		if(empty($uid)){
			echo '{"status":0,"msg":"缺少用户ID号"}';
			exit;
		}

		if(empty($token)){
			echo '{"status":0,"msg":"缺少用户校验参数"}';
			exit;
		}

		$stoken = M("stoken");
		$stokeninfo = $stoken->where("uid = ".$uid)->find();
		if($stokeninfo){
			if($stokeninfo['token']!=$token){
				echo '{"status":0,"msg":"登录态过期,请重新登录"}';
				exit;
			}
		}else{
			echo '{"status":0,"msg":"请先登录"}';
			exit;
		}
	}
}

?>