package algo;

import java.util.LinkedList;
import java.util.PriorityQueue;

public abstract class AStar extends QingFun {
    private PriorityQueue<Node> pq;
    public AStar(){
        this.pq = new PriorityQueue<>((node1, node2) -> Integer.compare(node1.cost, node2.cost));
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
        return layersPoured + this.heuristic(waterBottles);
    }
    public abstract int heuristic(WaterBottle[] waterBottles);
}
