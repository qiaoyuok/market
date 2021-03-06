<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------
namespace Admin\Controller;
use Think\Controller;

class BuyController extends Controller {


    private $APPID = "wx1c91409262d23ffb";
    private $AppSecret = "b345900fab24f72f221e820552cfc135";
    private $KEY = 'be0cddd847727f9faea486ae61c98ec7';
    private $MCHID = '1499192412';
    private $UNURL = 'https://api.mch.weixin.qq.com/pay/unifiedorder';

    /**
     * 校验用户是否登录，没有登陆则自动登录
     */
    protected function _initialize(){

        // 如果说当前用户没有登陆，则去登陆
        if (empty($_SESSION['log']['uid'])) {

            // 获取用户信息
            $this->getUserInfo();
            
            // 用户登录
            $this->login();
        }

        // 校验用户信息

        $userinfo = M("user")->where("uid = ".$_SESSION['log']['uid'])->find();
        if ($userinfo) {

            switch($userinfo['status']){

                // 会员状态含义    0：默认状态，未提交认证信息；1：提交了认证信息，待审核；2：审核通过；3：审核不通通过；4：被拉黑
                case 3:
                    $this->show('<header><meta charset="utf-8"><title>提示信息</title><meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" /></header><div><p style="margin-top:150px;text-align:center;color:red;">用户信息审核不通过，请检查！</p></div>');
                    exit;

                case 4:
                    $this->show('<header><meta charset="utf-8"><title>提示信息</title><meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" /></header><div><p style="margin-top:150px;text-align:center;color:red;">该用户已被拉黑！</p></div>');
                    exit;
            }
        }
    }

    // 获取用户信息，存储用户标志信息至session
    public function getUserInfo(){
        $redirect_uri = 'http://dlwfd.cc'.$_SERVER['PHP_SELF'].'?'.$_SERVER['QUERY_STRING'];
        if (!isset($_GET['code'])){
            $url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=".$this->APPID."&redirect_uri=".$redirect_uri."&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect";
            header("Location: ".$url);
        }else{
            
            $code = $_GET['code'];

            $get_token_url = 'https://api.weixin.qq.com/sns/oauth2/access_token?appid='.$this->APPID.'&secret='.$this->AppSecret.'&code='.$code.'&grant_type=authorization_code';
            $ch = curl_init();
            curl_setopt($ch,CURLOPT_URL,$get_token_url); 
            curl_setopt($ch,CURLOPT_HEADER,0); 
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1 ); 
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
            curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 10); 
            $res = curl_exec($ch);
            curl_close($ch);
            $access_token_info = json_decode($res,true);
            // var_dump($access_token);
            // 获取用户信息
            $get_token_url = 'https://api.weixin.qq.com/sns/userinfo?access_token='.$access_token_info['access_token'].'&openid='.$access_token_info['openid'].'&lang=zh_CN';
            $ch = curl_init();
            curl_setopt($ch,CURLOPT_URL,$get_token_url); 
            curl_setopt($ch,CURLOPT_HEADER,0); 
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1 ); 
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
            curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 10); 
            $res = curl_exec($ch); 
            curl_close($ch);
            $json_obj = json_decode($res,true);
            $_SESSION['log']['nickname'] = $json_obj["nickname"];
            $_SESSION['log']['headimgurl'] = $json_obj["headimgurl"];
            $_SESSION['log']['openid'] = $json_obj["openid"];
        }
    }

    // 用户登录
    public function login(){
        $userinfo = $_SESSION['log'];
        $openid = $userinfo['openid'];
        // var_dump($_SESSION['log']);
        if (!empty($openid)) {
            $user = M("user");
            $res = $user->where("openid = '".$openid."'")->find();
            // 判断该微信用户是否已存在，不存在的话进行入库操作
            if ($res) {

                // 设定登录态标志
                $_SESSION['log']['uid'] = $res['uid'];
                
            }else{
                // 用户不存在先加入数据库
                $data['headimgurl'] = $userinfo['headimgurl'];
                $data['nickname'] = $userinfo['nickname'];
                $data['openid'] = $userinfo['openid'];
                $uid = $user->add($data);   //添加到member数据表
                if ($uid) {
                    // 设定登录态标志
                    $_SESSION['log']['uid'] = $uid;
                }
            }
        }   
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
       $str = $this->arrToUrl($arr) . '&key=' . $this->KEY;
       return strtoupper(md5($str));
    }

    //获取带签名的数组
    public function setSign($arr){
        $arr['sign'] = $this->getSign($arr);;
        return $arr;
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

     //获取openid
    public function getOpenId(){
        if(isset($_SESSION['log']['openid'])){
            return $_SESSION['log']['openid'];
        }else{
            $this->getUserInfo();
            return $_SESSION['log']['openid'];
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
            'trade_type'=>'JSAPI',
            'product_id'=>$sn,
            'openid'    => $this->getOpenId()
        ];
       $params = $this->setSign($params); 
       $xmldata = $this->ArrToXml($params);
       $this->logs('log.txt', $xmldata);
       $resdata = $this->postXml($this->UNURL, $xmldata);
       $arr = $this->XmlToArr($resdata);
       return $arr;
    }

    //获取prepayid
    public function getPrepayId($sn='',$total_fee=''){
        $arr = $this->unifiedOrder($sn,$total_fee);
        return $arr['prepay_id'];
    }

    //获取公众号支付所需要的json数据
    public function getJsParams($prepay_id){
        $params = [
            'appId' => $this->APPID,
            'timeStamp' =>"'".time()."'",
            'nonceStr' => md5(time()),
            'package' =>'prepay_id=' . $prepay_id,     
            'signType' =>'MD5',
        ];
        $params['paySign'] = $this->getSign($params);
        return json_encode($params);
    }

    //数组转xml
    public function ArrToXml($arr){
        if(!is_array($arr) || count($arr) == 0) return '';

        $xml = "<xml>";
        foreach ($arr as $key=>$val){
            if (is_numeric($val)){
                    $xml.="<".$key.">".$val."</".$key.">";
            }else{
                    $xml.="<".$key."><![CDATA[".$val."]]></".$key.">";
            }
        }
        $xml.="</xml>";
        return $xml; 
    }

    //xml转数组
    public function XmlToArr($xml){   
        if($xml == '') return '';
        libxml_disable_entity_loader(true);
        $arr = json_decode(json_encode(simplexml_load_string($xml, 'SimpleXMLElement', LIBXML_NOCDATA)), true);     
        return $arr;
    }

    // 保存日志
    public function logs($filename,$data){
        $time = date("Y-m-d H:i:s",time());
        file_put_contents('./logs/' . $filename,$time."----". $data."\r\n", FILE_APPEND);
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

    //获取post过来的数据
    public function getPost(){
        return file_get_contents('php://input');
    }
}
