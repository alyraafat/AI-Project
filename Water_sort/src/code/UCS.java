import java.util.PriorityQueue;

public class UCS extends QingFun{
    private PriorityQueue<Node> pq;
    public UCS(){
        this.pq = new PriorityQueue<>((node1, node2) -> Integer.compare(node1.cost, node2.cost));
    }
    @Override
    public void addNode(Node node) {
        pq.add(node);
    }

    @Override
    public Node removeNode() {
        return pq.poll();
    }

    @Override
    public boolean isEmpty() {
        return pq.isEmpty();
    }
}
