<?php

namespace Admin\Controller;
use Think\Controller;

/**
* APP店铺管理员登录类
*/
class ShoploginController extends Controller{
	

	/**
	 * 店铺管理员登录操作
	 * @param  string $username [用户名]
	 * @param  string $password [密码]
	 * @return [type]           [description]
	 */
	public function login($username='',$password=''){
		if(empty($username)){
			echo '{"status":0,"msg":"用户名不能为空"}';
			return ;
		}

		if(empty($password)){
			echo '{"status":0,"msg":"密码不能为空"}';
			return ;
		}

		// 查找该用户是否存在
		$ucenter_member = M("ucenter_member");

		$userinfo = $ucenter_member->where("username = '".$username."' and status >=1 and manager = 3")->find();

		if($userinfo){

			if($userinfo['password'] == think_ucenter_md5($password, 'R&?cnX$pbqt>kT|%M<)5B;iA]uE9Oz-o{J=3dH(x')){
				$stoken = M("stoken");
				$stokeninfo = $stoken->where("uid = ".$userinfo['id'])->find();
				$token = $this->getToken(12);
				if($stokeninfo){
					$savetoken = $stoken->where("uid = ".$userinfo['id'])->save(array("token"=>$token,"update_time"=>time()));
					if($savetoken){
						echo '{"status":1,"uid":'.$userinfo['id'].',"token":"'.$token.'"}';
						return;
					}
				}else{
					$addtoken = $stoken->add(array("uid"=>$userinfo['id'],"token"=>$token,"create_time"=>time(),"update_time"=>time()));
					if($addtoken){
						echo '{"status":1,"uid":'.$userinfo['id'].',"token":"'.$token.'"}';
						return;
					}else{
						echo '{"status":0,"msg":"登录失败，请重试"}';
						return;
					}
				}
			}else{
				echo '{"status":0,"msg":"密码错误"}';
				return;
			}

		}else{
			echo '{"status":0,"msg":"用户不存在或被禁用"}';
			return;
		}
	}

	/**
	 * 获取用户登录态的校验码
	 * @Author   孙乔雨
	 * @DateTime 2018-04-04
	 * @return   [type]                [设备分享的校验码]
	 */
	public function getToken($length = 5){
	    $device_token = null;
	    $strPol = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz";
	    $max = strlen($strPol)-1;
	 
	    for($i=0;$i<$length;$i++){
	        $token.=$strPol[rand(0,$max)]; //rand($min,$max)生成介于min和max两个数之间的一个随机整数
	    }

	   return md5($token);
	}
	
}

?>