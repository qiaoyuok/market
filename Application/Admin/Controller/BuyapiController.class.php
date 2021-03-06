<?php

namespace Admin\Controller;

class BuyapiController extends BuyController {
	
	// 用户扫描设备二维码操作
	public function index($device_id='',$lock_num=''){
		
		// 如果设备ID号为空，或锁号为空，则提示重新扫描或上报错误信息
		if (empty($device_id)||empty($lock_num)) {
			
			$this->show('<header><meta charset="utf-8"><title>错误信息</title><meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" /></header><div><p style="margin-top:150px;text-align:center;color:red;">请重新扫描货柜上的二维码</p></div>');
			exit;
		}

		$_SESSION['uid']['device_id'] = $device_id;
		$_SESSION['uid']['lock_num'] = $lock_num;

		$userinfo = M("user")->where("uid = ".$_SESSION['log']['uid'])->find();
		var_dump($userinfo);
		if ($userinfo) {
			
			switch($userinfo['status']){

				// 会员状态含义	 0：默认状态，未提交认证信息；1：提交了认证信息，待审核；2：审核通过；3：审核不通通过；4：被拉黑

				case 0:	$this->redirect("subinfo");break;

				case 1:
					$this->show('<header><meta charset="utf-8"><title>提示信息</title><meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" /></header><div><p style="margin-top:150px;text-align:center;color:red;">用户信息正在审核。。。</p></div>');
					break;

				case 2:
					$order = M("order");

			    	// 获取该用户最最近一次待支付订单信息
			    	$orderinfo = $order->where("status = 0 and uid = ".$_SESSION['log']['uid'])->order("order_id desc")->limit(1)->find();
					if ($orderinfo) {
						
						// 有待支付订单，则直接跳转到，订单支付界面
						$this->redirect("orderdetail?order_id=".$orderinfo['order_id']);break;
					}else{
						// 则可以直接跳转到开锁界面
						$this->redirect("openlock");break;
					}
					break;

				default :
					$this->show('<header><meta charset="utf-8"><title>提示信息</title><meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" /></header><div><p style="margin-top:150px;text-align:center;color:red;">出错了！</p></div>');
					break;
			}
		}
	}

	// 提交用户信息
	public function subinfo($name='',$idcard=''){

		$user = M("user");
		if ($_POST) {

			if (empty($name)||empty($idcard)) {

				echo '{"status":0,"msg":"姓名和身份证号都不能为空"}';
				return;
			}

			$_POST['status'] = 1;
			$_POST['create_time'] = time();
			// 提交认证
			$r = $user->where("uid = ".$_SESSION['log']['uid'])->save($_POST);
			if($r){
				echo '{"status":1,"msg":"提交信息成功，等待审核。。。"}';
			}else{
				echo '{"status":0,"msg":"提交信息失败"}';
			}
			return;
		}

		$userinfo = $user->field("status")->where("uid = ".$_SESSION['log']['uid'])->find();

		if ($userinfo) {
			
			switch($userinfo['status']){

				// 会员状态含义	 0：默认状态，未提交认证信息；1：提交了认证信息，待审核；2：审核通过；3：审核不通通过；4：被拉黑

				case 0:	$this->display();break;

				case 1:
					$this->show('<header><meta charset="utf-8"><title>提示信息</title><meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" /></header><div><p style="margin-top:150px;text-align:center;color:red;">用户信息正在审核。。。</p></div>');
					break;

				case 2:
					$this->redirect("openlock");
					break;
				default :
					$this->show('<header><meta charset="utf-8"><title>提示信息</title><meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" /></header><div><p style="margin-top:150px;text-align:center;color:red;">出错了！</p></div>');
					break;
			}
		}
	}

		// 用户开锁操作
	public function openlock($method=''){

		if ($_POST) {

			// 判断当前用户是否存在已打开并且未关的其他门
			$devcieinfo = M("devicelog")->where("status = 1  and uid = ".$_SESSION['log']['uid']." and device_id not in(".$_SESSION['uid']['device_id'].")")->order("add_time desc")->limit(1)->find();
			if($devcieinfo){
				echo '{"status":0,"msg":"请先关闭之前打开的门"}';
				return ;
			}

			if ($method == "getstatus") {
				
				// 获取当前货柜状态
				$devcieinfo = M("devicelog")->where("status = 1 and device_id = ".$_SESSION['uid']['device_id'])->order("add_time desc")->limit(1)->find();
				if ($devcieinfo) {
					if($devcieinfo['uid'] == $_SESSION['log']['uid']){
						echo '{"status":1,"msg":"正在跳转至购物车..."}';
						return ;
					}elseif($devcieinfo['uid'] != $_SESSION['log']['uid']){
						echo '{"status":3,"msg":"请排队等候前面的人购买..."}';
						return ;
					}
				}

				echo '{"status":2,"msg":"不做任何处理!"}';
				return ;
			}

			if ($method == "openlock") {

				// 获取当前货柜状态
				$devcieinfo = M("devicelog")->where("status = 1 and device_id = ".$_SESSION['uid']['device_id'])->order("add_time desc")->limit(1)->find();
				if ($devcieinfo) {
					if($devcieinfo['uid'] == $_SESSION['log']['uid']){
						echo '{"status":1,"msg":"正在跳转至购物车..."}';
						return ;
					}elseif($devcieinfo['uid'] != $_SESSION['log']['uid']){
						echo '{"status":3,"msg":"请排队等候前面的人购买..."}';
						return ;
					}
				}

				$device_content = base64_encode('{"token":"850c2dac78c74f66a7249ecee32413a1","device_id":"'.$_SESSION['uid']['device_id'].'","command_type":1,"lock_no":"'.$_SESSION['uid']['lock_num'].'","status":1}');
			    $url = "http://39.108.187.12:8666/api/?content=".$device_content;
			    file_put_contents("/a.txt", '{"token":"850c2dac78c74f66a7249ecee32413a1","device_id":"'.$_SESSION['uid']['device_id'].'","command_type":1,"lock_no":"'.$_SESSION['uid']['lock_num'].'","status":1}');
			    $ch = curl_init();
			    curl_setopt($ch, CURLOPT_URL, $url);
			    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE); 
			    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE); 
			    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
			    $output = curl_exec($ch);
			    curl_close($ch);
			    $output = json_decode($output,true);

			    if ($output['status'] == 1) {
			    	$devicelogdata = array(
			    		"device_id"=>$_SESSION['uid']['device_id'],
			    		"lock_num"=>$_SESSION['uid']['lock_num'],
			    		"add_time"=>time(),
			    		"update_time"=>time(),
			    		"uid"=>$_SESSION['log']['uid'],
			    	);
			    	$devicelogres = M("devicelog")->add($devicelogdata);
			    	if ($devicelogres) {
				    	echo '{"status":1,"msg":"开门成功,正在跳转至购物车..."}';
				    	return ;
				    }
			    }else{
			    	echo '{"status":0,"msg":"开门失败"}';
			    }
			}
		}

		$devcieinfo = M("devicelog")->where("status = 1 and device_id = ".$_SESSION['uid']['device_id'] ."and uid =".$_SESSION['log']['uid'])->order("add_time desc")->limit(1)->find();
		if($devcieinfo){
			$this->redirect("cart");
			exit;
		}

		$userinfo = M("user")->field("status")->where("uid = ".$_SESSION['log']['uid'])->find();
		if ($userinfo) {
			switch($userinfo['status']){

				// 会员状态含义	 0：默认状态，未提交认证信息；1：提交了认证信息，待审核；2：审核通过；3：审核不通通过；4：被拉黑
				case 0:	$this->redirect("subinfo");break;;
				case 1:
					$this->show('<header><meta charset="utf-8"><title>提示信息</title><meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" /></header><div><p style="margin-top:150px;text-align:center;color:red;">用户信息正在审核。。。</p></div>');
					exit;
				case 2:
					$this->display();break;
			}	
		}
	}

	// 生成订单编号
	public function getSn(){
		$sn = time().mt_rand(10000000,99999999);
		$order = M("order");
		$snres = $order->where("sn = '".$sn."'")->find(); 
		if ($snres) {
			$this->getSn();
		}else{
			return $sn;
		}
	}


	public function cart(){
    	// 判断该用户是否开门
    	$devicelog = M("devicelog");
    	
    	$device_id = $_SESSION['uid']['device_id'];
    	$lock_num = $_SESSION['uid']['lock_num'];
    	// var_dump($_GET);
    	$res = $devicelog->where("uid = ".$_SESSION['log']['uid']." and device_id = '".$device_id."' and lock_num = ".$lock_num)->order("add_time desc")->limit(1)->find();
    	// 说明当前货柜时该用户打开，此时才会显示购物车信息
    	if (IS_POST) {
    		
    		if ($res&&$res['status'] == 1) {
	    		echo $this->getgoods($device_id);

	    	}elseif($res&&$res['status'] == 0){


	    		// 拿完货品关门，判断订单是否入库，有的话，则直接跳转至订单详情界面；没有则说明没有拿任何货品，不做处理
	    		$res = M("order")->where("uid = ".$_SESSION['log']['uid']." and status = 0")->order("add_time desc")->limit(1)->find();

	    		if ($res) {
	    			echo '{"status":2,"msg":"创建订单成功,正在跳转...","order_id":'.$res['order_id'].'}';
	    		}else{

					echo '{"status":-1,"msg":"已经关门，并且没有拿任何货品"}';
	    		}
	    	}	

	    	return;
    	}

    	if($res&&$res['status'] == 0){
    		
			$this->show('<header><meta charset="utf-8"><title>提示信息</title><meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" /></header><div><p style="margin-top:150px;text-align:center;color:red;">请先扫描货柜二维码开门！</p></div>');exit;

    	}
		$this->display();
    }

    // 获取用户拿货状态
   	private function getgoods($device_id=''){
   		$board = M("board");
   		$res = $board->where("device_id = '".$device_id."'")->find();
		if ($res) {

			$goods_status = json_decode($res['goods_status'],true);
			$new_status = json_decode($res['new_status'],true);

			// 没拿商品状态，返回给前台
			if (empty($new_status)) {

				return '{"status":0,"msg":"您还没拿商品"}';

			}

			foreach ($goods_status as $k => $v) {
				
				if ($goods_status[$k]) {

					foreach ($v as $k1 => $v1) {

						// 商品的id号
						$shopgoods_id = $k1;

						// 查找原始状态中0的个数
						$old_count = substr_count($goods_status[$k][$k1], "0");

						// 查找当前状态下0的个数
						$new_count = substr_count($new_status[$k][$k1], "0");
					}
					$list[] = array("shopgoods_id"=>$shopgoods_id,"num"=>$new_count-$old_count);
				}
			}
		}
		
		// 根据货柜id号查询店铺ID号
		$shop_id = M("board")->field("shop_id")->where("device_id = '".$device_id."'")->find()['shop_id'];
		// var_dump($shop_id);return;
		$allnum = 0;
		$allcount = 0;
		foreach ($list as $k => $v) {
			if ($v['num']>0) {
				$goods_detail = M("shopgoods")->field("cell_price,goods_name,cost")->where("shopgoods_id = ".$v['shopgoods_id'])->find();
				// 商品的id号
				$goodsdetail[$v['shopgoods_id']]['shopgoods_id'] = $v['shopgoods_id'];
				// 商品名称
				$goodsdetail[$v['shopgoods_id']]['goods_name'] = $goods_detail['goods_name'];
				//商品进价
				$goodsdetail[$v['shopgoods_id']]['cost'] = $goods_detail['cost'];
				// 商品售价
				$goodsdetail[$v['shopgoods_id']]['cell_price'] = $goods_detail['cell_price'];
				// 商品数量
				$goodsdetail[$v['shopgoods_id']]['num'] = $v['num'];
				// 商品小计
				$goodsdetail[$v['shopgoods_id']]['small_count'] = $v['num']*$goods_detail['cell_price'];
				// 商品总量
				$allnum += $v['num'];
				// 商品总计
				$allcount += $goodsdetail[$v['shopgoods_id']]['small_count'];
			}
		}

		// 拿了商品又放回去
		if ($allnum<=0) {
			return '{"status":0,"msg":"您还没拿商品"}';

		}

		$order['goodsdetail'] = $goodsdetail;
		$order['allcount'] = $allcount;
		$order['allnum'] = $allnum;
		$order['shop_id'] = $shop_id;
		$order['device_id'] = $device_id;

		return '{"status":1,"data":'.json_encode($order).'}';

   	}

	public function orderdetail($order_id=''){
		
		if (empty($order_id)) {
			$this->show('<header><meta charset="utf-8"><title>提示信息</title><meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" /></header><div><p style="margin-top:150px;text-align:center;color:red;">没有这个订单哦！</p></div>');
			exit;
		}

		$where = "uid = ".$_SESSION['log']['uid']." and order_id = ".$order_id;
		$orderinfo = M("order")->where($where)->find();
		if (!$orderinfo) {
			$this->show('<header><meta charset="utf-8"><title>提示信息</title><meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" /></header><div><p style="margin-top:150px;text-align:center;color:red;">没有这个订单哦！</p></div>');
			exit;
		}
		$orderinfo['goodsdetail'] = json_decode($orderinfo['goodsdetail'],true);

		// 判断订单是否为待支付付状态   0:待支付状态；1：已完成支付
		if ($orderinfo['status'] == 0) {
			

			$prepay_id = $this->getPrepayId($orderinfo['sn'],$orderinfo['allcount']*100);

			$json = $this->getJsParams($prepay_id);
			$this->assign("json",$json);
		}

		$this->assign("orderinfo",$orderinfo);
		$this->display();
	}

	public function submitorder($device_id=''){

		$res = json_decode($this->getgoods($device_id),true);
		
		// 确定顾客拿货了，订单可以入库
		if ($res['status'] == 1) {
			
			// 根据当前设备ID号，确定是哪个用户的订单

			$uid = M("devicelog")->where("device_id = '".$device_id."'")->order("add_time desc")->limit(1)->find()['uid'];

			if ($uid) {

				$res['data']['uid'] = $uid;

				//生成订单号
				$res['data']['sn'] = $this->getsn();

				//订单生成时间
				$res['data']['add_time'] = time();

				//订单更新时间
				$res['data']['update_time'] = time();

				//把订单中的商品详情转化为json串
				$res['data']['goodsdetail'] = json_encode($res['data']['goodsdetail']);

				// 把新订单做入库操作
				M("order")->create($res['data']);
				$r = M("order")->add($res['data']);


				// 订单入库成功，跳转到订单详情界面，下一步，发起支付
				if ($r) {

					//清空货板的拿货状态
					$boardinfo = M("board")->where("device_id = '".$device_id."'")->find();
					if ($boardinfo['new_status']) {
						
						$res = M("board")->where("device_id = '".$device_id."'")->save(array("goods_status"=>$boardinfo['new_status'],"new_status"=>""));
						if ($res) {
							// 统计货品库存
							$this->stock($boardinfo['new_status']);
							echo '{"status":1,"msg":"创建订单成功,正在跳转...","order_id":'.$r.'}';
							return ;
						}
					}

				}else{

					echo '{"status":0,"msg":"创建订单失败"}';
					return;
				}

			}else{

				echo '{"status":0,"msg":"系统出错！"}';
				return ;
			}
		}else{
			//清空货板的拿货状态
			$boardinfo = M("board")->where("device_id = '".$device_id."'")->find();
			if ($boardinfo['new_status']) {
				$res = M("board")->where("device_id = '".$device_id."'")->save(array("goods_status"=>$boardinfo['new_status'],"new_status"=>""));
			}
			// 统计货品库存
			$this->stock($boardinfo['new_status']);
			return 1;
		}
	}

	/**
	 * 提交订单后统计商品库存
	 * @param  [type] $goods_status [设备上货品详情]
	 * @return [type]               [description]
	 */
	public function stock($goods_status=''){
		
		$goods_status = json_decode($goods_status,true);

		if(empty($goods_status)){
			return false;//系统后台没有铺货
		}


		// 循环获取商品库存量，并入库
		foreach ($goods_status as $k => $v) {
				
			if ($goods_status[$k]) {

				foreach ($v as $k1 => $v1) {

					// 商品的id号
					$shopgoods_id = $k1;

					// 查找原始状态中0的个数
					$stock = substr_count($goods_status[$k][$k1], "1");
				}

				$shopgoods = M("shopgoods");
				$shopgoods->where("shopgoods_id = ".$k1)->save(array("stock"=>$stock));
			}
		}
	}

	public function orderlists(){
		
		//订单状态，
		$where = "uid = ".$_SESSION['log']['uid']." and status >=0";
		$order = M("order");
		if (isset($_GET['status'])) {
			$where .= " and status = ".I("status");
		}
		$orderlists = $order->where($where)->order("update_time desc")->select();
		foreach ($orderlists as $k => $v) {
			
			$orderlists[$k]['goodsdetail'] = json_decode($orderlists[$k]['goodsdetail'],true);
			$goods_name = "";

			foreach ($orderlists[$k]['goodsdetail'] as $k1 => $v1) {
				$goods_name  .= $v1['goods_name']."　";
			}

			$orderlists[$k]["goods_name"] = $goods_name;
		}

		$this->assign("orderlists",$orderlists);
		$this->display();
	}


	// 用户中心
	public function my(){

		$userinfo = M("user")->where("uid = ".$_SESSION['log']['uid']." and status >=0")->find();
		$this->assign("userinfo",$userinfo);
    	$this->display();
    }

    public function pay($order_id=''){

    	if (empty($order_id)) {
    		
    		echo '{"status":0,"msg":"参数错误"}';
    		return ;
    	}

    	$order = M("order");
    	$res = $order->where("status = 0 and order_id = ".$order_id)->find();
    	if ($res) {
    		$r = $order->where("order_id = ".$order_id)->save(array("status"=>1));
    		if ($r) {

    			// 把当前用户所购买的商品全部插入到，财务报表里
    			
    			echo '{"status":1,"msg":"支付成功"}';

    			return ;
    		}else{
    			echo '{"status":0,"msg":"支付失败"}';
    			return ;
    		}
    	}else{
    		echo '{"status":0,"msg":"无需支付订单"}';
    		return ;
    	}
    }
}
?>