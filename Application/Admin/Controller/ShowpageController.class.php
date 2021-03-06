<?php

namespace Admin\Controller;
use Think\Controller;
class ShowpageController extends Controller {

	private $APPID = "wx1c91409262d23ffb";
    private $AppSecret = "b345900fab24f72f221e820552cfc135";
    private $KEY = 'be0cddd847727f9faea486ae61c98ec7';
    private $MCHID = '1499192412';
    private $UNURL = 'https://api.mch.weixin.qq.com/pay/unifiedorder';

	//拿取商品
	public function goods_status(){
		$data = json_decode(base64_decode($_GET['content']),true);
		// var_dump($data);return;
		if ($data['data_type']) {
			$device_id = $data['device_no'];
			if(!M("devicelog")->where("device_id = '".$device_id."' and status = 1")->order("device_logid desc")->find()){
				echo '{"status":0,"msg":"请先开门"}';
				return ;
			}
			$board = M("board");
			$res = $board->where("device_id = ".$data['device_no']." and status = 1")->find();

			if ($res) {
				$goods_status = json_decode($res['goods_status'],true);
				$new_status = json_decode($res['new_status'],true);
				if ($goods_status) {
					foreach ($goods_status as $k => $v) {
						if ($k==$data['cupboard_no']&&is_array($v)) {

							// 拿的是这块板上的货品
							foreach ($v as $k1 => $v1) {
								if ($new_status) {
									$new_status[$k] = array($k1=>$data['status']);
								}else{
									$goods_status[$k] = array($k1=>$data['status']);
								}
							}
						}
					}
				}else{
					echo '{"status":0,"msg":"没有上架货品"}';
					return ;
				}

				if ($new_status) {
					$savadata['new_status'] = json_encode($new_status);
				}else{
					$savadata['new_status'] = json_encode($goods_status);
				}
				
				//保存该数据到new_status
				$saveres = $board->where("device_id = '".$device_id."'")->save($savadata);
				
				echo '{"status":1}';
				return ;
				
			}else{
				echo '{"status":0,"msg":"暂无此设备"}';
				return ;
			}
		}
	}
// {"1":{"21":"1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1"},"2":{"23":"1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1"},"3":null,"4":null,"5":null,"6":null,"7":null,"8":null,"9":null,"10":null,"11":null,"12":null,"13":null,"14":null,"15":null,"16":null,"17":null,"18":null}
	// 关门操作，包括执行修改关门状态，创建订单，清空临时购物信息
   public function closelock($content=''){

		// 判断关门所需参数是否传递
		if (empty($content)) {
			
			echo '{"status":0,"msg":"参数有误"}';
			return ;
		}

		$data = json_decode(base64_decode($content),true);
		$device_id = $data['device_no'];
		$lock_num = $data['lock_no'];
		//先去判断当前设备当前锁号是否为开这的状态
		$res = M("devicelog")->where("device_id = '".$device_id."' and lock_num = ".$lock_num." and status = 1")->order("add_time desc")->limit(1)->find();

		if ($res) {
			
			$r = M("devicelog")->where("device_logid = ".$res['device_logid'])->save(array("status"=>0,"update_time"=>time()));

			if ($r) {
				
				$result = $this->submitorder($device_id);
				if ($result) {
					echo '{"status":1,"关门成功"}';
				}else{
					echo '{"status":0,"关门失败"}';
				}

				return ;
			}
		}else{
			echo '{"status":0,"没有需要关的门"}';
			return ;
		}
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

				return 0;

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
		if ($allnum==0) {
			return 0;
		}

		$order['goodsdetail'] = json_encode($goodsdetail);
		$order['allcount'] = $allcount;
		$order['allnum'] = $allnum;
		$order['shop_id'] = $shop_id;
		$order['device_id'] = $device_id;

		return $order;

   	}

	public function submitorder($device_id=''){

		$res = $this->getgoods($device_id);
		// var_dump($res);return;
		// 确定顾客拿货了，订单可以入库
		if ($res) {
			
			// 根据当前设备ID号，确定是哪个用户的订单

			$uid = M("devicelog")->where("device_id = '".$device_id."'")->order("add_time desc")->limit(1)->find()['uid'];

			if ($uid) {

				$res['uid'] = $uid;

				//生成订单号
				$res['sn'] = $this->getsn();

				//订单生成时间
				$res['add_time'] = time();

				//订单更新时间
				$res['update_time'] = time();

				M("order")->create($res);
				$r = M("order")->add($res);

				// 订单入库成功，跳转到订单详情界面，下一步，发起支付
				if ($r) {

					//清空货板的拿货状态
					$boardinfo = M("board")->where("device_id = '".$device_id."'")->find();
					if ($boardinfo['new_status']) {
						
						$res = M("board")->where("device_id = '".$device_id."'")->save(array("goods_status"=>$boardinfo['new_status'],"new_status"=>""));
						
						if ($res) {
							// 统计货品库存
							$this->stock($boardinfo['new_status']);
							return $r;
						}
					}
				}else{
					return 0;
				}

			}else{
				return 0;
			}
		}else if($res == 0){
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

	// {"1":{"20":"1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1"},"2":null,"3":null,"4":null,"5":null,"6":null,"7":null,"8":null,"9":null,"10":null,"11":null,"12":null,"13":null,"14":null,"15":null,"16":null,"17":null,"18":null}
	/**
	 * 关门后统计商品库存
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

	 //配置商品调用
    public function setgoodslists($shop_id=''){
        // var_dump($_GET);return ;
        //获取所有商品列表
        $goods  = M("Goods");

        $where = "1";

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

    //获取post过来的数据
    public function getPost(){
        return file_get_contents('php://input');
    }

    public function XmlToArr($xml){	
        if($xml == '') return '';
        libxml_disable_entity_loader(true);
        $arr = json_decode(json_encode(simplexml_load_string($xml, 'SimpleXMLElement', LIBXML_NOCDATA)), true);		
        return $arr;
    }

     //生成签名
    public function getSign($arr){
        //去除空值
        $arr = array_filter($arr);
        if(isset($arr['sign'])){
            unset($arr['sign']);
        }
        //按照键名字典排序
        ksort($arr);
        //生成url格式的字符串
       $str = $this->arrToUrl($arr) . '&key=be0cddd847727f9faea486ae61c98ec7';
       return strtoupper(md5($str));
    }

    public function arrToUrl($arr){
        return urldecode(http_build_query($arr));
    }
    //验证签名
    public function chekSign($arr){
        $sign = $this->getSign($arr);
        if($sign == $arr['sign']){
            return true;
        }else{
            return false;
        }
    }

    public function ArrToXml($arr){
        if(!is_array($arr) || count($arr) == 0) return '';

        $xml = "<xml>";
        foreach ($arr as $key=>$val)
        {
                if (is_numeric($val)){
                        $xml.="<".$key.">".$val."</".$key.">";
                }else{
                        $xml.="<".$key."><![CDATA[".$val."]]></".$key.">";
                }
        }
        $xml.="</xml>";
        return $xml; 
    }

    public function notify(){
		$xmlData = $this->getPost();
        $arr = $this->XmlToArr($xmlData);
        $this->logs("notifyinfo.txt",json_encode($arr));
        if($this->chekSign($arr)){
            if($arr['return_code'] == 'SUCCESS' && $arr['result_code'] == 'SUCCESS'){
                //生产环境需要根据订单号来查询价格
                // 查询订单详情，对比交易金额是否正确
                // 处理订二维码支付结果
                if($arr['trade_type'] == 'NATIVE'){
                	$user = M("user");
	                $order = M("order");
	                $userinfo = $user->where("openid = '".$arr['openid']."'")->find();
	                $saveres = $order->where("sn = '".$arr['out_trade_no']."'")->save(array("uid"=>$userinfo['uid']));
                }
                $orderinfo = M("order")->where("sn = '".$arr['out_trade_no']."'")->find();

                // 订单支付成功，进行财务统计入库
                $finance = M("finance");
				$goods = json_decode($orderinfo['goodsdetail'],true);
				foreach ($goods as $k => $v) {
					$v['order_id'] = $orderinfo['order_id'];
					$finance->add($v);
				}

                if($arr['total_fee'] == $orderinfo['allcount']*100){
                    $this->logs('stat.txt', '订单号：'.$arr['out_trade_no'].';状态：交易成功!'); 
                    //更改订单状态
                    $res = M("order")->where("sn = ".$arr['out_trade_no'])->save(array("status"=>1));
                    if ($res) {
                    	$this->logs('stat.txt', '订单号：'.$arr['out_trade_no'].';订单状态修改成功!');
                    }else{
                    	$this->logs('stat.txt', '订单号：'.$arr['out_trade_no'].';订单状态修改失败!');
                    }

                    $returnParams = [
                        'return_code' => 'SUCCESS',
                        'return_msg'  => 'OK'
                    ];
                    echo $this->ArrToXml($returnParams);
                }else{
                    $this->logs('stat.txt', '订单号：'.$arr['out_trade_no'].';金额有误!');
                }
            }else{
                $this->logs('stat.txt', '订单号：'.$arr['out_trade_no'].';业务结果不正确!');
            }
        }else{
            $this->logs('stat.txt', '订单号：'.$arr['out_trade_no'].';签名失败!');
        }
	}

	public function logs($filename,$data){
		$time = date("Y-m-d H:i:s",time());
        file_put_contents('./logs/' . $filename,$time."----". $data."\r\n", FILE_APPEND);
    }
// {"20":{"shopgoods_id":20,"goods_name":"\u57fa\u5730\u867e\u4ec1","cost":"5.00","cell_price":"6.00","num":3,"small_count":18},"23":{"shopgoods_id":23,"goods_name":"\u6d77\u9c88\u9c7c","cost":"323.00","cell_price":"324.00","num":3,"small_count":972}}
    /**
	 * 用户结算
	 * @param  string $mark [标签]
	 * @return [type]       [description]
	 */
	public function balance($mark=''){
		// echo $mark;exit;
		!empty($mark) or die('{"status":0,"msg":"缺少参数"}');
		$markarr = explode(",",$mark);
		$mark = "1";
		foreach ($markarr as $k => $v) {
			$mark .= ",'".$v."'";
		}
		$frdgoods = M("frdgoods");
		// echo $mark;
		$frdgoodslists = $frdgoods->table("mk_frdgoods as fg")
								->join("right join mk_shopgoods sg on sg.shopgoods_id = fg.shopgoods_id")
								->field("fg.shopgoods_id,sg.goods_name,fg.cost,fg.cell_price,count(*) num,sum(fg.cell_price) small_count,sg.shop_id")
								->where("fg.mark in (".$mark.")")
								->group("fg.shopgoods_id")
								->select();
		$allnum = 0;
		$allcount = 0;
		$shop_id = $frdgoodslists[0]['shop_id'];
		foreach ($frdgoodslists as $k => $v) {
			
			$frdgoodslists[$v['shopgoods_id']] = $v;
			unset($frdgoodslists[$k]);
			$allnum += $v['num'];
			$allcount += $v['small_count'];
		}

		// echo "店铺ID号".$shop_id;
		// echo "数量总计".$allnum;
		// echo "价格总计".$allcount;
		// var_dump($frdgoodslists);
		// echo json_encode($frdgoodslists);
		// $allcount = 0.01;
		// 先把订单信息入库
		$order = M("order");
		$sn = $this->getSn();
		$data = [
			"sn"		=>$sn,
			"allcount"	=>$allcount,
			"allnum"	=>$allnum,
			"add_time"	=>time(),
			"update_time"=>time(),
			"shop_id"	=>$shop_id,
			"goodsdetail"=>json_encode($frdgoodslists),
			"from"		=>1,
		];
		$data = $order->create($data);
		$addres = $order->add($data);

		if($addres){
			$saveres = $frdgoods->where("mark in (".$mark.")")->save(array("status"=>0));
			$res = $this->unifiedorder($sn,$allcount*100);
			echo '{"status":1,"code_url":"'.$res['code_url'].'"}';
			return ;
		}else{
			echo '{"status":0,"msg":"订单提交失败"}';
			return ;
		}
		
	}

	//调用统一下单api
    public function unifiedOrder($sn='',$total_fee=''){
        /**
         * 1.构建原始数据
         * 2.加入签名
         * 3.将数据转换为XML
         * 4.发送XML格式的数据到接口地址
         */
        $params = [
            'appid'=> $this->APPID,
            'mch_id'=> $this->MCHID,
            'nonce_str'=>md5(time()),
            'body'=>'百汇优惠多',
            'out_trade_no'=>$sn,
            'total_fee'=> $total_fee,
            'spbill_create_ip'=>$_SERVER['REMOTE_ADDR'],
            'notify_url'=> 'http://dlwfd.cc/index.php/Admin/Showpage/notify',
            'trade_type'=>'NATIVE',
        ];
       $params = $this->setSign($params); 
       $xmldata = $this->ArrToXml($params);
       $this->logs('log.txt', $xmldata);
       $resdata = $this->postXml($this->UNURL, $xmldata);
       $arr = $this->XmlToArr($resdata);
       return $arr;
    }

    //获取带签名的数组
    public function setSign($arr){
        $arr['sign'] = $this->getSign($arr);;
        return $arr;
    }

    // 发送XML格式的数据到接口地址
    public function postXml($url,$postfields){
        $ch = curl_init();
        $params[CURLOPT_URL] = $url;    //请求url地址
        $params[CURLOPT_HEADER] = false; //是否返回响应头信息
        $params[CURLOPT_RETURNTRANSFER] = true; //是否将结果返回
        $params[CURLOPT_FOLLOWLOCATION] = true; //是否重定向
        $params[CURLOPT_POST] = true;
        $params[CURLOPT_POSTFIELDS] = $postfields;
        $params[CURLOPT_SSL_VERIFYPEER] = false;
        $params[CURLOPT_SSL_VERIFYHOST] = false;
        curl_setopt_array($ch, $params); //传入curl参数
        $content = curl_exec($ch); //执行
        curl_close($ch); //关闭连接
        return $content;
    }

}
?>