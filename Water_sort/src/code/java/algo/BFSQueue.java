package algo;

import java.util.LinkedList;
import java.util.Queue;

public class BFSQueue extends QingFun{
    Queue<Node> q;

    public BFSQueue(){
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
}
