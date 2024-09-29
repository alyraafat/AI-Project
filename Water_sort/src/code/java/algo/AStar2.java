package algo;

public class AStar2 extends AStar{
    @Override
    public int heuristic(WaterBottle[] waterBottles) {
        // return the number of bottles that are not filled with the same color
        int count = 0;
        for (WaterBottle waterBottle : waterBottles) {
            if (!waterBottle.isSameColor) {
                count++;
            }
        }
        return count;
    }
}
