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
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
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
	transition: all var(- -dur) var(- -bez);
	transition-property: width, border-radius;
	position: relative;
}

button[id="btnSearch"] {
	display: block;
	width: 80px;
	height: 40px;
	background: none;
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
					<span>+ 파일 업로드</span> <input type="file" multiple="multiple"
						style="display: none;">
				</button>
				<hr>
				<div id="allSampleContent" class="p-4 w-full">
					<script id="code">
    function init() {

      // Since 2.2 you can also author concise templates with method chaining instead of GraphObject.make
      // For details, see https://gojs.net/latest/intro/buildingObjects.html
      const $ = go.GraphObject.make;

      myDiagram =
        $(go.Diagram, "myDiagramDiv",
          {
            // what to do when a drag-drop occurs in the Diagram's background
            mouseDrop: e => finishDrop(e, null),
            layout:  // Diagram has simple horizontal layout
              $(go.GridLayout,
                { wrappingWidth: Infinity, alignment: go.GridLayout.Position, cellSize: new go.Size(1, 1) }),
            "commandHandler.archetypeGroupData": { isGroup: true, category: "OfNodes" },
            "undoManager.isEnabled": true,
            // when a node is selected in the main Diagram, select the corresponding tree node
            "ChangedSelection": e => {
              if (myChangingSelection) return;
              myChangingSelection = true;
              var diagnodes = new go.Set();
              myDiagram.selection.each(n => diagnodes.add(myTreeView.findNodeForData(n.data)));
              myTreeView.clearSelection();
              myTreeView.selectCollection(diagnodes);
              myChangingSelection = false;
            }
          });

      var myChangingSelection = false;  // to protect against recursive selection changes

      // when the document is modified, add a "*" to the title and enable the "Save" button
      myDiagram.addDiagramListener("Modified", e => {
        var button = document.getElementById("saveModel");
        if (button) button.disabled = !myDiagram.isModified;
        var idx = document.title.indexOf("*");
        if (myDiagram.isModified) {
          if (idx < 0) document.title += "*";
        } else {
          if (idx >= 0) document.title = document.title.slice(0, idx);
        }
      });

      // There are two templates for Groups, "OfGroups" and "OfNodes".

      // this function is used to highlight a Group that the selection may be dropped into
      function highlightGroup(e, grp, show) {
        if (!grp) return;
        e.handled = true;
        if (show) {
          // cannot depend on the grp.diagram.selection in the case of external drag-and-drops;
          // instead depend on the DraggingTool.draggedParts or .copiedParts
          var tool = grp.diagram.toolManager.draggingTool;
          var map = tool.draggedParts || tool.copiedParts;  // this is a Map
          // now we can check to see if the Group will accept membership of the dragged Parts
          if (grp.canAddMembers(map.toKeySet())) {
            grp.isHighlighted = true;
            return;
          }
        }
        grp.isHighlighted = false;
      }

      // Upon a drop onto a Group, we try to add the selection as members of the Group.
      // Upon a drop onto the background, or onto a top-level Node, make selection top-level.
      // If this is OK, we're done; otherwise we cancel the operation to rollback everything.
      function finishDrop(e, grp) {
        var ok = (grp !== null
          ? grp.addMembers(grp.diagram.selection, true)
          : e.diagram.commandHandler.addTopLevelParts(e.diagram.selection, true));
        if (!ok) e.diagram.currentTool.doCancel();
      }

      myDiagram.groupTemplateMap.add("OfGroups",
        $(go.Group, go.Panel.Auto,
          {
            background: "transparent",
            // highlight when dragging into the Group
            mouseDragEnter: (e, grp, prev) => highlightGroup(e, grp, true),
            mouseDragLeave: (e, grp, next) => highlightGroup(e, grp, false),
            computesBoundsAfterDrag: true,
            // when the selection is dropped into a Group, add the selected Parts into that Group;
            // if it fails, cancel the tool, rolling back any changes
            mouseDrop: finishDrop,
            handlesDragDropForMembers: true,  // don't need to define handlers on member Nodes and Links
            // Groups containing Groups lay out their members horizontally
            layout:
              $(go.GridLayout,
                {
                  wrappingWidth: Infinity, alignment: go.GridLayout.Position,
                  cellSize: new go.Size(1, 1), spacing: new go.Size(4, 4)
                })
          },
          new go.Binding("background", "isHighlighted", h => h ? "rgba(255,0,0,0.2)" : "transparent").ofObject(),
          $(go.Shape, "Rectangle",
            { fill: null, stroke: "#E69900", strokeWidth: 2 }),
          $(go.Panel, go.Panel.Vertical,  // title above Placeholder
            $(go.Panel, go.Panel.Horizontal,  // button next to TextBlock
              { stretch: go.GraphObject.Horizontal, background: "#FFDD33", margin: 1 },
              $("SubGraphExpanderButton",
                { alignment: go.Spot.Right, margin: 5 }),
              $(go.TextBlock,
                {
                  alignment: go.Spot.Left,
                  editable: true,
                  margin: 5,
                  font: "bold 18px sans-serif",
                  stroke: "#9A6600"
                },
                new go.Binding("text", "text").makeTwoWay())
            ),  // end Horizontal Panel
            $(go.Placeholder,
              { padding: 5, alignment: go.Spot.TopLeft })
          )  // end Vertical Panel
        ));  // end Group and call to add to template Map

      myDiagram.groupTemplateMap.add("OfNodes",
        $(go.Group, go.Panel.Auto,
          {
            background: "transparent",
            ungroupable: true,
            // highlight when dragging into the Group
            mouseDragEnter: (e, grp, prev) => highlightGroup(e, grp, true),
            mouseDragLeave: (e, grp, next) => highlightGroup(e, grp, false),
            computesBoundsAfterDrag: true,
            // when the selection is dropped into a Group, add the selected Parts into that Group;
            // if it fails, cancel the tool, rolling back any changes
            mouseDrop: finishDrop,
            handlesDragDropForMembers: true,  // don't need to define handlers on member Nodes and Links
            // Groups containing Nodes lay out their members vertically
            layout:
              $(go.GridLayout,
                {
                  wrappingColumn: 1, alignment: go.GridLayout.Position,
                  cellSize: new go.Size(1, 1), spacing: new go.Size(4, 4)
                })
          },
          new go.Binding("background", "isHighlighted", h => h ? "rgba(255,0,0,0.2)" : "transparent").ofObject(),
          $(go.Shape, "Rectangle",
            { fill: null, stroke: "#0099CC", strokeWidth: 2 }),
          $(go.Panel, go.Panel.Vertical,  // title above Placeholder
            $(go.Panel, go.Panel.Horizontal,  // button next to TextBlock
              { stretch: go.GraphObject.Horizontal, background: "#33D3E5", margin: 1 },
              $("SubGraphExpanderButton",
                { alignment: go.Spot.Right, margin: 5 }),
              $(go.TextBlock,
                {
                  alignment: go.Spot.Left,
                  editable: true,
                  margin: 5,
                  font: "bold 16px sans-serif",
                  stroke: "#006080"
                },
                new go.Binding("text", "text").makeTwoWay())
            ),  // end Horizontal Panel
            $(go.Placeholder,
              { padding: 5, alignment: go.Spot.TopLeft })
          )  // end Vertical Panel
        ));  // end Group and call to add to template Map

      // Nodes have a trivial definition
      myDiagram.nodeTemplate =
        $(go.Node, go.Panel.Auto,
          { // dropping on a Node is the same as dropping on its containing Group, even if it's top-level
            mouseDrop: (e, nod) => finishDrop(e, nod.containingGroup)
          },
          $(go.Shape, "Rectangle",
            { fill: "#ACE600", stroke: "#558000", strokeWidth: 2 },
            new go.Binding("fill", "color")),
          $(go.TextBlock,
            {
              margin: 5,
              editable: true,
              font: "bold 13px sans-serif",
              stroke: "#446700"
            },
            new go.Binding("text", "text").makeTwoWay())
        );

      var myChangingModel = false;  // to protect against recursive model changes

      myDiagram.addModelChangedListener(e => {
        if (e.model.skipsUndoManager) return;
        if (myChangingModel) return;
        myChangingModel = true;
        // don't need to start/commit a transaction because the UndoManager is shared with myTreeView
        if (e.modelChange === "nodeGroupKey" || e.modelChange === "nodeParentKey") {
          // handle structural change: group memberships
          var treenode = myTreeView.findNodeForData(e.object);
          if (treenode !== null) treenode.updateRelationshipsFromData();
        } else if (e.change === go.ChangedEvent.Property) {
          var treenode = myTreeView.findNodeForData(e.object);
          if (treenode !== null) treenode.updateTargetBindings();
        } else if (e.change === go.ChangedEvent.Insert && e.propertyName === "nodeDataArray") {
          // pretend the new data isn't already in the nodeDataArray for myTreeView
          myTreeView.model.nodeDataArray.splice(e.newParam, 1);
          // now add to the myTreeView model using the normal mechanisms
          myTreeView.model.addNodeData(e.newValue);
        } else if (e.change === go.ChangedEvent.Remove && e.propertyName === "nodeDataArray") {
          // remove the corresponding node from myTreeView
          var treenode = myTreeView.findNodeForData(e.oldValue);
          if (treenode !== null) myTreeView.remove(treenode);
        }
        myChangingModel = false;
      });

      // setup the tree view; will be initialized with data by the load() function
      myTreeView =
        $(go.Diagram, "myTreeView",
          {
            initialContentAlignment: go.Spot.TopLeft,
            allowMove: false,  // don't let users mess up the tree
            allowCopy: true,  // but you might want this to be false
            "commandHandler.copiesTree": true,
            "commandHandler.copiesParentKey": true,
            allowDelete: true,  // but you might want this to be false
            "commandHandler.deletesTree": true,
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
                  setsChildPortSpot: false,
                  arrangementSpacing: new go.Size(0, 0)
                }),
            // when a node is selected in the tree, select the corresponding node in the main diagram
            "ChangedSelection": e => {
              if (myChangingSelection) return;
              myChangingSelection = true;
              var diagnodes = new go.Set();
              myTreeView.selection.each(n => diagnodes.add(myDiagram.findNodeForData(n.data)));
              myDiagram.clearSelection();
              myDiagram.selectCollection(diagnodes);
              myChangingSelection = false;
            }
          });

      myTreeView.nodeTemplate =
        $(go.Node,
          // no Adornment: instead change panel background color by binding to Node.isSelected
          { selectionAdorned: false },
          $("TreeExpanderButton",
            {
              width: 14,
              "ButtonBorder.fill": "white",
              "ButtonBorder.stroke": null,
              "_buttonFillOver": "rgba(0,128,255,0.25)",
              "_buttonStrokeOver": null
            }),
          $(go.Panel, "Horizontal",
            { position: new go.Point(16, 0) },
            new go.Binding("background", "isSelected", s => s ? "lightblue" : "white").ofObject(),
            // Icon is not needed?
            //$(go.Picture,
            //  {
            //    width: 14, height: 14,
            //    margin: new go.Margin(0, 4, 0, 0),
            //    imageStretch: go.GraphObject.Uniform,
            //    source: "images/50x40.png"
            //  }),
            $(go.TextBlock,
              { editable: true },
              new go.Binding("text").makeTwoWay())
          )  // end Horizontal Panel
        );  // end Node

      // without lines
      myTreeView.linkTemplate = $(go.Link);

      // cannot share the model itself, but can share all of the node data from the main Diagram,
      // pretending the "group" relationship is the "tree parent" relationship
      myTreeView.model = new go.TreeModel( { nodeParentKeyProperty: "group" });

      myTreeView.addModelChangedListener(e => {
        if (e.model.skipsUndoManager) return;
        if (myChangingModel) return;
        myChangingModel = true;
        // don't need to start/commit a transaction because the UndoManager is shared with myDiagram
        if (e.modelChange === "nodeGroupKey" || e.modelChange === "nodeParentKey") {
          // handle structural change: tree parent/children
          var node = myDiagram.findNodeForData(e.object);
          if (node !== null) node.updateRelationshipsFromData();
        } else if (e.change === go.ChangedEvent.Property) {
          // propagate simple data property changes back to the main Diagram
          var node = myDiagram.findNodeForData(e.object);
          if (node !== null) node.updateTargetBindings();
        } else if (e.change === go.ChangedEvent.Insert && e.propertyName === "nodeDataArray") {
          // pretend the new data isn't already in the nodeDataArray for the main Diagram model
          myDiagram.model.nodeDataArray.splice(e.newParam, 1);
          // now add to the myDiagram model using the normal mechanisms
          myDiagram.model.addNodeData(e.newValue);
        } else if (e.change === go.ChangedEvent.Remove && e.propertyName === "nodeDataArray") {
          // remove the corresponding node from the main Diagram
          var node = myDiagram.findNodeForData(e.oldValue);
          if (node !== null) myDiagram.remove(node);
        }
        myChangingModel = false;
      });

      load();
    }

    // save a model to and load a model from JSON text, displayed below the Diagram
    function save() {
      document.getElementById("mySavedModel").value = myDiagram.model.toJson();
      myDiagram.isModified = false;
    }
    function load() {
      myDiagram.model = go.Model.fromJson(document.getElementById("mySavedModel").value);

      // share all of the data with the tree view
      myTreeView.model.nodeDataArray = myDiagram.model.nodeDataArray;

      // share the UndoManager too!
      myTreeView.model.undoManager = myDiagram.model.undoManager;
    }
    window.addEventListener('DOMContentLoaded', init);
  </script>

					<div>
						<div style="width: 100%; display: flex; justify-content: space-between;">
							<div id="myTreeView" style="width: 200px;"></div>
							<div id="myDiagramDiv" style="height: 300px;"></div>
						</div>
						<textarea id="mySavedModel" style="display: none;">
						{ "class": "go.GraphLinksModel",
						  "nodeDataArray": [
						{"key":1, "text":"내 드라이브", "isGroup":true, "category":"OfGroups"},
						{"key":2, "text":"부서 드라이브", "isGroup":true, "category":"OfGroups"},
						{"key":3, "text":"TEST A", "isGroup":true, "category":"OfNodes", "group":1},
						{"key":4, "text":"TEST B", "isGroup":true, "category":"OfNodes", "group":1},
						{"key":5, "text":"TEST C", "isGroup":true, "category":"OfNodes", "group":2},
						{"key":6, "text":"TEST D", "isGroup":true, "category":"OfNodes", "group":2},						
						{"text":"파일 A이나 폴더", "group":3, "key":-7},
						{"text":"파일 B 폴더만?", "group":4, "key":-9},
						{"text":"파일 C", "group":5, "key":-12},
						{"text":"파일 C", "group":5, "key":-13},
						{"text":"파일 D", "group":6, "key":-14},
						{"text":"하위 없음", "group":7, "key":-15}
						 ],
						  "linkDataArray": [  ]}
						  </textarea>
					</div>
				</div>
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
							<button>다운로드</button>
							|
							<button>삭제</button>
							|
							<button data-bs-toggle="modal" data-bs-target="#moveFolder">이동</button>
							|
							<button data-bs-toggle="modal" data-bs-target="#addFolder">폴더
								추가</button>
							<div class="search">
								<form method="GET" name="search" action="">
									<input type="text" name="keyword" id="search"
										placeholder="검색어 입력">
									<button type="submit" name="btnSearch" id="btnSearch">
										<i class="fa fa-search"></i>
									</button>
									</td> <input type="hidden" name="pageNum" value="1"> <input
										type="hidden" name="amount" value="10">
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

					<div id="pagingArea"
						style="display: flex; justify-content: center;">
						<ul class="pagination">
							<c:choose>
								<c:when test="${ pi.currentPage ne 1 }">
									<li class="page-item"><a class="page-link"
										href="deptView.do?currentPage=${ pi.currentPage-1 }">Previous</a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item disabled"><a class="page-link"
										href="">Previous</a></li>
								</c:otherwise>
							</c:choose>

							<c:forEach begin="${ pi.startPage }" end="${ pi.endPage }"
								var="p">
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
		<div class="modal fade" id="addFolder" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
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

		<div class="modal fade" id="moveFolder" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">이동할 폴더 선택</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary">이동</button>
						<button type="button" class="btn btn-secondary"
							data-bs-target="#addFolder" data-bs-toggle="modal"
							data-bs-dismiss="modal">폴더 추가</button>
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">취소</button>
					</div>
				</div>
			</div>
		</div>
</body>
</html>