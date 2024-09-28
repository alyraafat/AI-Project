package algo;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.function.Function;

public abstract class QingFun {
    HashSet<Node> seen = new HashSet<>();
    public abstract void addNode(Node node);
    public void addNodes(ArrayList<Node> nodes){
        for(Node n: nodes){
            if(!seen.contains(n)){
                addNode(n);
                seen.add(n);
            }
        }
    }
    public abstract Node removeNode();
    public abstract boolean isEmpty();
    public abstract int evalFunc(int layersPoured);

}
