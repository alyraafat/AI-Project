package algo;

import java.util.LinkedList;
import java.util.PriorityQueue;

public abstract class Greedy extends QingFun {
    private PriorityQueue<Node> pq;
    public Greedy(){
        this.pq = new PriorityQueue<>((node1, node2) -> Integer.compare(evalFunc(node1.cost, node1.waterBottles), evalFunc(node2.cost, node2.waterBottles)));
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

    public int evalFunc(int layersPoured, WaterBottle[] waterBottles){
        return this.heuristic(waterBottles);
    }
    public abstract int heuristic(WaterBottle[] waterBottles);
}
