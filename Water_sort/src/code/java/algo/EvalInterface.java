package algo;

import algo.Node;
import algo.WaterBottle;

public interface EvalInterface {
    int evalFunc(Node node);
    int heuristic(WaterBottle[] waterBottles);
}