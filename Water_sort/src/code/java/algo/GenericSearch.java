package algo;

import java.util.ArrayList;
import java.util.function.Function;

public abstract class GenericSearch {
    int nodesExpanded;

    public abstract boolean goalFunc(Node n);

    public Node generalSearch(Node initNode, QingFun qingFun){
        qingFun.addNode(initNode);
//        int i = 0;
        while(!qingFun.isEmpty()){
//            System.out.println("here");
            Node currNode = qingFun.removeNode();
//            System.out.println("here2");
            if(this.goalFunc(currNode)) return currNode;
//            System.out.println("here3");
            ArrayList<Node> children = currNode.get_children();
//            System.out.println("here4");
            this.nodesExpanded += 1;
//            System.out.println("here5");
            qingFun.addNodes(children);
//            System.out.println("here6");
//            System.out.println(++i);
        }
        return null;
    }

}
