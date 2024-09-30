package algo;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Stack;

public class IDS extends QingFun{
    private Stack<Node> stack;
    private int maxDepth = 1000;
    private int currDepth;

    public IDS() {
        this.stack = new Stack<>();
        this.currDepth = 0;
    }

    @Override
    public void addNode(Node node) {
        stack.push(node);
    }

    @Override
    public Node removeNode() {
        return stack.pop();
    }

    @Override
    public boolean isEmpty() {
        return stack.isEmpty();
    }

//    @Override
//    public int evalFunc(int layersPoured, WaterBottle[] waterBottles) {
//
//        return layersPoured;
//    }

    public int getMaxDepth() {
        return maxDepth;
    }
    public int getCurrDepth(){
        return currDepth;
    }
    public void setCurrDepth(int newCurrDepth){
        this.currDepth = newCurrDepth;
    }
    public void setSeen(HashSet<Node> newSeen){
        this.seen = newSeen;
    }
}
