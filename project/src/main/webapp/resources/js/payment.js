

$(function () {

    $(".check_btn").click(function(){
        if ($("#detail_info").is(":hidden")) {
            $("#detail_info").slideDown("slow");
        }else {
            $("#detail_info").hide("slow");
        }
    });

    $("input[name='trademethod']").click(function(){
        var method = $(this).val();
       if(method == 'SC0040'){
           $('#section_escrow').show();
       }else{
           $('#section_escrow').hide();
       }
        $("#method").val(method);
    });
});


function getContextPath() {
	  var hostIndex = location.href.indexOf(location.host) + location.host.length;
	  return location.href.substring(hostIndex,location.href.indexOf('/', hostIndex + 1));
};

//매개변수 no 주문번호, tp = total_price
var point_check = function (no) {
    if (timecheck()) {
        alert('결제가 진행중입니다.');
        return;
    }

    var pt = new Array();
    var ptcnt = $("input[name=dispt]").size();
    var total_pt = 0;		//입력받을 포인트
    var usepoint='';   	//가지고 있는 포인트

	$.ajax({
     	url: getContextPath()+"/searchPoint",
        type: "post",
        data: "p_id="+"abcd",
        async: false,							//default : true, true일때 usepoint가 ''으로 유지됨
        success: function(data, textStatus){
			list = data;
			/* $('#result').empty(); */
			usepoint = list[0].point_rest;
			console.log(usepoint);
        },
        error: function(data, textStatus){
            alert("error");
        },
        complete:function(data, textSatus){  				
        }
    }); 
    
    for (i = 0; i < ptcnt; i++) {
        pt[i] = $("input[name=dispt]").eq(i).val();
        if (!pt[i]) pt[i] = 0;
        total_pt += parseInt(pt[i], 10);
    }

    var usedpoint = $("#ptsale").html().replace(' P', '').replace(/,/g, '');	//총 할인 내역에 적용된 point
    var targe_point = $('#dispt' + no).val();    //입력 받은 포인트    

    //입력 받은 포인트 > 보유 포인트 || 적용한 포인트 + 입력받은 포인트 > 보유포인트
    if (total_pt > usepoint || parseInt(usedpoint) + parseInt(targe_point) > usepoint) {
        alert('보유포인트를 초과하였습니다.');
        $('#dispt' + no).val('');
        console.log(no);
    }
}

//point 조회와 적용
var point_apply = function (no) {
    if (timecheck()) {
        alert('결제가 진행중입니다.');
        return;
    }

    var tp = $('#dispt' + no).val();

    if (tp < 100) {
        alert('100포인트 이상 사용 가능합니다.');
        return;
    }

    //order_num = {'point_over','re',rp,dp,tp,}
//    $.ajax({
//        url: "./payment/pay_process.php",
//        type: "POST",
//        dataType: "json",
//        data: {type: 'ptdis', no: no, tp: tp},
//        beforeSend: function () {
//            //loadingfn('load');
//        },
//        success: function (data) {
//            if (data.order_num == 'point_over') {
//                alert('강의가격보다 포인트 사용금액이 큽니다. 다시 확인해주세요.');
//                location.reload();
//            } else if (data.order_num == 're') {
//                alert('강의가격보다 포인트 사용금액이 큽니다. 다시 확인해주세요.');
//            } else {
//                $("#total_order_total em").text(data.rp);   // 총 주문금액
//                $("#sale_price_total em").text(data.dp);    // 할인 금액
//                $("#total_price_total em").text(data.tp);   // 할인 적용된 price
//                $("#ptsale").text(data.pdis);               // 총할인내역-point  
//                $("#cpsale").text(decodeURIComponent(data.cdis));  //쿠폰/할인 혜택 span
//                $("#pt" + no).html(decodeURIComponent(data.dis));   //point 입력 td
//                if (parseInt(data.preusept) < 0) {
//                    var pre_pt = 0;
//                } else {
//                    var pre_pt = data.preusept;
//                }
//                $("#preusept").text(pre_pt);  //예상 적립포인트
//
//            }
//        }
//    });
//    
    
    $.ajax({
    	url: getContextPath()+"/orderinfo",
        type: "POST",
        dataType: "json",
        data: {no: no, tp: tp},
        beforeSend: function () {
            //loadingfn('load');
        },
        success: function (data) {
        	
        	console.log(data);
            if (data[0].point_over == '0') {
                alert('강의가격보다 포인트 사용금액이 큽니다. 다시 확인해주세요.');
                location.reload();
            } else if (data[0].point_over == '0') {
                alert('강의가격보다 포인트 사용금액이 큽니다. 다시 확인해주세요.');
            } else {
            	console.log(data.dis);
                $("#sale_price_total em").text(data[0].discount_point);    	// 할인 금액, discount_point
                $("#total_price_total em").text(data[0].total_price);   	// 할인 적용된 total_price
                $("#ptsale").text(data[0].discount_point);               	// 총할인내역-point  
                $("#pt" + no).html(data[1].dis);   							// point 입력 table(td)
            }
        },
        error: function(data){
            alert("error");
        },
        complete:function(data){  				
        }
    });
    
}

var discount_cancel = function (no, type) {

    $.ajax({
        url: getContextPath()+"/discount_cancel",
        type: "POST",
        dataType: "json",
        data: {type: type, no: no},
        beforeSend: function () {
            //loadingfn('load');
        },
        success: function (data) {
        	console.log(data.dis);
            $("#sale_price_total em").text(data[0].discount_point);    	// 할인 금액, discount_point
            $("#total_price_total em").text(data[0].total_price);   	// 할인 적용된 total_price
            $("#ptsale").text(data[0].discount_point);               	// 총할인내역-point  
            $("#pt" + no).html(data[1].dis);   							// point 입력 table(td)
        }
    });
}

var timecheck = function () {
    var chk = $("#lgu").attr("src");
    return chk;
}
function onPopupClose(s) {
    $("#" + s).css("display", "none");
}
function onAddress() {
    $("#addressBox").css("display", "block");
    $("#address_search").focus();
}
var onAddresstSearch = function () {
    var ads = $("#address_search").val();

    $.ajax({
        url: "./common/popAddress.php",
        type: "POST",
        dataType: "json",
        data: {ads: ads},
        beforeSend: function () {
            //loadingfn('load');
        },
        success: function (data) {
            //alert(address);
            $("#addressList").html(decodeURIComponent(data.tbl));

        }
    });


}
function onAddressEnter() {
    if (event.keyCode == 13 || event.keyCode == 10) {
        onAddresstSearch()
    }
}
function onAddressSelect(zip, address) {
    $("#zip_1").val(zip);
    //$("#zip_2").val(zip.substr(3, 3));
    $("#address1").val(address);
    $("#address2").val('');

    $("#addressList").html("")
    $("#addressBox").css("display", "none")
}


let trade_flag = 0;
// 결제하기
var trade_select = function (no) {

    if(trade_flag == 1) {
        alert('결제정보를 등록하고 있습니다. \n잠시만 기다려주세요.');
        return;
    }

    var paynote_chk = $("#paynote_chk").val();

    if(!$("#check_refund").is(':checked') || !$("#check_payment").is(':checked') || (!$("#check_useguide").is(':checked') && paynote_chk) || !$("#check_contents").is(':checked')){
        alert("위 내용을 확인하셨을 경우 체크박스를 클릭해 주세요.");
        $("#check_contents").focus();
        return;
    }     

    var send = new Array();

    var method = $("input[name=trademethod]:checked").val();
    // 결제 방법이 선택되지 않았을 때
    if (!method) {
        alert('결제방법을 선택해주세요.');
        $("input[name=trademethod]").eq(0).focus();
        return;
    }
    payment(no);
    
}

var payment = function(no){

	var method = $("input[name=trademethod]:checked").val();

    if(!$("#check_contents").is(':checked')){
        alert("위 내용을 확인하셨을 경우 체크박스를 클릭해 주세요.");
        $("#check_contents").focus();
        return;
    }
    
    if(confirm('입력하신 결제 정보로 주문을 하시겠습니까? \n 확인을 누르시면, 안심클릭 승인을 위한 창이 뜹니다.')){
        if(method == 'kakao'){
        	var option = "width = 500, height = 500, top = 100, left = 100, location = yes";
        	
        	var form = document.createElement("form");
        	form.setAttribute("method","post");
        	form.setAttribute("action",getContextPath()+"/kakaoPay");
        	document.body.appendChild(form);
        	
        	var insert = document.createElement("input");
        	insert.setAttribute("type","hidden");
        	insert.setAttribute("name","order_id");
        	insert.setAttribute("value",no);
        	form.appendChild(insert);
        	
        	window.open('','new_popup', option);
        	form.setAttribute("target",'new_popup');
        	
        	form.submit();
        }
    }
}

function postPopUp() {
	
	var option = "width = 500, height = 500, top = 100, left = 100, location = yes";
	
	var form = document.createElement("form");
	form.setAttribute("method","post");
	form.setAttribute("action",getContextPath()+"/kakaoPay");
	document.body.appendChild(form);
	
	var insert = document.createElement("input");
	insert.setAttribute("type","hidden");
	insert.setAttribute("name","id");
	form.appendChild(insert);
	
	window.open('','new_popup', option);
	form.setAttribute("target",'new_popup');
	
	form.submit();
	
}







// ie version check
var ie_version_chk = function() {

    var word;
    var version = "N/A";

    var agent = navigator.userAgent.toLowerCase();
    var name = navigator.appName;

    // IE old version ( IE 10 or Lower )
    if ( name == "Microsoft Internet Explorer" ) {
        word = "msie ";
    }else {
        return false;
    }

    var reg = new RegExp( word + "([0-9]{1,})" );
    if ( reg.exec( agent ) != null ) {
        version = RegExp.$1 + RegExp.$2;
    }

    if(version < 10) {
        return true;
    }else{
        return false;
    }
}



