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
		            <a class="list-group-item list-group-item-action active" data-toggle="list" href="managerpageForm">??????????????????</a>
		            <a class="list-group-item list-group-item-action" data-toggle="list" href="updateMPwdForm">??????????????????</a>
		            <a class="list-group-item list-group-item-action" data-toggle="list" href="jdForm">??????/????????????</a>
		          	<a class="list-group-item list-group-item-action" data-toggle="list" href="managerAttendance">????????????</a>
		          </div>
		        </div>
		        
		        <div class="col-md-9">
		          <div class="tab-content">
		            <section class="section">
                    <div class="row" id="table-hover-row">
                        <div class="col-12">
                            <div class="card">
                                
                                <h4 class="card-title mt-5">??????????????????</h4>    
                               
                                <div class="card-content mt-5">
                                    <!-- table hover -->
                                    <div class="table-responsive">
                                        <table id="memberList" class="table table-hover mb-0"> <!--  -->
                                            <thead>
                                                <tr>
                                                    <th>??????</th>
                                                    <th>??????</th>
                                                    <th>??????</th>
                                                    <th>??????</th>
                                                </tr>
                                            </thead>
                                            <tbody id="here">
                                            
                                            </tbody>
                                        </table><!--  -->
                                        <br>
                                        <div id="pagingArea">
							            </div>

							            <form class="searchArea" align="center" action="searchMemListForm" method="get" >
							            	<div id="searchcondition">
												<select id="condition" name="condition" style="height:38px">
										        	<option value="no" ${ (condition eq 'no') ? "selected" : "" }>??????</option>
										       		<option value="name" ${ (condition eq 'name') ? "selected" : "" }>??????</option>
										       		<option value="dept" ${ (condition eq 'dept') ? "selected" : "" }>??????</option>
										       		<option value="job" ${ (condition eq 'job') ? "selected" : "" }>??????</option>
										        </select>
										        <input type="search" id="search" name="search" value="${search}" placeholder=" ???? ????????? ??????" style="height:38px"/>
										        <button class="btn btn-secondary" type="submit">??????</button>
									        </div>
								  		</form>

                                        <div class="mt-3 mb-3 float-right" id="final">
											<button type="button" class="btn btn-primary" onclick="location.href='insertMemberForm'">????????????</button>
											&nbsp;  &nbsp; &nbsp;  &nbsp;
										</div>
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
    
		var pageNum = "";
		var con = "${condition}";
		var no = "${condition}";
		var name = "${condition}";
		var dept = "${condition}";
		var job = "${condition}";
		var sear = "${search}";
		
    	$(function(){
    	
    		searchMemList(pageNum, con, sear);
    		contionChange();
    		
    	});

    	
    	let fil = "";
    	function contionChange() {
			$('#condition').on('change', function () { // ???????????? ???????????????
				fil = $(this).val()
				let t = "";
				
			    if (fil == "dept") { // ?????? ?????????
			    	
			    	$.ajax({
						url:"selectSerach",
						type:"post",
						data:{
							condition: fil
						},
			
						success:function(result){
							console.log(result)
							t += '<select id="condition" name="condition" style="height:38px">'+
				        			'<option value="no">??????</option>'+
				       				'<option value="name">??????</option>'+
				       				'<option value="dept" selected>??????</option>'+
				       				'<option value="job">??????</option>'+
			        			'</select>'+
			        			'<select id="dept" name="search" style="height:38px; width:150px">';
				            for(var i in result) {
				            	t +=  '<option value="'+result[i].dName+'">'+result[i].dName+'</option>';
				            }    
		        			t += '</select>'+
		        				 '<button class="btn btn-secondary" type="submit">??????</button>';
	    					$("#searchcondition").html(t);
	    					contionChange();
						},
						error:function(){
							console.log("?????? ?????? ?????? ?????? ajax ?????? ??????");
						}
					});
	
			    	
			    } else if (fil == "job") { // ?????? ????????? 
			    	$.ajax({
						url:"selectSerach",
						type:"post",
						data:{
							condition: fil
						},
			
						success:function(result){
							console.log(result)
							t += '<select id="condition" name="condition" style="height:38px">'+
				        			'<option value="no">??????</option>'+
				       				'<option value="name">??????</option>'+
				       				'<option value="dept">??????</option>'+
				       				'<option value="job" selected>??????</option>'+
			        			'</select>'+
			        			'<select id="dept" name="search" style="height:38px; width:150px">';
				            for(var i in result) {
				            	t +=  '<option value="'+result[i].jName+'">'+result[i].jName+'</option>';
				            }
		        			t +=  '</select>'+
		        				  '<button class="btn btn-secondary" type="submit">??????</button>';
	    					$("#searchcondition").html(t);
	    					contionChange();
						},
						error:function(){
							console.log("?????? ?????? ?????? ?????? ajax ?????? ??????");
						}
					});
			    
			    } else if (fil == "no"){
			    	t += '<select id="condition" name="condition" style="height:38px">'+
		        			'<option value="no" selected>??????</option>'+
		       				'<option value="name">??????</option>'+
		       				'<option value="dept">??????</option>'+
		       				'<option value="job">??????</option>'+
		    			'</select>'+
		    			'<input type="search" id="search" name="search" value="" placeholder=" ???? ????????? ??????" style="height:38px"/>'+
						'<button class="btn btn-secondary" type="submit">??????</button>';
					$("#searchcondition").html(t);
					contionChange();
			    } else {
			    	t += '<select id="condition" name="condition" style="height:38px">'+
		        			'<option value="no">??????</option>'+
		       				'<option value="name" selected>??????</option>'+
		       				'<option value="dept">??????</option>'+
		       				'<option value="job">??????</option>'+
		    			'</select>'+
		    			'<input type="search" id="search" name="search" value="" placeholder=" ???? ????????? ??????" style="height:38px"/>'+
						'<button class="btn btn-secondary" type="submit">??????</button>';
					$("#searchcondition").html(t);
					contionChange();
			    }
			   
			});
    	}
    	

    	function searchMemList(pageNum, con, sear){
			console.log(no)
    		$.ajax({
				url:"searchMemList",
				type:"get",
				data:{
					page: pageNum,
					condition: con,
					search: sear
				},
	
				success:function(result){

					let v= '';
					let b = '';
		            let page = result.page; // ???????????????
		            let startpage = result.startpage; // ???????????????
		            let endpage = result.endpage; // ????????????
		            let maxpage = result.maxpage; // ???????????????
		            let c = result.c;
		           	let s = result.s;

		           	if(result.list.length == 0) {
		           		v += '<tr align="center">'+
		                        '<td colspan=4>??????????????? ????????????</td>'+
		                    '</tr>';
		           	}

		            for(var i in result.list) {
		            	
		            	if(result.list[i].mwork == 'Y') {
		            		v+= '<tr>'+
			                        '<td>'+result.list[i].mno+'</td>'+
			                        '<td>'+result.list[i].mname+'</td>'+
			                        '<td>'+result.list[i].jname+'</td>'+
			                        '<td>'+result.list[i].dname+'</td>'+
			                    '</tr>';
		            	} else {
		            		v+='<tr>'+
			                       '<td style="background-color:gray; color:white;">'+result.list[i].mno+'</td>'+
			                       '<td style="background-color:gray; color:white;">'+result.list[i].mname+'</td>'+
			                       '<td style="background-color:gray; color:white;">'+result.list[i].jname+'</td>'+
			                       '<td style="background-color:gray; color:white;">'+result.list[i].dname+'</td>'+
			                   '</tr>';
		            	}

		            }
					$("#here").html(v);
					
					b += '<ul class="pagination">';
					if(page != 1) {
						b += '<li class="page-item"><a class="page-link" onclick="searchMemList('+ parseInt(page-1) +','+c+','+s+');" class="page-btn">Previous</a></li>'
					} else {
						b += '<li class="page-item disabled"><a class="page-link" href="">Previous</a></li>'
					}
                	
                	for(var num = startpage; num <= endpage; num++) {
                		if(num != page) {
                			b += '<li class="page-item"><a class="page-link" onclick="searchMemList('+ num + ','+c+','+s+');" class="page-btn">'+num+'</a></li>'
                		} else {
                			b += '<li class="page-item disabled"><a class="page-link" href="">'+num+'</a></li>'
                		}
                	}
                    
                	if(page != maxpage) {
						b += '<li class="page-item"><a class="page-link" onclick="searchMemList('+ parseInt(page+1) + ','+c+','+s+');" class="page-btn">Next</a></li>'
					} else {
						b += '<li class="page-item disabled"><a class="page-link" href="">Next</a></li>'
					}
                    
                	b += '</ul>';
                	
					$("#pagingArea").html(b);
					
					$("#memberList tbody tr").click(function(){
		    			location.href="detailMember?mNo=" + $(this).children().eq(0).text();
		    		});
				},
				error:function(){
					console.log("??????????????? ?????? ajax ?????? ??????");
				}
			});
    		
    	}
    </script>
    
</body>

</html>