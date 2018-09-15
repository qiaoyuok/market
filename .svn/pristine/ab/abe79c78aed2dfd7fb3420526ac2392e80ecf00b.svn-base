<?php 

namespace Admin\Controller;

/**
* 店铺管理员操作类
*/
class ShopapiController extends ShopbaseController{
	
	/**
	 * 获取店铺商品列表
	 * @param  string $uid 		[用户ID号]
	 * @param  string $page 	[第几页]
	 * @param  string $limit 	[每页条数]
	 * @return [type]      [description]
	 */
	public function index($uid='',$page='',$limit=''){
		
		!empty($uid) or die('{"status":0,"msg":"缺少参数"}');

		$ucenter_member = M("ucenter_member");
		$userinfo = $ucenter_member->where("id = ".$uid)->find();
		if($userinfo){
			$shop_id = $userinfo['shop_id'];

			$shopgoods = M("shopgoods");
			$page = empty($page)?1:$page;
			$limit = empty($limit)?5:$limit;
			$shopgoodslists = $shopgoods->field("goods_name,shopgoods_id")->where("shop_id = ".$shop_id)->page($page)->limit($limit)->select();
			$count = $shopgoods->where("shop_id = ".$shop_id)->count();
			echo '{"status":1,"data":'.json_encode($shopgoodslists).',"count":'.$count.'}';
			return ;
		}else{
			die('{"status":0,"msg":"用户不存在"}');
		}
	}

	/**
	 * 商家添加商品
	 * @param  string $cost       [进价]
	 * @param  string $cell_price [售价]
	 * @param  string $goods_id   [店铺商品ID号]
	 * @param  string $uid   	  [商品平台ID号]
	 * @param  string $mark 	  [标签]
	 * @return [type]             [description]
	 */
	public function addgoods($cost='',$cell_price='',$shopgoods_id='',$uid='',$mark=''){

		if(IS_POST){

			!empty($cost) or die('{"status":0,"msg":"进价不能为空"}');
			!empty($cell_price) or die('{"status":0,"msg":"售价不能为空"}');
			!empty($shopgoods_id) or die('{"status":0,"msg":"缺少参数"}');
			!empty($mark) or die('{"status":0,"msg":"缺少标签"}');

			$frdgoods = M("frdgoods");
			unset($_POST['token']);
			$_POST['create_time'] = time();
			$_POST['update_time'] = time();

			$data = $frdgoods->create($_POST);
			$addres = $frdgoods->add($data);
			if($addres){
				die('{"status":1,"msg":"添加成功"}');
			}else{
				die('{"status":0,"msg":"添加失败"}');
			}
		}
	}
}

















?>