import java.util.ArrayList;
import java.util.HashSet;

public abstract class QingFun {
    HashSet<Node> seen;
//    TreeSet<Node> seen;
//    Comparator<Node> nodeComparator;
    public QingFun(){
//        this.nodeComparator = (n1, n2) -> {
//            int contentComparison = n1.toString().compareTo(n2.toString());
//            if (contentComparison != 0) {
//                return contentComparison;
//            }
//            // If contents are the same, compare by cost (smaller cost comes first)
//            return Integer.compare(n1.cost, n2.cost);
//        };
//        this.seen = new TreeSet<>(nodeComparator);
        this.seen = new HashSet<>();
    }
    public abstract void addNode(Node node);
    public void addNodes(ArrayList<Node> nodes){
        for(Node n: nodes){
            if(!seen.contains(n)){
                addNode(n);
                this.addToSeen(n);
            }
        }
    }
    public abstract Node removeNode();
    public abstract boolean isEmpty();
    public void addToSeen(Node node){
        this.seen.add(node);
    }
}
