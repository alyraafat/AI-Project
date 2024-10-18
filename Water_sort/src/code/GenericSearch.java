import java.util.ArrayList;

public abstract class GenericSearch {
    int nodesExpanded;

    public abstract boolean goalFunc(Node n);

    public Node generalSearch(Node initNode, QingFun qingFun){
        qingFun.addNode(initNode);
//        int i = 0;
        boolean allNodesDepthLessThanCurrDepth = true;
        while(!qingFun.isEmpty()){
//            System.out.println("here");
            Node currNode = qingFun.removeNode();
//            System.out.println("here2");
            if(this.goalFunc(currNode)) return currNode;
//            System.out.println("here3");

            // added change for IDS
            if(qingFun instanceof IDS && currNode.depth == ((IDS)qingFun).getCurrDepth()) {
                allNodesDepthLessThanCurrDepth = false;
                continue;
            }

            ArrayList<Node> children = currNode.get_children();
//            System.out.println("here4");
            this.nodesExpanded += 1;
//            System.out.println("here5");
            qingFun.addNodes(children);
//            System.out.println("here6");
//            System.out.println(++i);
        }
        if(allNodesDepthLessThanCurrDepth && qingFun instanceof IDS){
            ((IDS)qingFun).setAllNodesDepthLessThanCurrDepth(true);
        }
        return null;
    }



}
