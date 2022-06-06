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

<body style="background-color:#F0FFF0">

	<jsp:include page="../common/menubar.jsp"/>
	
    <div id="app">        
        <div id="main">

            <div class="container light-style flex-grow-1 container-p-y">
		    <h2 class="font-weight-bold py-3 mb-4">
		      관리자페이지
		    </h2>

		    <div class="card overflow-hidden">
		      <div class="row no-gutters row-bordered row-border-light">
		        <div class="col-md-3 pt-0">
		          <div class="list-group list-group-flush account-settings-links">
		            <a class="list-group-item list-group-item-action active" data-toggle="list" href="managerpageForm">전체사원조회</a>
		            <a class="list-group-item list-group-item-action" data-toggle="list" href="updateMPwdForm">비밀번호변경</a>
		            <a class="list-group-item list-group-item-action" data-toggle="list" href="jdForm">직급/부서관리</a>
		          	<a class="list-group-item list-group-item-action" data-toggle="list" href="managerAttendance">근태통계</a>
		          </div>
		        </div>
		        
		        <div class="col-md-9">
		          <div class="tab-content">
		            <section class="section">
                    <div class="row" id="table-hover-row">
                        <div class="col-12">
                            <div class="card">
                                
                                <h4 class="card-title mt-5">검색내역조회</h4>    
                               
                                <div class="card-content mt-5">
                                    <!-- table hover -->
                                    <div class="table-responsive">
                                        <table id="memberList" class="table table-hover mb-0"> <!--  -->
                                            <thead>
                                                <tr>
                                                    <th>사번</th>
                                                    <th>이름</th>
                                                    <th>직급</th>
                                                    <th>부서</th>
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
										        	<option value="no">사번</option>
										       		<option value="name">이름</option>
										       		<option value="dept">부서</option>
										       		<option value="job">직급</option>
										        </select>
										        <input type="search" id="search" name="search" value="" placeholder=" 🔎 검색어 입력" style="height:38px"/>
										        <button class="btn btn-secondary" type="submit">검색</button>
									        </div>
								  		</form>

                                        <div class="mt-3 mb-3 float-right" id="final">
											<button type="button" class="btn btn-primary" onclick="location.href='insertMemberForm'">사원추가</button>
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
	<!-- 
	<c:if test="${ !empty page} && ${ !empty condition} && ${ !empty search}">
		<script>
			let pageNumm = "${page}";
	   		let con = "${condition}";
			let sear = "${search}";
		</script>
   	</c:if> -->
    
    <script>

    	$(function(){
    		searchMemList(pageNumm, con, sear);
    		contionChange();
    		
    	});
    	
    	let fil = "";
    	function contionChange() {
			$('#condition').on('change', function () { // 검색필터 변경시마다
				fil = $(this).val()
				let t = "";
				
			    if (fil == "dept") { // 부서 선택시
			    	
			    	$.ajax({
						url:"selectSerach",
						type:"post",
						data:{
							condition: fil
						},
			
						success:function(result){
							console.log(result)
							t += '<select id="condition" name="condition" style="height:38px">'+
				        			'<option value="no">사번</option>'+
				       				'<option value="name">이름</option>'+
				       				'<option value="dept" selected>부서</option>'+
				       				'<option value="job">직급</option>'+
			        			'</select>'+
			        			'<select id="dept" name="search" style="height:38px; width:150px">';
				            for(var i in result) {
				            	t +=  '<option value="'+result[i].dName+'">'+result[i].dName+'</option>';
				            }    
		        			t += '</select>'+
		        				 '<button class="btn btn-secondary" type="submit">검색</button>';
	    					$("#searchcondition").html(t);
	    					contionChange();
						},
						error:function(){
							console.log("검색 조건 부서 선택 ajax 통신 실패");
						}
					});
	
			    	
			    } else if (fil == "job") { // 직급 선택시 
			    	$.ajax({
						url:"selectSerach",
						type:"post",
						data:{
							condition: fil
						},
			
						success:function(result){
							console.log(result)
							t += '<select id="condition" name="condition" style="height:38px">'+
				        			'<option value="no">사번</option>'+
				       				'<option value="name">이름</option>'+
				       				'<option value="dept">부서</option>'+
				       				'<option value="job" selected>직급</option>'+
			        			'</select>'+
			        			'<select id="dept" name="search" style="height:38px; width:150px">';
				            for(var i in result) {
				            	t +=  '<option value="'+result[i].jName+'">'+result[i].jName+'</option>';
				            }
		        			t +=  '</select>'+
		        				  '<button class="btn btn-secondary" type="submit">검색</button>';
	    					$("#searchcondition").html(t);
	    					contionChange();
						},
						error:function(){
							console.log("검색 조건 직급 선택 ajax 통신 실패");
						}
					});
			    
			    } else if (fil == "no"){
			    	t += '<select id="condition" name="condition" style="height:38px">'+
		        			'<option value="no" selected>사번</option>'+
		       				'<option value="name">이름</option>'+
		       				'<option value="dept">부서</option>'+
		       				'<option value="job">직급</option>'+
		    			'</select>'+
		    			'<input type="search" id="search" name="search" value="" placeholder=" 🔎 검색어 입력" style="height:38px"/>'+
						'<button class="btn btn-secondary" type="submit">검색</button>';
					$("#searchcondition").html(t);
					contionChange();
			    } else {
			    	t += '<select id="condition" name="condition" style="height:38px">'+
		        			'<option value="no">사번</option>'+
		       				'<option value="name" selected>이름</option>'+
		       				'<option value="dept">부서</option>'+
		       				'<option value="job">직급</option>'+
		    			'</select>'+
		    			'<input type="search" id="search" name="search" value="" placeholder=" 🔎 검색어 입력" style="height:38px"/>'+
						'<button class="btn btn-secondary" type="submit">검색</button>';
					$("#searchcondition").html(t);
					contionChange();
			    }
			   
			});
    	}
    	

    	function searchMemList(pageNum, con, sear){
    		console.log(pageNum) // 1
    		console.log(con)
    		console.log(sear)
    		$.ajax({
				url:"searchMemList",
				type:"post",
				data:{
					page: pageNum,
					condition: condition,
					search: search
				},
	
				success:function(result){
					console.log(result)
					let v= '';
					let b = '';
		            let page = result.page; // 현재페이지
		            let startpage = result.startpage; // 시작페이지
		            let endpage = result.endpage; // 끝페이지
		            let maxpage = result.maxpage; // 최대페이지

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
						b += '<li class="page-item"><a class="page-link" onclick="selectMemList('+ parseInt(page-1) + ');" class="page-btn">Previous</a></li>'
					} else {
						b += '<li class="page-item disabled"><a class="page-link" href="">Previous</a></li>'
					}
                	
                	for(var num = startpage; num <= endpage; num++) {
                		if(num != page) {
                			b += '<li class="page-item"><a class="page-link" onclick="selectMemList('+ num + ');" class="page-btn">'+num+'</a></li>'
                		} else {
                			b += '<li class="page-item disabled"><a class="page-link" href="">'+num+'</a></li>'
                		}
                	}
                    
                	if(page != maxpage) {
						b += '<li class="page-item"><a class="page-link" onclick="selectMemList('+ parseInt(page+1) + ');" class="page-btn">Next</a></li>'
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
					console.log("전체사원리스트 조회 ajax 통신 실패");
				}
			});
    		
    	}
    </script>
    
</body>

</html>