<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
	body{
	    background: #f5f5f5;
	    margin-top:20px;
	}
	
	.ui-w-80 {
	    width: 100px !important;
	    height: auto;
	}
	
	.btn-default {
	    border-color: rgba(24,28,33,0.1);
	    background: rgba(0,0,0,0);
	    color: #4E5155;
	}
	
	label.btn {
	    margin-bottom: 0;
	}
	
	.btn-outline-primary {
	    border-color: #26B4FF;
	    background: transparent;
	    color: #26B4FF;
	}
	
	.btn {
	    cursor: pointer;
	}
	
	.text-light {
	    color: #babbbc !important;
	}
	
	.btn-facebook {
	    border-color: rgba(0,0,0,0);
	    background: #3B5998;
	    color: #fff;
	}
	
	.btn-instagram {
	    border-color: rgba(0,0,0,0);
	    background: #000;
	    color: #fff;
	}
	
	.card {
	    background-clip: padding-box;
	    box-shadow: 0 1px 4px rgba(24,28,33,0.012);
	}
	
	.row-bordered {
	    overflow: hidden;
	}
	
	.account-settings-fileinput {
	    position: absolute;
	    visibility: hidden;
	    width: 1px;
	    height: 1px;
	    opacity: 0;
	}
	.account-settings-links .list-group-item.active {
	    font-weight: bold !important;
	}
	html:not(.dark-style) .account-settings-links .list-group-item.active {
	    background: transparent !important;
	}
	.account-settings-multiselect ~ .select2-container {
	    width: 100% !important;
	}
	.light-style .account-settings-links .list-group-item {
	    padding: 0.85rem 1.5rem;
	    border-color: rgba(24, 28, 33, 0.03) !important;
	}
	.light-style .account-settings-links .list-group-item.active {
	    color: #4e5155 !important;
	}
	.material-style .account-settings-links .list-group-item {
	    padding: 0.85rem 1.5rem;
	    border-color: rgba(24, 28, 33, 0.03) !important;
	}
	.material-style .account-settings-links .list-group-item.active {
	    color: #4e5155 !important;
	}
	.dark-style .account-settings-links .list-group-item {
	    padding: 0.85rem 1.5rem;
	    border-color: rgba(255, 255, 255, 0.03) !important;
	}
	.dark-style .account-settings-links .list-group-item.active {
	    color: #fff !important;
	}
	.light-style .account-settings-links .list-group-item.active {
	    color: #4E5155 !important;
	}
	.light-style .account-settings-links .list-group-item {
	    padding: 0.85rem 1.5rem;
	    border-color: rgba(24,28,33,0.03) !important;
	}
	#final {
		float: right;
	}
	#pagingArea{width:fit-content;margin:auto;}
  </style>
</head>

<body>

	<jsp:include page="../common/menubar.jsp"/>
	
    <div id="app">        
        <div id="main">

            <div class="container light-style flex-grow-1 container-p-y">
		    <h2 class="font-weight-bold py-3 mb-4">
		      ??????????????????
		    </h2>

		    <div class="card overflow-hidden">
		      <div class="row no-gutters row-bordered row-border-light">
		        <div class="col-md-3 pt-0">
		          <div class="list-group list-group-flush account-settings-links">
		            <a class="list-group-item list-group-item-action" data-toggle="list" href="managerpageForm">??????????????????</a>
		            <a class="list-group-item list-group-item-action" data-toggle="list" href="updateMPwdForm">??????????????????</a>
		            <a class="list-group-item list-group-item-action active" data-toggle="list" href="jdForm">??????/????????????</a>
		          	<a class="list-group-item list-group-item-action" data-toggle="list" href="managerAttendance">????????????</a>
		          </div>
		        </div>
		        
		        <div class="col-md-9">
		          <div class="tab-content">
		            <section class="section">
                    <div class="row" id="table-hover-row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-content mt-5">
                                    <!-- table hover -->
                                    <div class="table-responsive">
                                    	<div class="form-group mt-3">
				                       	    <select class="choices form-select" id="jd" name="jd" style="width:100px;">
				                               <option value="1">??????</option>
				                               <option value="2">??????</option>
				                           	</select>
				                         </div>
                                        <table id="jdList" class="table table-borderless mb-0" style="width:90%;"> <!--  -->
                                            <tbody id="here">	

                                            </tbody>
                                            <tfoot>
                                            	<tr>
								                	<td></td>
								                	<td><input type="text" class="form-control" placeholder="?????? ??????" id="ip" name="ip"></td>
								                	<td><button type="button" class="btn btn-primary" id="plus">??????</button></td>
								            	</tr>
                                            </tfoot>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                	</section>
		      		</div>
		   	 	</div>
		 	</div>
    		</div>
    		</div>
        </div>
    </div>
    <c:if test="${ !empty msg }">
		<script>
			alert("${msg}");
		</script>
		<c:remove var="msg" scope="session"/>
	</c:if>
    
    <script>

    	$(function(){   	
    		
    		selectJdList();
    		
       	});
    	
    	
    	function selectJdList(set){

			$.ajax({
				url:"selectJdList",
				type:"post",
				data:{
					set:set
				},
				success:function(result){

					$('#jd').val(result.set).prop("selected",true);
					
					let v = "";
					let index = 1;
					for(var i in result.list) {
						
						if(result.set == 1) {
							v+= '<tr>'+
			                        '<td style="width:10%;">'+parseInt(index)+'</td>'+
			                        '<td style="width:50%;"><input type="text" class="form-control" value ='+result.list[i].jname+' id="na" name="na"></td>'+
			                        '<td style="width:15%;"><button type="button" class="btn btn-danger" name="minus">??????</button>&nbsp;<button type="button" class="btn btn-secondary" name="update">??????</button></td>'+
			                        '<td style="width:5%;"><input type="hidden" class="form-control" value ='+result.list[i].jname+' id="ori" name="ori"></td>'+
		                		'</tr>';
				                index++;
						} else {
							v+= '<tr>'+
			                        '<td style="width:10%;">'+parseInt(index)+'</td>'+
			                        '<td style="width:50%;"><input type="text" class="form-control" value ='+result.list[i].dname+' id="na" name="na"></td>'+
			                        '<td style="width:15%;"><button type="button" class="btn btn-danger" name="minus">??????</button>&nbsp;<button type="button" class="btn btn-secondary" name="update">??????</button></td>'+
			                        '<td style="width:5%;"><input type="hidden" class="form-control" value ='+result.list[i].dname+' id="ori" name="ori"></td>'+
		                		'</tr>';
				                index++;
						}
						
					}
					$("#here").html(v);
					
					$('[name="minus"]').on('click', function() { 
		
		    			let tr = $(this).closest('tr'); // ???????????? ??? tr 
		    			let del = tr.find('td:eq(1)').find('input').val();  // tr??? 2?????? ?????? input
		    			value = $("#jd").val();
		    		   	console.log(del)
		    			$.ajax({
		    				url:"deletejd",
		    				type:"post",
		    				data:{
		    					set:value,
		    					del:del
		    				},
		    				success:function(result){
		    					
		    					if(result == 1) {
		    						selectJdList(value);
		    						alert("?????? ?????? ??????");
		    					} else {
		    						alert("??????/?????? ?????? ??????");
		    					}
		    					
		    				},
		    				error:function(){
		    					console.log("??????????????? ?????? ajax ?????? ??????");
		    				}
		    			});

		    		})
		    		
		    		$('[name="update"]').on('click', function() { 

		    			let tr = $(this).closest('tr'); // ???????????? ??? tr 
		    			let ori = tr.find('td:eq(3)').find('input').val(); // tr??? 2?????? ?????? ????????????
		    			let ins = tr.find('td:eq(1)').find('input').val(); // tr??? 3?????? ?????? ????????????
		    			value = $("#jd").val();
		    		   	
		    			$.ajax({
		    				url:"updatejd",
		    				type:"post",
		    				data:{
		    					set:value,
		    					ori:ori,
		    					upd:ins
		    				},
		    				success:function(result){
		    					
		    					if(result == 1) {
		    						selectJdList(value);
		    						alert("?????? ?????? ??????");
		    					} else {
		    						alert("??????/?????? ?????? ??????");
		    					} 
		    					
		    				},
		    				error:function(data){
		    					if(data.responseText == "??????") {
		    						selectJdList(value);
		    						alert("????????? ??????????????? ????????? ???????????????");
		    					}
		    					console.log("??????????????? ?????? ajax ?????? ??????");
		    				}
		    			});
		    				
		    		 	
		    		})
					
					
					
				},
				error:function(){
					console.log("??????????????? ?????? ajax ?????? ??????");
				}
			});
				
		}
    	
    	let value = "";
    	$("#jd").change(function(){
    		value = $(this).val();
    		selectJdList(value);
    	})
    	
    	$("#plus").on('click', function() { 
    		
   			let tr = $(this).closest('tr'); // ???????????? ??? tr 
   			let ins = tr.find('td:eq(1)').find('input').val(); // tr??? 2?????? input val
   			val = $("#jd").val();
   			
   			$.ajax({
   				url:"insertjd",
   				type:"post",
   				data:{
   					set:val,
   					ins:ins
   				},
   				success:function(result){
   					console.log("==="+result)
   					if(result == 1) {
   						selectJdList(val);
   						alert("?????? ?????? ??????");
   					} else {
   						alert("??????/?????? ?????? ??????");
   					}
   					$("#ip").val("");

   				},
   				error:function(data){
   					if(data.responseText == "??????") {
   						tr.find('td:eq(1)').find('input').val("");
						alert("????????? ??????????????? ????????? ???????????????");
					}
   					console.log("??????/?????? ?????? ajax ?????? ??????");
   				}
			});
   		})

    </script>
    
</body>

</html>