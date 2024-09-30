package algo;

import java.util.LinkedList;
import java.util.PriorityQueue;

public abstract class Greedy extends QingFun implements EvalInterface {
    private PriorityQueue<Node> pq;
    public Greedy(){
        this.pq = new PriorityQueue<>((node1, node2) -> Integer.compare(evalFunc(node1), evalFunc(node2)));
    }

    public void addNode(Node node){
        pq.add(node);
    }

    public Node removeNode(){
        return pq.poll();
    }

    public boolean isEmpty(){
        return pq.isEmpty();
    }

    public int evalFunc(Node node){
        return this.heuristic(node.waterBottles);
    }
    public abstract int heuristic(WaterBottle[] waterBottles);
}
