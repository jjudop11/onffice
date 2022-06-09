<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>부서보관함</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
button {
	background: none;
	outline: 0;
	border: 0;
}

.sideMenu {
	width: 250px;
	background-color: white;
	border-radius: 10px;
	padding: 20px;
	box-shadow: 0 10px 20px -10px DarkSeaGreen;
}

.content {
	min-width: 50%;
	width: 80%;
	max-width: 1000px;
	padding: 44px 30px;
	background-color: white;
	border-radius: 10px;
	margin-left: 10px;
	box-shadow: 0 10px 20px -10px DarkSeaGreen;
}

input[type="button"] {
	background: none;
	border: none;
}

.list-group-item {
	border-top: 0 none;
}

#uploadFile {
	width: 95%;
	height: 50px;
	border-radius: 30px;
	background: #435EBE;
	color: white;
	margin: auto;
	display: block;
	font-weight: bold;
}

div[class="search"] {
	display: inline-block;
	float: right;
}

input[id="search"] {
  width: 250px;
  border-radius: 10px;
  appearance: none; 
  padding: 0 15px;
  transition: all var(--dur) var(--bez);
  transition-property: width, border-radius;
  position: relative;
}
button[id="btnSearch"] {
  display: block;
  width: 80px; 
  height:40px;
  background:none;
  position: absolute;
  top: 175px;
  right: 40px;
  z-index: 1;
}
</style>
<script>
	$(function() {
		$('#myDeptFile').click(function() {
			if ($(this).val() == '▶ 내 드라이브') {
				$(this).val('▼ 내 드라이브');
			} else {
				$(this).val('▶ 내 드라이브');
			}
		});
	});
	$(function() {
		$('#DeptFile').click(function() {
			if ($(this).val() == '▶ 부서 드라이브') {
				$(this).val('▼ 부서 드라이브');
			} else {
				$(this).val('▶ 부서 드라이브');
			}
		});
	});
</script>
</head>
<body>
	<jsp:include page="../common/menubar.jsp" />
	<div id="app">
		<div id="main" style="display: flex;">
			<div class="sideMenu">
			    <!-- Start of GoJS sample code -->	    
			    <script src="/Onffice/src/main/webapp/resources/assets/js/GoJS.js"></script>
			    <script src="https://unpkg.com/gojs/release/go-debug.js"></script>
			    <button id="uploadFile">
					<span>+ 파일 업로드</span> <input type="file" multiple="multiple" style="display: none;">
				</button>
				<hr>
			    <div id="myDiagramDiv">
					<div id="allSampleContent">
				    
				    </div>
			    </div>
			    <script id="code">
			    const myDiagram = new go.Diagram("myDiagramDiv");
			    
			    // use a V figure instead of MinusLine in the TreeExpanderButton
			    go.Shape.defineFigureGenerator("ExpandedLine", (shape, w, h) => {
			      return new go.Geometry()
			            .add(new go.PathFigure(0, 0.25*h, false)
			                  .add(new go.PathSegment(go.PathSegment.Line, .5 * w, 0.75*h))
			                  .add(new go.PathSegment(go.PathSegment.Line, w, 0.25*h)));
			    });
			
			    // use a sideways V figure instead of PlusLine in the TreeExpanderButton
			    go.Shape.defineFigureGenerator("CollapsedLine", (shape, w, h) => {
			      return new go.Geometry()
			            .add(new go.PathFigure(0.25*w, 0, false)
			                  .add(new go.PathSegment(go.PathSegment.Line, 0.75*w, .5 * h))
			                  .add(new go.PathSegment(go.PathSegment.Line, 0.25*w, h)));
			    });
			
			    function init() {
			
			      // Since 2.2 you can also author concise templates with method chaining instead of GraphObject.make
			      // For details, see https://gojs.net/latest/intro/buildingObjects.html
			      const $ = go.GraphObject.make;  // for conciseness in defining templates
			
			      myDiagram =
			        $(go.Diagram, "myDiagramDiv",
			          {
			            allowMove: false,
			            allowCopy: false,
			            allowDelete: false,
			            allowHorizontalScroll: false,
			            layout:
			              $(go.TreeLayout,
			                {
			                  alignment: go.TreeLayout.AlignmentStart,
			                  angle: 0,
			                  compaction: go.TreeLayout.CompactionNone,
			                  layerSpacing: 16,
			                  layerSpacingParentOverlap: 1,
			                  nodeIndentPastParent: 1.0,
			                  nodeSpacing: 0,
			                  setsPortSpot: false,
			                  setsChildPortSpot: false
			                })
			          });
			
			      myDiagram.nodeTemplate =
			        $(go.Node,
			          { // no Adornment: instead change panel background color by binding to Node.isSelected
			            selectionAdorned: false,
			            // a custom function to allow expanding/collapsing on double-click
			            // this uses similar logic to a TreeExpanderButton
			            doubleClick: (e, node) => {
			              var cmd = myDiagram.commandHandler;
			              if (node.isTreeExpanded) {
			                if (!cmd.canCollapseTree(node)) return;
			              } else {
			                if (!cmd.canExpandTree(node)) return;
			              }
			              e.handled = true;
			              if (node.isTreeExpanded) {
			                cmd.collapseTree(node);
			              } else {
			                cmd.expandTree(node);
			              }
			            }
			          },
			          $("TreeExpanderButton",
			            { // customize the button's appearance
			              "_treeExpandedFigure": "ExpandedLine",
			              "_treeCollapsedFigure": "CollapsedLine",
			              "ButtonBorder.fill": "whitesmoke",
			              "ButtonBorder.stroke": null,
			              "_buttonFillOver": "rgba(0,128,255,0.25)",
			              "_buttonStrokeOver": null
			            }),
			          $(go.Panel, "Horizontal",
			            { position: new go.Point(18, 0) },
			            new go.Binding("background", "isSelected", s => s ? "lightblue" : "white").ofObject(),
			            $(go.Picture,
			              {
			                width: 18, height: 18,
			                margin: new go.Margin(0, 4, 0, 0),
			                imageStretch: go.GraphObject.Uniform
			              },
			              // bind the picture source on two properties of the Node
			              // to display open folder, closed folder, or document
			              new go.Binding("source", "isTreeExpanded", imageConverter).ofObject(),
			              new go.Binding("source", "isTreeLeaf", imageConverter).ofObject()),
			            $(go.TextBlock,
			              { font: '9pt Verdana, sans-serif' },
			              new go.Binding("text", "key", s => "item " + s))
			          )  // end Horizontal Panel
			        );  // end Node
			
			      // without lines
			      myDiagram.linkTemplate = $(go.Link);
			
			      // // with lines
			      // myDiagram.linkTemplate =
			      //   $(go.Link,
			      //     { selectable: false,
			      //       routing: go.Link.Orthogonal,
			      //       fromEndSegmentLength: 4,
			      //       toEndSegmentLength: 4,
			      //       fromSpot: new go.Spot(0.001, 1, 7, 0),
			      //       toSpot: go.Spot.Left },
			      //     $(go.Shape,
			      //       { stroke: 'gray', strokeDashArray: [1,2] }));
			
			      // create a random tree
			      var nodeDataArray = [{ key: 0 }];
			      var max = 499;
			      var count = 0;
			      while (count < max) {
			        count = makeTree(3, count, max, nodeDataArray, nodeDataArray[0]);
			      }
			      myDiagram.model = new go.TreeModel(nodeDataArray);
			    }
			
			    function makeTree(level, count, max, nodeDataArray, parentdata) {
			      var numchildren = Math.floor(Math.random() * 10);
			      for (var i = 0; i < numchildren; i++) {
			        if (count >= max) return count;
			        count++;
			        var childdata = { key: count, parent: parentdata.key };
			        nodeDataArray.push(childdata);
			        if (level > 0 && Math.random() > 0.5) {
			          count = makeTree(level - 1, count, max, nodeDataArray, childdata);
			        }
			      }
			      return count;
			    }
			
			    // takes a property change on either isTreeLeaf or isTreeExpanded and selects the correct image to use
			    function imageConverter(prop, picture) {
			      var node = picture.part;
			      if (node.isTreeLeaf) {
			        return "images/document.svg";
			      } else {
			        if (node.isTreeExpanded) {
			          return "images/openFolder.svg";
			        } else {
			          return "images/closedFolder.svg";
			        }
			      }
			    }
			    window.addEventListener('DOMContentLoaded', init);
			  </script>
				
				<!-- <div>
					<button id="uploadFile">
						<span>+ 파일 업로드</span> <input type="file" multiple="multiple"
							style="display: none;">
					</button>
					<hr>
					<input type="button" id="myDeptFile" class="driveMenu"
						data-toggle="collapse" data-target="#myDept" value="▶ 내 드라이브">
					<div id="myDept" class="collapse">
						<a href="#" class="list-group-item list-group-item-action">Lorem</a>
					</div>
					<input type="button" id="DeptFile" class="driveMenu"
						data-toggle="collapse" data-target="#dept" value="▶ 부서 드라이브">
					<div id="dept" class="collapse">
						<a href="#" class="list-group-item list-group-item-action">Lorem</a>
					</div> 
				</div> -->
			</div>

			<div class="content">
				<table id="fileList" class="table table-hover" align="center">
					<thead style="display: flex;">
						<input type="checkbox" /> &nbsp;&nbsp;
						<button>다운로드</button> |
						<button>삭제</button> |
						<button data-bs-toggle="modal" data-bs-target="#moveFolder">이동</button> |
						<button data-bs-toggle="modal" data-bs-target="#addFolder">폴더 추가</button>
						<div class="search">
			            	<form method="GET" name="search" action="">
								<input type="text" name="keyword" id="search" placeholder="검색어 입력">
			            		<button type="submit" name="btnSearch" id="btnSearch"><i class="fa fa-search"></i></button></td>  	
							  	<input type="hidden" name="pageNum" value="1">
							  	<input type="hidden" name="amount" value="10">
							</form>
						</div>
					</thead>
					<hr>
					<tbody>
						<tr>
							<td style="padding-left: 30px; width: 75%;">파일 이름</td>
							<td style="width: 20%;">업로드일</td>
						</tr>
						<tr>
							<td><input type="checkbox" />파일1</td>
							<td>06-04</td>
						</tr>
					</tbody>
				</table>
				
				<div id="pagingArea" style="display: flex; justify-content: center;">
					<ul class="pagination">
						<c:choose>
							<c:when test="${ pi.currentPage ne 1 }">
								<li class="page-item"><a class="page-link"
									href="deptView.do?currentPage=${ pi.currentPage-1 }">Previous</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item disabled"><a class="page-link" href="">Previous</a></li>
							</c:otherwise>
						</c:choose>

						<c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
							<c:choose>
								<c:when test="${ pi.currentPage ne p }">
									<li class="page-item"><a class="page-link"
										href="deptView.do?currentPage=${ p }">${ p }</a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item disabled"><a class="page-link"
										href="">${ p }</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>


						<c:choose>
							<c:when test="${ pi.currentPage ne pi.maxPage }">
								<li class="page-item"><a class="page-link"
									href="deptView.do?currentPage=${ pi.currentPage+1 }">Next</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item disabled"><a class="page-link"
									href="deptView.do?currentPage=${ pi.currentPage+1 }">Next</a></li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="addFolder" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">폴더 추가</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<a style="padding: 0 10px;">폴더명 : </a><input type="text"
						placeholder="추가할 폴더명을 입력하시오." style="width: 80%;" />
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary">추가</button>
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="moveFolder" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">이동할 폴더 선택</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					뎅~
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary">이동</button>
					<button type="button" class="btn btn-secondary" data-bs-target="#addFolder" data-bs-toggle="modal" data-bs-dismiss="modal">폴더 추가</button>
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>