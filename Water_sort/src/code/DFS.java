import java.util.Stack;

public class DFS extends QingFun {
    private Stack<Node> stack;

    public DFS() {
        this.stack = new Stack<>();
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
}
