package algo;

import java.util.LinkedList;
import java.util.Queue;

public class BFS extends QingFun{
    private Queue<Node> q;

    public BFS(){
        this.q = new LinkedList<>();
    }

    public void addNode(Node node){
        q.add(node);
    }

    public Node removeNode(){
        return q.poll();
    }

    public boolean isEmpty(){
        return q.isEmpty();
    }

//    public int evalFunc(int layersPoured, WaterBottle[] waterBottles){
//        return layersPoured;
//    }
}
