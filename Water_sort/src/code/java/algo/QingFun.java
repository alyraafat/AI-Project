package algo;

import java.util.ArrayList;

public abstract class QingFun {

    public abstract void addNode(Node node);
    public void addNodes(ArrayList<Node> nodes){
        for(Node n: nodes){
            addNode(n);
        }
    }
    public abstract Node removeNode();
    public abstract boolean isEmpty();

}
