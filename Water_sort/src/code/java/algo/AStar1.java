package algo;

public class AStar1 extends AStar{
    @Override
    public int heuristic(WaterBottle[] waterBottles) {
        // return the number of different colors in the bottle with the most different colors 
        int max_diff_layers = 1;
        for (WaterBottle waterBottle : waterBottles) {
            max_diff_layers = Math.max(max_diff_layers, waterBottle.getNumberOfDifferentColors());
        }
        return max_diff_layers - 1;
    }
}
